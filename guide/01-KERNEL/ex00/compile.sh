i386-elf-gcc -ffreestanding -c kernel.c -o kernel.o
nasm kernel_entry.asm -f elf -o kernel_entry.o
i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary
nasm bootsect.asm -f bin -o bootsect.bin
cat bootsect.bin kernel.bin > os-image.bin
qemu-system-i386 -fda os-image.bin
