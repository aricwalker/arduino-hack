require 'net/http'
require 'uri'
require 'open-uri'
require 'json'
require 'serialport'


def write_serial(command, hue, sat, brt)
  #params for serial port
  port_str = "/dev/tty.usbmodemfa131"  #may be different for you
  baud_rate = 9600
  data_bits = 8
  stop_bits = 1
  parity = SerialPort::NONE

  sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

  #write command and args to serial port
  sp.putc command
  sp.putc hue
  sp.putc sat
  sp.putc brt

  sp.close

end

def glowValue(x)
  value = (-98 * Math.sin(x * 0.01).abs ) + 100
  # puts value
  value
end

color = '8B1BE0'
redC = color[0..1].to_i
greenC = color[2..3].to_i
blueC = color[4..5].to_i
hue = 345
sat = 80

x = 0

write_serial('p', hue, sat, 20)
