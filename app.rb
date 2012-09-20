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
  value = (-240 * Math.sin(x * 0.01).abs ) + 255
  console.log(value)
  return value
end


while true


end