require 'spec_helper'

feature "gallery", :js => true do

  before(:each) {
    Capybara.default_selector = :css

    products = Spree::Product.all
    if (products.size == 0)
      @product = create(:product1)
      @opt_type = create(:option_type1)
    end
  }

  scenario "product without options, two images" do
    attach_images(@product.master)

    visit "/products/#{@product.id}"
    within("div#main-image") do
      # ERROR zoom.gif is being overwritten here:
      # javascript product.js.coffee
      # showVariantImages ($('#main-image img')).attr('src', newImg);
      page.should have_selector("img", count: 2)
      # workaround is here:
      # javascript zoom.js.coffee show_variant_images
      # ($ 'img.click-to-zoom').attr 'src', "<%= asset_path('zoom.gif') %>"
      page.should have_css("img.zoom-click", count: 1)
      page.should have_css("img.click-to-zoom", count: 1)

      show_gallery

      page.should have_css("#gallery a.productid-#{@product.master.id}.fancybox", count: 2)
    end
  end


  scenario "product with option and one variant with two product master images" do
    @product.option_types << @opt_type
    variant1 = get_variant(1)

    attach_images(@product.master)

    visit "/products/#{@product.id}"
    page.should have_css("img.click-to-zoom", count: 1)

    show_gallery

    page.should have_css("#gallery a", count: 2)
    page.should have_css("#gallery a.productid-#{@product.master.id}.fancybox", count: 2)
  end


  scenario "product with 2 variants and 2 attached images to the master and second variant" do
    @product.option_types << @opt_type

    variant1 = get_variant(1)
    variant2 = get_variant(2)

    attach_images(@product.master)
    attach_images(variant2)

    visit "/products/#{@product.id}"
    page.should have_css("img.click-to-zoom", count: 1)

    show_gallery

    # 2 from master, 2 from variant
    page.should have_css("#gallery a", count: 4)
    # maybe only the master images should be shown?
    page.should have_css("#gallery a.fancybox", count: 4)
    page.should have_css("#gallery a.productid-#{@product.master.id}", count: 2)
    page.should have_css("#gallery a.productid-#{variant2.id}", count: 2)

    page.choose("variant_id_#{variant2.id}")
    page.should have_css("#gallery a.fancybox", count: 2)
    page.should have_css("#gallery a.productid-#{variant2.id}.fancybox", count: 2)
  end

  scenario "product with 2 variants and 2 attached images to each variant" do
    @product.option_types << @opt_type

    variant1 = get_variant(1)
    variant2 = get_variant(2)

    attach_images(variant1)
    attach_images(variant2)

    visit "/products/#{@product.id}"
    page.should have_css("img.click-to-zoom", count: 1)

    show_gallery

    page.should have_css("#gallery a", count: 4)
    page.should have_css("#gallery a.fancybox", count: 2)
    page.should have_css("#gallery a.productid-#{variant1.id}.fancybox", count: 2)
    page.should have_css("#gallery a.productid-#{variant2.id}", count: 2)


    page.choose("variant_id_#{variant2.id}")
    page.should have_css("#gallery a.fancybox", count: 2)
    page.should have_css("#gallery a.productid-#{variant2.id}.fancybox", count: 2)
  end

  def show_gallery
    # gallery is hidden, selenium-webdriver only knows visible elements
    page.execute_script '$("#gallery").show()'
  end

  def get_variant(nr)
    optnme = "option_value#{nr}"
    opt_vlue = build(optnme.to_sym)
    opt_vlue.option_type = @opt_type
    opt_vlue.save

    varnme = "variant#{nr}"
    variant = build(varnme.to_sym)
    variant.product = @product
    variant.option_values << opt_vlue
    variant.save
    variant
  end

  def attach_images(product)
    img = build(:image1)
    img.viewable = product
    img.save

    img = build(:image2)
    img.viewable = product
    img.save
  end
end
