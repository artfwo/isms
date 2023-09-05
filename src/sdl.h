#pragma once

#include <SDL2/SDL.h>

extern SDL_Surface *surface;
extern uint32_t *pixels;

int init_sdl(int x, int y);
void deinit_sdl(void);

void sdl_check(void);

void sdl_redraw(uint32_t *dst);
void sdl_clear(uint32_t *dst);
void sdl_pixel(uint32_t *dst, int x, int y, int color);
void sdl_line(uint32_t *dst, int ax, int ay, int bx, int by, int color);
