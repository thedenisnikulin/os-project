# флаг для дебага для gcc
CFLAGS = -g

run: os-image.bin
	qemu-system-i386 -fda os-image.bin
	make clean

debug: os-image.bin kernel.elf
	# kernel.elf нужен для gdb как symbol-file
	# флаг -s указывает qemu открыть и прослушивать 1234 порт
	# чтобы gdb смог соединиться с ним для дебага
	# флаг -S указыает QEMU не запускать образ и подождать подключений
	qemu-system-i386 -s -S -fda os-image.bin
	make clean

os-image.bin: bootsect.bin kernel.bin
	cat bootsect.bin kernel.bin > os-image.bin

bootsect.bin:
	cd ../boot/ && nasm bootsect.asm -f bin -o ../build/bootsect.bin && cd -

kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary

kernel_entry.o:
	nasm ../boot/kernel_entry.asm -f elf -o kernel_entry.o

kernel.o:
	i386-elf-gcc ${CFLAGS} -ffreestanding -c ../kernel/kernel.c

kernel.elf: kernel_entry.o kernel.o 
	# как kernel.bin только без --oformat binary
	i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o -o kernel.elf

clean:
	rm *.bin *.o *.elf
