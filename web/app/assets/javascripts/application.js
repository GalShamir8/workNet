// = require jquery
// = require jquery_ujs
//= require bootstrap

// Infinite scrollng
$(document).ready(function() {
  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $('.pagination .next_page').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').text("Please Wait...");
        return $.getScript(url);
      }
    });
    return $(window).scroll();
  }
});

// search results on text input change
$(document).ready(function() {
  $(document).on('change textInput input', '.search', function() {  
    document.getElementById("submit").click()
  });
});
