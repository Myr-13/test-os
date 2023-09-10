@echo off
cls

:: Config
set BASIC_MINGW=C:\MinGW\bin
set NASM=C:\nasm-2.16.02rc1\nasm.exe
set GCC=%BASIC_MINGW%\gcc.exe
set LD=%BASIC_MINGW%\ld.exe
set OCPY=%BASIC_MINGW%\objcopy.exe
set QEMU="C:\Program Files\qemu\qemu-system-x86_64.exe"

:: Flags
set GCC_FLAGS=-m32 -ffreestanding -g -I src/stdlib -O2
set QEMU_FLAGS=-drive format=raw,file="build/os.bin"

:: Compile bootloader
%NASM% src\boot\boot.asm -f bin -o build\boot.bin
%NASM% src\boot\kernel_entry.asm -f elf -o build\kernel_entry.o

:: Compile C code
%GCC% %GCC_FLAGS% -c src\kernel.c -o build\kernel.o
%GCC% %GCC_FLAGS% -c src\screen.c -o build\screen.o

:: Link
%LD% -o build\kernel.pe -Tlink.ld -Ttext 0x1000 build\kernel_entry.o build\kernel.o build\screen.o

:: Copy
%OCPY% -O binary build\kernel.pe build\kernel.bin
copy /B build\boot.bin + build\kernel.bin build\os.bin

:: Run in QEMU
%QEMU% %QEMU_FLAGS%
