// Update the modal with the details of the clicked item
$(document).on('click', 'a.save_to_project', function(){
  $('#add_to_project_modal .item_type').val($(this).data('item-type'))
  $('#add_to_project_modal .item_id').val($(this).data('item-id'))
})

$(document).on('keyup', '.project_item_notes_form textarea, .project_item_notes_form input', function(){
  var textarea = this
  if (textarea.defaultValue != textarea.value){
    textarea.defaultValue = textarea.value;
    clearTimeout(textarea.typingTimeout)
    textarea.typingTimeout = setTimeout(function(){
      $(textarea.form).find('input[type=submit]').click();
    }, 250)    
  }    
})