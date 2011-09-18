// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
    
    var sidebarPopup = $('#sidebar_popup');
    var unselectSidebarOptions = function(){
        $('#sidebar .record_relation.selected').removeClass('selected');
    }
    var closeSidebarPopup = function(){
        unselectSidebarOptions();
        sidebarPopup.hide();  
    }
    
    $('#sidebar .record_relation:not(.inactive)').click(function(event){
        if ($(this).hasClass('selected')){
            closeSidebarPopup();
        } else {
            unselectSidebarOptions();
            $(this).addClass('selected')
            sidebarPopup.html($(this).attr('related_records'))
            sidebarPopup.show();
        }
        event.stopPropagation();
    })
    
    // Hide the sidebar popup when the document is clicked
    $('body').click(function(event){
        if (event.target != sidebarPopup[0]){
            closeSidebarPopup();
        }
    });
    
});