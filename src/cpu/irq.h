#ifndef IRQ_H
#define IRQ_H

#include <types.h>
#include "isr.h"

void irq_install(size_t i, void (*handler)(struct Registers*));
void irq_init();

#endif
