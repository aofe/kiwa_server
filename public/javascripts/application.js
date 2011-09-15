$(function() {
    
    var sidebarPopup = $('#sidebar_popup');
    $('#sidebar .record_relation:not(.inactive)').click(function(){
        $('#sidebar .record_relation.selected').removeClass('selected');
        if ($(this).hasClass('selected')){
            sidebarPopup.hide()
        } else {
            $(this).addClass('selected')
            sidebarPopup.html($(this).attr('related_records'))
            sidebarPopup.show();
        }
        event.stopPropagation();
    })
    
    // Hide the sidebar popup when the document is clicked
    $('body').click(function(event){
        if (event.target != sidebarPopup[0]){
            sidebarPopup.hide();            
        }
    });
    
});