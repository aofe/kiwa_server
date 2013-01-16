// Warn the user if they click on something that takes them out of the downloaded content
$(document).on('click', 'a[href^="http"]', function(event){
  if (!confirm("This link requires an Internet connection. Continue?")){
    event.preventDefault()
  }
})