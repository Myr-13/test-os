#include <mem.h>
#include <string.h>

#include "video/screen.h"
#include "font.h"

inline void text(int x, int y, u8 color, const char *text)
{
	int len = strlen(text);

	for(int i = 0; i < len; i++)
	{
		text_c(x, y, color, text[i]);

		x += 8;
	}
}

inline void text_c(int x, int y, u8 color, char c)
{
	const u8 *glyph = FONT[(size_t)c];

	for(size_t yy = 0; yy < 8; yy++)
		for(size_t xx = 0; xx < 8; xx++)
			if(glyph[yy] & (1 << xx))
				SCREEN_SET(x + xx, y + yy, color);
}

void _main()
{
	video_init();

	for(int i = 0; i < 0x1F; i++)
	{
		for(int j = 0; j < 0x1F; j++)
			text_c(i * 8, j * 8, j * 0x1F + i, 0x1);
	}

	video_swap();

	while(1) {}
}
