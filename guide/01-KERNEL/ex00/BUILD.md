# Процесс сборки

Для сборки нам понадобится собрать кросс-компилятор gcc для i386 архитектуры процессора. Удобнее использовать готовый отсюда: https://wiki.osdev.org/GCC_Cross-Compiler#Prebuilt_Toolchains. Для компьютеров на Linux с x86_64 архитектурой:
```
wget http://newos.org/toolchains/i386-elf-4.9.1-Linux-x86_64.tar.xz
mkdir /usr/local/i386elfgcc
tar -xf i386-elf-4.9.1-Linux-x86_64.tar.xz -C /usr/local/i386elfgcc --strip-components=1
export PATH=$PATH:/usr/local/i386elfgcc/bin
```
Далее можно использовать установленный тулчейн с помощью команд `i386-elf-gcc` для gcc, `i386-elf-ld` для линкера, и т.д.

1. Итак, сначала компилируем загрузочный сектор. Получится бинарный файл.
```
nasm bootsect.asm -f bin -o bootsect.bin
```
Флаги:
- `-f bin` - формат бинарный
- `-o bootsect.bin` - output file = bootsect.bin
2. Далее компилируем ядро в объектный файл, чтобы потом собрать его вместе с kernel_entry.
```
i386-elf-gcc -ffreestanding -c kernel.c -o kernel.o
```
Флаги:
- `-ffreestanding` - в режиме `freestanding`, единственные доступные заголовочные файлы стандартной библиотеки это <float.h>, <iso646.h>, <limits.h>, <stdarg.h>, <stdbool.h>, <stddef.h> и <stdint.h>. Также эта опция указывает компилятору не полагаться на то, что стандартные функции имеют их обычное определение. Это предотвратит компилятор от оптимизации, которую он делает на основе предположений о поведении функций из стандартных библиотек. Например в `hosted` режиме (противополжен `freestanding`), gcc знает о том, что имеющаяся библиотека соответствует спецификации стандарта языка Си. Он может преобразовать `printf("hi\n")` в `puts("hi")`, т.к. имеет представление из определения стандартной IO библиотеки что эти две функции ведут себя одинаково в данном случае. А с флагом `-ffreestanding` gcc не проводит подобных оптимизаций. Подобнее: http://cs107e.github.io/guides/gcc/, https://stackoverflow.com/questions/18711719/freestanding-gcc-and-builtin-functions.
- `-c kernel.c` - флаг указывает на то, что файл после компиляции не нужно линковать
- `-o kernel.o` - output object file
3. Компилируем `kernel_entry.asm`
```
nasm kernel_entry.asm -f elf -o kernel_entry.o
```
Флаги:
- `-f elf` - формат: ELF (Executable and Linkable Format)

4. Линкуем `kernel_entry.o` и `kernel.o` вместе в один бинарный файл `kernel.bin`
```
i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary
```
Флаги:
- `-o kernel.bin` - output file = kernel.bin
- `-Ttext 0x1000` - этот флаг распологает секцию `.text` по адресу `0x1000`.
- `--oformat binary` - output format = binary

5. Соединяем два файла `bootsect.bin` и `kernel.bin` в один `os-image.bin` с помощью утилиты cat
```
cat bootsect.bin kernel.bin > os-image.bin
```
6. Запускаем образ ОС с помощью эмулятора qemu
```
qemu-system-i386 -fda os-image.bin
```
Флаги:
- `-fda` - использовать файл как образ флоппи диска (дискеты).

Вуаля!

> Подробнее: [Makefile](build/Makefile)
