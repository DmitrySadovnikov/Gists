$("h1").text();

$(".vacation.america")
//or
$(".vacation").filter('.america');

$("#vacation li")  // select all li under #vacation
$(".promo, .farnce") //multiple selector



$("#vacation > li") //select only child li of #vacation
$("li:first") 
$("li:last") 
$("li:odd") 
$("li:even") 


$("#destinations").find("li") 
$("li").first() 
$("li").first().next() //select second li
$("li").last().prev() //select penultimate li
$("li").first().parent() //select #destinations
$("#destinations").children("li") //select all li childrens



$(document).ready(function(){
  var price = $('<p>From $400</p>');// new element 
  $('.vacation').before(price);     // puts price before .vacation
  $('.vacation').after(price);      // puts price after .vacation

  $('.vacation').prepend(price);    // puts price as first child of .vacation
  $('.vacation').append(price);     // puts price as lasr child of .vacation

  //OR

  price.appendTo($('.vacation'));
  price.prependTo($('.vacation'));
  price.insertBefore($('.vacation'));
  price.insertAfter($('.vacation'));

});


$(document).ready(function(){
  $('button').on('click', function(){
    var price = $('<p>From $400</p>');


    $('.vacation').append(price); 
    $('button').remove(); 
    //or
    $(this).closest('vacation').append(price); //or $(this).after(price)
    $(this).remove(); 
  });
});



var amount = $(this).clossest('.vacation').data('price');

$('.vacation').on('click', 'button', function(){});




//Подсветка списков в зависимости от распродажи
$(document).ready(function() {
  $('#filters').on('click', '.on-sale', function() { // from div filters get button with .onsale-filter
    $('.highlight').removeClass('highlight');
    $('.tour').filter('.on-sale').addClass('highlight');
    $('.photos').slideDown();
    $('.photos').slideToggle();
    $(this).clossest('.confirmation').find('.ticket').slideDown();
  });

  $('#filters').on('click', '.featured', function() {
    $('.highlight').removeClass('highlight');
    $('.tour').filter('.featured').addClass('highlight');
  });

  $('#filters').on('focusin', '.on-sale', function() {}
                   'focusout'
                   'mouseup'
                   'mousedown'
                   'mousemove'
                   'mouseout'
                   'mouseover'
                   'mouseenter'
                   'mouseleave'
                   'dbclick'
                   'dbclick'
});





$(document).ready(function() {
  $('.tour').on('click','button', function() {
    var discount = $(this).closest('.tour').data('discount');
    var message = $('<span>Call 1-555-jquery-air for a $discount discount.</span>');
    $(this).closest('.tour').append(message);
    $(this).remove();
  });
});



$('body').append("<p>I'm a paragraph!</p>");
$('body').prepend("<p>I'm a paragraph!</p>");
("<p>I'm a paragraph!</p>").appendTo('body');

$('div').after('<p>Hello</p>') //add p after div


$('#one').after('<p>Hello</p>')
  
var $two = $('#two');
$('#two').after($('p'))

$('p').remove();
$('p').empty();

$('selector').addClass('className');
$('selector').removeClass('className');

 $('div').height('200px');
 $('div').width('200px');
 $('div').css('border-radius', '10px');

 $('div').html("I love jQuery!");
 $('input:checkbox:checked').val();
 var input = $('input[name=checkListItem]').val();


$(document).ready(function() {
  $('#button').click(function() {
    var toAdd = $('input[name=checkListItem]').val();
    $('.list').append('<div class="item">' + toAdd + '</div>')
  });
  
  $(document).on('click', '.item', function(){
    $(this).remove();
  });
});

$('div').hover(
    function(){
      $(this).addClass('highlight');
   },
   function(){
      $(this).removeClass('highlight');
   }
);


$(document).ready(function() {
   $('div').animate({left:'+=10px'},500);   
});


$(document).ready(function() {
    $(document).keydown(function(key) {
        switch(parseInt(key.which,10)) {
      // Left arrow key pressed
      case 37:
        $('img').animate({left: "-=10px"}, 'fast');
        break;
      // Up Arrow Pressed
      case 38:
        $('img').animate({top: "-=10px"}, 'fast');
        break;
      // Right Arrow Pressed
      case 39:
        $('img').animate({left: "+=10px"}, 'fast');
        break;
      // Down Arrow Pressed
      case 40:
        $('img').animate({top: "+=10px"}, 'fast');
        break;
    }
  });
});

//jQuery UI
$('div').effect('explode');
$('div').effect('bounce', {times:2}, 200);
$("#menu").accordion({collapsible: true, active: false});
$('#car').draggable(); 
$('ol').selectable();
$('ol').sortable(); 



//Keypress//
$(document).keypress(function(event) {
  if(event.which === 109) {//109 is "m" key on keyboard
    $('.dropdown-menu').toggle();
  }
});
////