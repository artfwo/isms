# isms

lua + clocks + osc + grid + midi + ui

- build: `make`
- install: `sudo make install`
- run: `isms example.lua`

requires lua 5.4, sdl2, liblo

apt-get: liblua5.4-dev libsdl2-dev liblo-dev

only tested on linux (ubuntu), include/lib paths are hardcoded in makefile

## currently

- install with `make; sudo make install` then run with `isms example.lua` 
- `example.lua` is run at startup, creating a new window which accepts key input to place a random pixel line and send an OSC message to supercollider
- `polyperc.scd` will provide a rudimentary osc-listening synth for testing OSC using SuperCollider
- if found, connects to grid via serialosc and sends OSC on key input
- a rudimentary REPL is implemented, try `print('hello')`
- ctrl-q quits (or close sdl window, or q from repl)
- ctrl-r reloads lua script
- remote lua input via UDP on port 11001 ie `echo -n "print('hello')" > /dev/udp/localhost/11001` (set up your editor to send to this port)
- .vimrc map:
  map <C-\> :silent .w !xargs -0 echo -n > /dev/udp/localhost/11001<CR>


## user/system folder structure

library folder: `~/.local/share/isms`

`system` subfolder is copied by `make install`. any user libraries can go directly in `~/.local/share/isms`.


## TODO
```
- cpu usage at rest (should be lower)
- linux-macos compatibility
  - nanosleep fix
- midi: use portmidi https://github.com/PortMidi/PortMidi
- consider implications of running multiple instances
  x osc port assignments (ie auto-increment if requested is taken)
  - grid/midi "focus"
- config file (pre-run) for setting "reserved" grid/midi slots (ie serial numbers)
  - ~/.local/share/isms/init.lua

- sdl
  - text
  - more drawing functions
  - (?) mouse events
- socket input: allow blocks, not just line
- repl history (readline/etc)
- repl: fix color coding (where text is coming from: socket or local)

- optimization
  - sdl should probably have its own thread
- security: should udp socket input check incoming ip (restrict to localhost?)
  - or arg to disable

- (?) metro allocator
```


## lua

```
grid.all(id,z)
grid.led(id,x,y,z)
grid.redraw(id)
grid.event.key(x,y,z)
grid.event.add(id,serial)
grid.event.remove(id,serial)

window.init(x,y)
window.pixel(x,y,color)
window.line(x1,y1,x2,y2,color)
window.redraw()
window.event.key(code)

metro.start(index, time_sec, count, stage)
metro.stop(index)
metro.event.tick(index, stage)

osc.send(path, args)
osc.event.receive(path, args, from)

clock -- TODO
midi -- currently removed, needs reimplementation

```

## acknowledgements

reimagining of norns. reconsidering design for use on any computer with large screen and keyboard.

- based heavily on `matron` from norns, written by @catfact
- sdl use patterned on work by @neauoire
- additional thanks to @artem (clocks), @ngwese, and @csboling


## reference

- https://www.lua.org/manual/5.4/manual.html#4
- https://github.com/klassmann/sdl2-lua53-example/blob/master/src/main.c
- https://lucasklassmann.com/blog/2019-02-02-how-to-embeddeding-lua-in-c/#running-lua-code
- http://mech.math.msu.su/~vvb/2course/Borisenko/CppProjects/GWindow/xintro.html
- https://hdante.wordpress.com/2014/07/08/the-hello-wayland-tutorial/
