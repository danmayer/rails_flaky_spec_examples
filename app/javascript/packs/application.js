// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("jquery");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

function animatedSubmit(e) {
  e.preventDefault();

  var form = e.target;
  var setAnimation = function() {
    return $(".post-submit")
      .data("animating", "now")
      .animate({ opacity: 0.1 }, 1930)
      .promise();
  };
  var complete = function() {
    form.submit();
  };
  $.when()
    .then(setAnimation)
    .then(complete);
}

// work on JS ajax race condition between count and generate
// function generateSubmit(e) {
//   e.preventDefault();
//
//   $.post('/posts/generate', function(data) {
//     $this.replaceWith(data);
//   });
// }

function load_remote_divs() {
  $("[data-load-url]").each(function() {
    var $this = $(this);
    $.get($this.data("load-url"), function(data) {
      $this.replaceWith(data);
    });
  });
}

$(document).on("turbolinks:load", function() {
  $(".post-form").on("submit", animatedSubmit);
  //$(".generate-submit").on("click", generateSubmit);
  load_remote_divs();
});
