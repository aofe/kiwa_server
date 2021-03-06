// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require modernizr
//= require bootstrap
//= require easy_menu_jquery
//= require glint_autocomplete
//= require popup_gallery
//= require_tree ./shared


// Update the state of a modal that is saving via ajax
$(document).on('ajax:beforeSend', '.modal', function(){
  $(this).attr('data-state', 'submitting')
})
$(document).on('ajax:success', '.modal', function(){
  var element = $(this);
  element.attr('data-state', 'success')
  setTimeout(function(){element.modal('hide')}, 1000)
  setTimeout(function(){element.removeAttr('data-state')}, 1500)
})

$(document).on('ajax:error', '.modal', function(){
  var element = $(this);
  element.attr('data-state', 'error')
  setTimeout(function(){element.removeAttr('data-state')}, 1500)
})

isMobile = {
    Android: function() {
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
        return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
};