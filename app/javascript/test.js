$(function(){
    $("#alert").fadeOut(5000);
});

$(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
    $('#img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $("#img").change(function(){
        readURL(this);
    });
});

$(function(){
  $('#hamburger').on('click', function(){
        $('.icon').toggleClass('close');
        $('.sm').slideToggle();
  });
});

$(function(){
  $('.sub-menu').on('click', function(){
    $('.dropdown-menu').slideToggle();
  });
})
