# os-project
>Пишем свою собственную операционную систему с нуля!

Идея написать ОС возникла у меня в процессе поиска идеи для сайд-проекта. Это исключительно хобби-проект, не рассчитанный на серьезность и достоверность, и хотя я пытался объяснить многие новые и неочевидные концепты, с которыми я столкнулся в процессе разработки, я мог что-то упустить, так как я сам только учусь - именно поэтому я настоятельно рекомендую пользоваться гуглом и любыми другими источниками информации когда вы познакомитесь с чем-то новым в гайде. Гуглите абсолютно всё. Я серьезно.

**Prerequisites: **Для комфортного прохождения гайда нужно уметь программировать на языке Си на базовом уровне (одно из обязательных требований: понимать принципы работы с указателями), иметь опыт разработки на высокоуровневых ЯП. С синтаксисом ассемблера можно ознакомиться по ссылке ниже, но все же рекомендую побольше почитать или посмотреть по нему туториалов.

## Навигация по репозиторию
<ins>**`guide/`**</ins> --- гайд с последовательными уроками, теорией и задокументированным кодом
* Гайд разделен на главы, например `00-BOOT-SECTOR`
* Главы разделены на упражнения, например `ex00`
* Упражнения содержат в себе код и теорию. Выглядят как `main.asm`

<ins>**`src/`**</ins> --- исходный код ОС

## Установка и запуск

1. Установить эмулятор QEMU (подробнее: https://www.qemu.org/download/)
```
sudo apt install qemu-kvm qemu
```
2. Собрать кросс-компилятор gcc для i386 архитектуры процессора. Удобнее использовать готовый отсюда: https://wiki.osdev.org/GCC_Cross-Compiler#Prebuilt_Toolchains. Для компьютеров на Linux с x86_64 архитектурой:
```
wget http://newos.org/toolchains/i386-elf-4.9.1-Linux-x86_64.tar.xz
mkdir /usr/local/i386elfgcc
tar -xf i386-elf-4.9.1-Linux-x86_64.tar.xz -C /usr/local/i386elfgcc --strip-components=1
export PATH=$PATH:/usr/local/i386elfgcc/bin
```
3. Клонировать и собрать проект
```
git clone https://github.com/thedenisnikulin/os-project
cd os-project/src/build
make
```
4. Запустить образ ОС с помощью эмулятора
```
qemu-system-i386 -fda os-image.bin
```

## Справочник по синтаксису ассемблера NASM
https://www.opennet.ru/docs/RUS/nasm/nasm_ru3.html


---
## Дополнительная информация
Ссылки на полезный материал которым я пользовался в качестве теории.
> На русском языке:
- Серия статей о ядре Linux и его внутреннем устройстве: https://github.com/proninyaroslav/linux-insides-ru
> На английском языке:
- Небольшая книга по разработке собственной ОС (70 страниц): https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
- Общее введене в разработку операционных систем: https://wiki.osdev.org/Getting_Started
- Туториал по разработке ядра операционной системы для 32-bit x86 архитектуры. Первые шаги в создании собсвтенной ОС: https://wiki.osdev.org/Bare_Bones
- Продолжение предыдущего туториала: https://wiki.osdev.org/Meaty_Skeleton
- Про загрузку ОС (booting): https://wiki.osdev.org/Boot_Sequence
- Список туториалов по написанию ядра и модулей к ОС: https://wiki.osdev.org/Tutorials
- Внушительных размеров гайд по разработке ОС с нуля: http://www.brokenthorn.com/Resources/OSDevIndex.html
- Книга, описывающая ОС xv6 (не особо вникал, но должно быть что-то годное): https://github.com/mit-pdos/xv6-riscv-book, сама ОС: https://github.com/mit-pdos/xv6-public
- "Небольшая книга о разработке операционных систем" https://littleosbook.github.io/
- Операционная система от 0 до 1 (книга): https://github.com/tuhdo/os01
- ОС, написанная как пример для предыдущей книги: https://github.com/tuhdo/sample-os
- Интересная статья про программирование модулей для Линукса и про системное программирование https://jvns.ca/blog/2014/09/18/you-can-be-a-kernel-hacker/
- Еще одна статья от автора предыдущей https://jvns.ca/blog/2014/01/04/4-paths-to-being-a-kernel-hacker/
- Пример простого модуля к ядру линукса: https://github.com/jvns/kernel-module-fun/blob/master/hello.c
- Еще один туториал о том, как написать ОС с нуля: https://github.com/cfenollosa/os-tutorial
- Статья "Давайте напишем ядро": https://arjunsreedharan.org/post/82710718100/kernels-101-lets-write-a-kernel
- Сабреддит по разработке ОС: https://www.reddit.com/r/osdev/
- Большой список идей для проектов для разных ЯП, включая C/C++: https://github.com/tuvtran/project-based-learning/blob/master/README.md
- Еще один список идей для проектов https://github.com/danistefanovic/build-your-own-x
- "Давайте напишем ядро с поддержкой ввода с клавиатуры и экрана": https://arjunsreedharan.org/post/99370248137/kernel-201-lets-write-a-kernel-with-keyboard-and 
