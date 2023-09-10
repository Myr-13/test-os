#include <mem.h>

#include "screen.h"

static u8 *g_pScreen = (u8 *)0xA0000;

u8 g_aBuffers[2][SCREEN_SIZE];
u8 g_CurBuffer = 0;

void video_init()
{
	memzero(g_aBuffers[0], SCREEN_SIZE);
	memzero(g_aBuffers[1], SCREEN_SIZE);
}

void video_swap()
{
	memcpy(g_pScreen, g_aBuffers[g_CurBuffer], SCREEN_SIZE);
	g_CurBuffer ^= 1;
}
