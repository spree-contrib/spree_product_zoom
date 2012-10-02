var add_image_handlers, show_variant_images, update_variant_price;

add_image_handlers = function() {
  // Remove duplicate image from gallery
  $("#main-image a.large-image").click(function(event) {
    $('#main-image a.click-to-zoom').attr('rel', '');
  });

  // Remove duplicate image from gallery
  $("#main-image a.click-to-zoom").click(function(event) {
    $('#main-image a.large-image').attr('rel', '');
  });

  ($('#main-image')).data('selectedThumb', ($('#main-image img')).attr('src'));
  ($('ul.thumbnails li')).eq(0).addClass('selected');
  ($('ul.thumbnails a')).on('click', function(event) {
    // Append old image to gallery and remove new main-image from gallery to
    // prevent image duplication
    $('#gallery').append('<a class="fancybox" rel="gallery"><img src="' + $(".zoom-image").attr("href") + '" /></a>');
    $('#gallery a[href="' + $(this).data("original") + '"]').remove();

    ($('#main-image')).data('selectedThumb', ($(event.currentTarget)).attr('href'));
    ($('#main-image')).data('selectedThumbId', ($(event.currentTarget)).parent().attr('id'));
    ($(this)).mouseout(function() {
      ($('ul.thumbnails li')).removeClass('selected');
      return ($(event.currentTarget)).parent('li').addClass('selected');
    });
    return false;
  });

  $('ul.thumbnails li').on('mouseenter', function(event) {
    $('.click-to-zoom').attr('src', '/assets/zoom.gif');
    // $('#main-image img').first().attr('src', $(event.currentTarget).find('a').attr('href'));
  });
  $('ul.thumbnails li').on('mouseleave', function(event) {
    $('.click-to-zoom').attr('src', '/assets/zoom.gif');
    // $('#main-image img').first().attr('src', $("#main-image").data('selectedThumb'));
  });
};

show_variant_images = function(variant_id) {
  var currentThumb, newImg, thumb;
  ($('li.vtmb')).hide();
  ($('li.vtmb-' + variant_id)).show();
  currentThumb = $('#' + ($('#main-image')).data('selectedThumbId'));
  if (!currentThumb.hasClass('vtmb-' + variant_id) && !currentThumb.hasClass('tmb-all')) {
    thumb = $(($('ul.thumbnails li:visible')).eq(0));
    newImg = thumb.find('a').attr('href');
    ($('ul.thumbnails li')).removeClass('selected');
    thumb.addClass('selected');
    ($('#main-image img')).attr('src', newImg);
    ($('#main-image')).data('selectedThumb', newImg);
    return ($('#main-image')).data('selectedThumbId', thumb.attr('id'));
  }
};

$(document).ready(function() {
    add_image_handlers();
    $('.click-to-zoom').attr('src', '/assets/zoom.gif');
    $(".fancybox").fancybox({
      'beforeClose': function() {
        $('#main-image a.click-to-zoom').attr('rel', 'gallery');
        $('#main-image a.large-image').attr('rel', 'gallery');
      }
    });
});
