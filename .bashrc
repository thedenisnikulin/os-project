function emu() {    # compile and run emulator
    nasm $1.asm -f bin -o temp.bin
	qemu-system-x86_64 temp.bin
}
