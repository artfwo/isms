--- script
print("example.lua -------------> hello there")

window.clear()

for i=0,255 do
  window.pixel(i,4,0xFFFF00-i)
  window.pixel(i,8,0x00FFFF-i)
  window.pixel(i,12,0xFF00FF-i)
end

window.redraw()

x1,y1,x2,y2,c = 128,80,0,0,0xffffff

g = grid.connect()

window.event.key = function(x)
  x2 = x1
  y2 = y1
  x1 = math.random(192)+32
  y1 = math.random(64)+32
	g.led(x1%16,y1%8,0)
	g.redraw()
  c = c - 0x111111
  window.line(x1,y1,x2,y2,c)
  window.redraw()
  osc.send({"localhost",57120},"/n",{x%127})
  print("key: "..x)
end

metro.event.tick = function(i,s)
  print("metro",i,s)
  g.all(s)
  g.redraw()
end

metro.start(1,0.1,5,0)

g.event.key = function(x,y,z)
  print("example grid key",x,y,z)
  --osc.send({"localhost",57120},"/n",{(7-y)*5+x+30})
  g.led(x,y,15);
  g.redraw();
end

dofile("test.lua")

--m = midi.connect()
--m.event = function(d) tab.print(d) end

--w = midi.connect(2)
--[[
w:note_on(60,100)
w:note_off(60,100)
]]--

