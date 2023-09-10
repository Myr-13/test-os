[org 0x7c00]
KERNEL_LOCATION equ 0x1000

mov [BOOT_DISK], dl

; do smth
xor ax, ax
mov es, ax
mov ds, ax

; setup base stack
mov bp, 0x8000
mov sp, bp

; do smth
mov bx, KERNEL_LOCATION ; dest
mov dh, 32 ; num sectors
mov ah, 0x02
mov al, dh ; num sectors
mov ch, 0x00
mov dh, 0x00
mov cl, 0x02
mov dl, [BOOT_DISK]
int 0x13

; video mode
mov ah, 0x0
mov al, 0x13
int 0x10

call enter_protect_mode

CODE_SEG equ GDT_code - GDT_start
DATA_SEG equ GDT_data - GDT_start

; 32 bits protect mode
enter_protect_mode:
    [bits 16]
    cli
    lgdt [GDT_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODE_SEG:start_protected_mode

jmp $
                                    
BOOT_DISK: db 0

GDT_start:
    GDT_null:
        dd 0x0
        dd 0x0

    GDT_code:
        dw 0xffff
        dw 0x0
        db 0x0
        db 0b10011010
        db 0b11001111
        db 0x0

    GDT_data:
        dw 0xffff
        dw 0x0
        db 0x0
        db 0b10010010
        db 0b11001111
        db 0x0

GDT_end:

GDT_descriptor:
    dw GDT_end - GDT_start - 1
    dd GDT_start


[bits 32]
start_protected_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    ; 32 bit stack pointer
    mov ebp, 0x90000
    mov esp, ebp

    ; run main program
    jmp KERNEL_LOCATION

; bootsector
times 510-($-$$) db 0              
dw 0xaa55
