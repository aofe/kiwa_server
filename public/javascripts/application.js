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