$(function() {
  $('#change_tag').change(function() {
    location.href = './' + $(this).val();
  });
})
