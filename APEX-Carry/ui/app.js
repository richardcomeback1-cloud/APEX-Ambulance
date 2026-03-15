$(document).ready(function () {
  let TimeToHide = 0
  HitScreen = null
  window.addEventListener("message", function (event) {
    if (event.data.action == "Hide") {
      $(`.ui`).fadeOut(500)
    }
    if (event.data.action == "Show") {
      $(`.ui`).fadeIn(500).css({ 'background-image': `url(./img/phase${event.data.Phase}.png)`, 'display': 'flex' })
    }
  });
});
