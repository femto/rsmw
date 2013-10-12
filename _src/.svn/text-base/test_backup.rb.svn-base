#filename = 'C:\Program Files\MagicSky\BangBangBang\spr_data\character\bobo.spr'
filename = 'C:\Program Files\MagicSky\BangBangBang\spr_data\bomb\bomb_red.spr'
gem_original_require 'RUDL'
include RUDL
include Constant
display = DisplaySurface.new([640,480])
x=32
surface = Surface.new([x,x])
x_index = 0
y_index = 0
index = 0
count = 0
while true


#pixels = File.read(filename)[0x1ad0+9+index,x*x]
pixels = File.read(filename)[0x2090+index,x*x]
#pixels = File.read(filename)[index,x*x]
#p pixels
puts "at count: #{count},index:#{index}"
surface.pixels = pixels

display.blit(surface,[x_index,y_index])
display.flip
Timer.delay(50)
index += x*x
x_index += x
if x_index > display.w
  x_index = 0
  y_index += x
end
count += 1
break if index > 1000000
end

loop do
    # wait for an input event
    ev = EventQueue.wait

    # exit if the window was closed
    break if ev.is_a? QuitEvent
end