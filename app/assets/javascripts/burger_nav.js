(function() {
  var enableBurgers = function() {
    var $burgers = Array.prototype.slice.call(
      document.querySelectorAll(".navbar-burger"), 0
    );

    if ($burgers.length > 0) {
      $burgers.forEach(function ($el) {
        $el.addEventListener("click", function () {
          var target = $el.dataset.target;
          var $target = document.getElementById(target);
          $el.classList.toggle("is-active");
          $target.classList.toggle("is-active");
        });
      });
    }
  }

  window.addEventListener("turbolinks:load", enableBurgers);
})();
