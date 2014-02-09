(function($){

  $.fn.headnotsmart = function(){
    var contentElement = $(this)
    setHeaders()

    function setHeaders(){
      $('#main_content').children('h1').addClass('header-level-1');
      $('#main_content').children('h2').addClass('header-level-2');
      $('#main_content').children('h3').addClass('header-level-3');
      $('#main_content').children('h4').addClass('header-level-4');
      $('#main_content').children('h5').addClass('header-level-5');
      $('#main_content').children('h6').addClass('header-level-6');
    }
  }
})(jQuery)