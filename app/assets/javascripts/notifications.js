function check() {
  $.get('/notifications');
}

$(document).on('turbolinks:load', function() {
  clearInterval(window.interval);
  window.interval = setInterval(check, 5000);
});
