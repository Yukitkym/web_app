$(document).ready(function() {
  var menuHeight = $("#fixed-header").height();
  var startPos = 0;
  $(window).scroll(function(){
    var currentPos = $(this).scrollTop();
    if (currentPos > startPos) {
      if($(window).scrollTop() >= 200) {
        $("#fixed-header").css("top", "-" + menuHeight + "px");
      }
    } else {
      $("#fixed-header").css("top", 0 + "px");
    }
    startPos = currentPos;
  });
});