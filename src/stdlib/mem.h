#include "types.h"

static inline void *memcpy(void *dst, const void *src, size_t n)
{
    u8 *d = (u8 *)dst;
    const u8 *s = (const u8 *)src;

    while (n-- > 0)
        *d++ = *s++;

    return d;
}

static inline void memset(void *dst, u8 value, size_t n) {
    u8 *d = dst;

    while (n-- > 0) {
        *d++ = value;
    }
}

static inline void *memmove(void *dst, const void *src, size_t n) {
    // OK since we know that memcpy copies forwards
    if (dst < src) {
        return memcpy(dst, src, n);
    }

    u8 *d = dst;
    const u8 *s = src;

    for (size_t i = n; i > 0; i--) {
        d[i - 1] = s[i - 1];
    }

    return dst;
}

static inline void memzero(void *dst, size_t n)
{
	memset(dst, 0, n);
}
