const check = () => {
  $.get('/notifications');
}

$(document).on('turbolinks:load', () => {
  clearInterval(window.interval);
  window.interval = setInterval(check, 5000);
});
