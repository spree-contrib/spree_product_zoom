include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :product1, class: Spree::Product do
    name "Some Product"
    available_on { 1.year.ago }
    shipping_category_id 1
    tax_category_id 1
    price 29.99
    sku 'p1v'
  end

  factory :variant1, class: Spree::Variant do
    sku 'p1v1'
    is_master '0'
  end
  factory :variant2, class: Spree::Variant do
    sku 'p1v2'
    is_master '0'
  end

  factory :option_type1, class: Spree::OptionType do
    name "opt"
    presentation "Some Option"
  end
  factory :option_value1, class: Spree::OptionValue do
    name "a"
    presentation "a option value"
  end
  factory :option_value2, class: Spree::OptionValue do
    name "b"
    presentation "b option value"
  end



  factory :image1, class: Spree::Image do
    attachment_content_type "image/jpeg"
    attachment_file_name "product1.jpg"
    alt "Product Image 1"
  end
  factory :image2, class: Spree::Image do
    attachment_content_type "image/jpeg"
    attachment_file_name "product2.jpg"
    alt "Product Image 2"
  end
end
