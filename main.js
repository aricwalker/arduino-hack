

var five = require("johnny-five"),
    x = 0,
    board, red, green, blue, leds;

board = new five.Board();

board.on("ready", function() {

  //red = new five.Led(9);
  //green = new five.Led(10);
  blue = new five.Led(11);
  // leds = new five.Leds();

  setInterval(function() {
    var outval = glowValue(x);
    blue.brightness(outval);
    x++;
  }, 18);

  // red.pulse(5000);
  // this.wait( 10000, function() {
  //   red.stop().off();
  // });

});

function glowValue(x) {
  var value = (-240 * Math.abs( Math.sin(x*0.01))) + 255; //sine wave
  console.log(value);
  return value;
}