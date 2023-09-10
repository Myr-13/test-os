#include <types.h>

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 200
#define SCREEN_SIZE (SCREEN_WIDTH * SCREEN_HEIGHT)

// Double-buffering
extern u8 g_aBuffers[2][SCREEN_SIZE];
extern u8 g_CurBuffer;

#define SCREEN_SET(x, y, d) g_aBuffers[g_CurBuffer][(y) * SCREEN_WIDTH + (x)] = (d);

void video_init();
void video_swap();
