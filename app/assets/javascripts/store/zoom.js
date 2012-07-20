var add_image_handlers = function() {
  $("#main-image").data('selectedThumb', $('#main-image img').first().attr('src'));
  $('ul.thumbnails li').eq(0).addClass('selected');

  $('ul.thumbnails a').on('click', function(event) {
    // Append old image to gallery and remove new main-image from gallery to
    // prevent image duplication
    $('#gallery').append('<a class="fancybox" rel="gallery"><img src="' + $(".zoom-image").attr("href") + '" /></a>');
    $('#gallery a[href="' + $(this).data("original") + '"]').remove();

    $("#main-image").data('selectedThumb', $(event.currentTarget).attr('href'));
    $("#main-image").data('selectedThumbId', $(event.currentTarget).parent().attr('id'));
    $('a.zoom-image').attr('href', $(this).data('original'));
    $(this).mouseout(function() {
      $('ul.thumbnails li').removeClass('selected');
      $(event.currentTarget).parent('li').addClass('selected');
    });
    return false;
  });
  $('ul.thumbnails li').on('mouseenter', function(event) {
    $('#main-image img').first().attr('src', $(event.currentTarget).find('a').attr('href'));
  });
  $('ul.thumbnails li').on('mouseleave', function(event) {
    $('#main-image img').first().attr('src', $("#main-image").data('selectedThumb'));
  });
};

var show_variant_images = function(variant_id) {
  $('li.vtmb').hide();
  $('li.vtmb-' + variant_id).show();
  var currentThumb = $('#' + $("#main-image").data('selectedThumbId'));
  // if currently selected thumb does not belong to current variant, nor to common images,
  // hide it and select the first available thumb instead.
  if(!currentThumb.hasClass('vtmb-' + variant_id) && !currentThumb.hasClass('tmb-all')) {
    var thumb = $($('ul.thumbnails li:visible').eq(0));
    var newImg = thumb.find('a').attr('href');
    $('ul.thumbnails li').removeClass('selected');
    thumb.addClass('selected');
    $('#main-image img').first().attr('src', newImg);
    $("#main-image").data('selectedThumb', newImg);
    $("#main-image").data('selectedThumbId', thumb.attr('id'));
  }
}

$(document).ready(function() {
    $(".fancybox").fancybox();
});
