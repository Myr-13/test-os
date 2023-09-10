[bits 32]

global _start
global _main

_start:
    [bits 32]
    jmp _main

_main:
    [bits 32]
    [extern __main]
    call __main
    jmp $

section .text
    [bits 32]
    jmp _main
