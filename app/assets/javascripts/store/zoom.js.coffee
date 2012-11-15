add_image_handlers = ->
  ($ '#main-image').data 'selectedThumb', ($ '#main-image img').attr('src')
  ($ 'ul.thumbnails li').eq(0).addClass 'selected'
  ($ 'ul.thumbnails a').on 'click', (event) ->
    ($ '#main-image').data 'selectedThumb', ($ event.currentTarget).attr('href')
    ($ '#main-image').data 'selectedThumbId', ($ event.currentTarget).parent().attr('id')
    ($ this).mouseout ->
      ($ 'ul.thumbnails li').removeClass 'selected'
      ($ event.currentTarget).parent('li').addClass 'selected'
    false

  ($ 'ul.thumbnails li').on 'mouseenter', (event) ->
    ($ 'img.click-to-zoom').attr 'src', '/assets/zoom.gif'
    ($ '#main-image img').first().attr 'src', ($ event.currentTarget).find('a').attr('href')

  ($ 'ul.thumbnails li').on 'mouseleave', (event) ->
    ($ 'img.click-to-zoom').attr 'src', '/assets/zoom.gif'
    ($ '#main-image img').first().attr 'src', ($ '#main-image').data('selectedThumb')

  ($ 'img.click-to-zoom').on 'click', (event) ->
    ($ '.fancybox')[0].click()
    event.preventDefault()

show_variant_images = (variant_id) ->
  ($ 'li.vtmb').hide()
  ($ 'li.vtmb-' + variant_id).show()
  currentThumb = ($ '#' + ($ '#main-image').data('selectedThumbId'))
  if not currentThumb.hasClass('vtmb-' + variant_id) and not currentThumb.hasClass('tmb-all')
    thumb = ($ ($ 'ul.thumbnails li:visible').eq(0))
    newImg = thumb.find('a').attr('href')
    ($ 'ul.thumbnails li').removeClass 'selected'
    thumb.addClass 'selected'
    ($ '#main-image img').attr 'src', newImg
    ($ '#main-image').data 'selectedThumb', newImg
    ($ '#main-image').data 'selectedThumbId', thumb.attr('id')

update_variant_price = (variant) ->
  variant_price = variant.data('price')
  ($ '.price.selling').text(variant_price) if variant_price

$ ->
  ($ 'img.click-to-zoom').attr 'src', '/assets/zoom.gif'
  add_image_handlers()
  show_variant_images ($ '#product-variants input[type="radio"]').eq(0).attr('value') if ($ '#product-variants input[type="radio"]').length > 0
  ($ '#product-variants input[type="radio"]').click (event) ->
    show_variant_images @value
    update_variant_price ($ this)
  ($ '.fancybox').fancybox()
