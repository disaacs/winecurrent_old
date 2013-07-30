$(document).ready(function() {
  init();
});

// Listen for page:change to catch turbolinks changes.
$(document).on('page:change', function() {
  init();
});

function init() {
  $('#load-lcbo').click(function() {
    var $this = $(this);
    var lcbo = $('#wine_lcbo').val();
    $.get('/lcbo/products/'+lcbo, lcbo_product_success)
      .fail(function(jqXHR,textStatus,errorThrown) { 
        show_lcbo_error_message("An error has occurred. The wine loading service returned '"+errorThrown+"'");
      });
  });
  
  $('.wine-listing').click(function() {
    $('.reviews').slideUp();
    $(this).find('.reviews').slideDown();
  });
  
  // Filter the wine listings.
  // TODO: Properly handle filtering if the mouse is used to cut or paste.
  $('#filter').keyup(function() {
    filter_wine_list($(this));
  });
  
  $('.remove-review').click(function() {
    remove_review($(this));
    return false;
  });
}

/* Mark a review to be destroyed when the Remove Review buttons is clicked.
 */ 
function remove_review($remove_button) {
  $remove_button.prev().val(1);
  $remove_button.parent().slideUp();
}

/* Filter the wine list depending on the tags entered in the filter field.
 */
function filter_wine_list($filter) {
  var $wine_listings = $('.wine-listing');
  var filter_string = $filter.val();
  // If there is no filter string, then show everything and return.
  if (filter_string == null || filter_string.length == 0) {
    $wine_listings.each(function() { $(this).show() });
    return;
  }
  // Split the filter string into individual tags and compare the tags
  // from each wine listing to the tags.
  var filter_tags = filter_string.split(/\s+/);
  $wine_listings.each(function() {
    var $wine_listing = $(this);
    var tags = $wine_listing.find('.tags').text();
    if (tags != null && tags.length > 0) {
      tags = tags.toLowerCase();
      // Every tag must match for the match to be true.
      var match = true;
      for (var i = 0; i < filter_tags.length; i++) {
        if (tags.match(filter_tags[i]) == null) {
          match = false;
          break;
        }
      }
      // If a wine is matched, then show the listing. Otherwise hide it.
      if (match) {
        $wine_listing.show();
      } else {
        $wine_listing.hide();
      }
    }
  });
  
}

/* Callback function for successful LCBO API response.
 * Load the wine information into the form. Or display an
 * an error if no wine information was received.
 */
function lcbo_product_success(data, textStatus, jqXHR) {
  // Did an error occur?
  var error = null;
  if (textStatus != 'success') {
    error = 'The wine loading service returned '+textStatus+'.';
  } else if (data == null) {
    error = 'The wine loading service failed to return any data.';
  } else if (data.status != 200) {
    error = data.message;
  }
  if (error != null) {
    show_lcbo_error_message('An error has occurred: '+error);
  } else {
    // No errors :) Load the wine information into the form.
    hide_lcbo_error_messages();
    hide_lcbo_warning_messages();
    var wine = data.result;
    $('#wine_name').val(wine.name);
    $('#wine_varietal').val(wine.varietal);
    
    // The vintage may be embedded in the name (e.g., Lailey Merlot 2010).
    var vintage = wine.name.match(/\d{4}/);
    $('#wine_vintage').val(vintage);

    $('#wine_producer').val(wine.producer_name);
    $('#wine_origin').val(wine.origin);
    $('#wine_availability').val(wine.stock_type);
    $('#wine_alcohol').val(wine.alcohol_content/100);
    $('#wine_price').val(wine.price_in_cents/100);
    $('#wine_tags').val(wine.tags);
    
    if (wine.tasting_note != null && wine.tasting_note.length > 0) {
      $('#wine_reviews_attributes_0_review').val(wine.tasting_note);
      $('#wine_reviews_attributes_0_reviewer').val('LCBO Catalog');
    }
    
    if (wine.image_thumb_url != null && wine.image_thumb_url.length > 0) {
      $('#wine-thumb-image').attr('src', wine.image_thumb_url);
    }
    
    $.get('/wines/lcbo/'+wine.id, function(data, textStatus, jqXHR) {
      if (data != null) {
        show_lcbo_warning_message('WARNING! The wine with LCBO number '+wine.id+' already exists in your database. You will not be able to save this wine unless you change the LCBO number.');
      }
    });
  }
}

/* Set the lcbo error text and display it.
 */
function show_lcbo_error_message(message) {
  var $lcbo_messages = $('#lcbo-messages');
  var $error_message = $lcbo_messages.find('#error-message');
  $error_message.find('span').text(message);
  $error_message.slideDown();
}

/* Hide the lcbo error text.
 */
function hide_lcbo_error_messages() {
  $('#lcbo-messages #error-message').slideUp();
}

/* Set the lcbo warning text and display it.
 */
function show_lcbo_warning_message(message) {
  var $lcbo_messages = $('#lcbo-messages');
  var $warning_message = $lcbo_messages.find('#warning-message');
  $warning_message.find('span').text(message);
  $warning_message.slideDown();
}

/* Hide the lcbo warning text.
 */
function hide_lcbo_warning_messages() {
  $('#lcbo-messages #warning-message').slideUp();
}
