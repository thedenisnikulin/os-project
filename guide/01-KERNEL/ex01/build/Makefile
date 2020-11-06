C_FILES = $(shell find ../drivers/*.c)
temp = $(notdir $(C_FILES))
O_FILES = ${temp:.c=.o}

CFLAGS = -g		# debug flag for gcc

run: os-image.bin
	# -s flag makes qemu listen to 1234 port
	qemu-system-i386 -s -fda os-image.bin
	make clean

debug: os-image.bin kernel.elf	# kernel.elf is used for gdb
	qemu-system-i386 -s -fda os-image.bin
	# i386-elf-gdb -ex "target remote :1234" -ex "symbol-file kernel.elf"
	# if i386-elf-gdb: error while loading shared libraries: libncurses.so.5: 
	# cannot open shared object file: No such file or directory
	# sudo apt-get install libncurses5
	make clean

os-image.bin: bootsect.bin kernel.bin
	cat bootsect.bin kernel.bin > os-image.bin

bootsect.bin:
	cd ../boot/ && nasm bootsect.asm -f bin -o ../build/bootsect.bin && cd -

kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o $(O_FILES) --oformat binary

kernel_entry.o:
	nasm ../boot/kernel_entry.asm -f elf -o kernel_entry.o

kernel.o:
	i386-elf-gcc ${CFLAGS} -ffreestanding -c ../kernel/kernel.c $(C_FILES)

kernel.elf: kernel_entry.o kernel.o 
	# like kernel.bin but with no --oformat binary
	i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o $(O_FILES) -o kernel.elf

clean:
	rm *.bin *.o *.elf