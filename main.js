

var five = require("johnny-five"),
    x = 0,
    board, red, green, blue, leds;

board = new five.Board();

board.on("ready", function() {

  red = new five.Led(9);
  green = new five.Led(10);
  blue = new five.Led(11);



  var color = '8B1BE0';

  var redC = parseInt(color.substring(0, 1), 16),
    greenC = parseInt(color.substring(2, 3), 16),
    blueC = parseInt(color.substring(4, 5), 16);

  var hsl = rgbToHsl(redC, greenC, blueC);
  var h = hsl[0];
  var s = hsl[1];

  var rgb = hslToRgb(hsl[0], hsl[1], hsl[2]);



  // red.brightness(redC);
  // blue.brightness(blueC);
  // green.brightness(greenC);
  var rgb2;

  setInterval(function() {
    var outval = glowValue(x);
    console.log(outval);
    rgb2 = hslToRgb(h, s, (outval / 2.6));

    red.brightness(rgb2[0]);
    blue.brightness(rgb2[1]);
    green.brightness(rgb2[2]);
    x++;
  }, 18);

  // red.pulse(5000);
  // this.wait( 10000, function() {
  //   red.stop().off();
  // });

});



function glowValue(x) {
  var value = (-240 * Math.abs( Math.sin(x * 0.01))) + 255; //sine wave
  console.log(value);
  return value;
}


function rgbToHsl(r, g, b){
    r /= 255, g /= 255, b /= 255;
    var max = Math.max(r, g, b), min = Math.min(r, g, b);
    var h, s, l = (max + min) / 2;

    if(max == min){
        h = s = 0; // achromatic
    }else{
        var d = max - min;
        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
        switch(max){
            case r: h = (g - b) / d + (g < b ? 6 : 0); break;
            case g: h = (b - r) / d + 2; break;
            case b: h = (r - g) / d + 4; break;
        }
        h /= 6;
    }

    return [h, s, l];
}

/**
 * Converts an HSL color value to RGB. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSL_color_space.
 * Assumes h, s, and l are contained in the set [0, 1] and
 * returns r, g, and b in the set [0, 255].
 *
 * @param   Number  h       The hue
 * @param   Number  s       The saturation
 * @param   Number  l       The lightness
 * @return  Array           The RGB representation
 */
function hslToRgb(h, s, l){
    var r, g, b;

    if(s == 0){
        r = g = b = l; // achromatic
    }else{
        function hue2rgb(p, q, t){
            if(t < 0) t += 1;
            if(t > 1) t -= 1;
            if(t < 1/6) return p + (q - p) * 6 * t;
            if(t < 1/2) return q;
            if(t < 2/3) return p + (q - p) * (2/3 - t) * 6;
            return p;
        }

        var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
        var p = 2 * l - q;
        r = hue2rgb(p, q, h + 1/3);
        g = hue2rgb(p, q, h);
        b = hue2rgb(p, q, h - 1/3);
    }

    return [r * 255, g * 255, b * 255];
}
