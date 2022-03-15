$(function () {

  //ページ内スクロール
  var navHeight = $(".header").outerHeight();

  $('a[href^="#"]').on("click", function () {
    var href = $(this).attr("href");
    var target = $(href == "#" || href == "" ? "html" : href);
    var position = target.offset().top - navHeight;
    $("html, body").animate({ scrollTop: position, }, 300, "swing");
    return false;
  });

  //ページトップ
  $("#js-page-top").on("click", function () {
    $("body,html").animate({ scrollTop: 0, }, 300);
    return false;
  });

});

// modal

const modalWrapper = document.querySelector('.modal-wrapper');
const images = document.querySelectorAll('.image');
const modalImage = document.querySelector('.modal-image');

images.forEach(function(image) {
  image.addEventListener('click', function(){
    modalWrapper.classList.add('show');
    modalImage.classList.add('show');

    let imageSrc = image.getAttribute('data-src');
    modalImage.src = imageSrc;
  });
});

modalWrapper.addEventListener('click', function(){
  if (this.classList.contains('show')) {
    this.classList.remove('show');
    modalImage.classList.remove('show');
  }
})
