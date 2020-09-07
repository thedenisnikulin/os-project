; =========================== BOOT SECTOR GUIDE V01 ============================
; Простая программа загрузочного сектора (boot sector), которая выводит "Hello"
; на экран, используя рутину BIOS'а 
; ------------------------------------------------------------------------------
; Чтобы вывести символ на экран, мы воспользуемся "scrolling tele-type BIOS
; routine", то есть специальной рутиной BIOS, которая выводит символ на экран и
; перемещает курсор, чтобы быть готовым напечатать следующий символ. Чтобы 
; воспользоваться этой рутиной, нужно переместить в регистр ah число 0x0e, 
; а также использовать прерывания (синтаксис прерываний в ассемблере - 
; "int <номер прерывания>"). Прерывания - это механизм, с помощью которого 
; процессор может быть прерван от выполнения того, чем он сейчас занят, чтобы 
; выполнить какую-то другую команду. Мы будем использовать прерывание 0x10 (это
; число - индекс обработчика прерывания в ISR (interrupt service routines). ISR
; это последовательность команд, ответсвенных за прерывание. Нам нужна команда
; под индексом 0x10), функцией которого является предоставление графических 
; сервисов, вывод строк на экран и т.д.
; ------------------------------------------------------------------------------
; Чтобы перевести наш файл boot_sect.asm в машинный код, нужно написать:
; nasm boot_sect.asm -f bin -o boot_sect.bin
; ------------------------------------------------------------------------------
; Справочник по синтаксису ассемблера NASM можно найти тут: 
; https://www.opennet.ru/docs/RUS/nasm/nasm_ru3.html


mov ah, 0x0e			; Перемещаем значение 0x0e (в десятичной = 14)
						; в регистр ah, указывая BIOS'у что нам нужна рутина
						; tele-type, то есть режим вывода информации на экран

mov al, 'H'				; Перемещаем ASCII код символа в регистр al (команда
int 0x10				; mov), вызываем прерывание 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

jmp $					; Знак $ вычисляет позицию начала строки, содержащей
						; выражение, то есть мы прыгаем к началу этой же строки,
						; создавая бесконечный цикл

times 510-($-$$) db 0	; Заполняем ненужные байты нулями

dw 0xaa55				; Вставляем в конец "магическое число"