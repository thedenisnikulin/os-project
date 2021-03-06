; ------------------------------------------------------------------------------
; Guide: 	00-BOOT-SECTOR
; File:		ex00 / main.asm
; Title:	Простая программа загрузочного сектора (boot sector), которая
;			запускает бесконечный цикл.
; ------------------------------------------------------------------------------
; Description:
;	Чтобы дать понять BIOS, что на текущей флэшке, компакт диске или жестком
;	диске расположена ОС, на этом носителе должен быть загрузочный сектор. BIOS
;	узнает загрузочный сектор по "магическому числу" из 2-х байт, равное 0xaa55
;	(в шестнадцатеричной системе исчисления). Простейший загрузочный сектор в
;	машинном коде выглядит так:
;
; 		e9 fd ff 00 00 00 00 00 00 00 00 00 00 00 00 00
; 		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
;	   *
; 		00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa
;
;	Как видим, последние 2 байта действительно являются "магическим числом".
;	Первые 3 байта являются машинными инструкциями, которые запускают
;	бесконечный цикл, а остальное просто заполнено нулями т.к. наша программа
;	должна быть размером ровно 512 байт.
;
;	Чтобы перевести наш файл boot_sect.asm в машинный код, нужно написать:
;	nasm boot_sect.asm -f bin -o boot_sect.bin
;	Попробуйте запустить boot_sect.bin с помощью эмулятора (например, qemu), и
;	вы увидите "Booting from Hard Disk...", хотя если вы измените "магическое
;	число", соберете файл boot_sect.bin заново и запустите с помощью эмулятора,
;	то BIOS попытается загрузить ОС, но в итоге напишет "No bootable device".
;	А значит, у нас получилось создать загрузочный сектор!
; ------------------------------------------------------------------------------

						; Бесконечный цикл:
loop:					; Определяем метку "loop"

	jmp loop			; Инструкция "jmp" позволяет нам перейти к метке
						; "loop" (англ. jump - прыжок), т.е. создается
						; бесконечный цикл.

times 510-($-$$) db 0	; Инструкция "times" заставляет идущую после нее
						; команду выполняться опредленное количество раз, т.е.
						; times <кол-во раз> <команда>.
						; Токен $ высчитывает позицию начала текущей строки,
						; токен $$ - позицию начала текущей секции.
						; 510-($-$$) = 510-(2-0) = 508 байт. Чтобы лучше понять
						; как это работает, рекомендую посмотреть как программа
						; выглядит в машинном коде с помощью утилиты ghex.
						; Таким образом мы заполняем пространство нулями (db 0),
						; приводя нас к 510-му байту.
						; db расшифровывается как "declare bytes", т.е.
						; "объявить байты"

dw 0xaa55				; В последние два байта кладем "магическое число",
						; чтобы BIOS знал, что это загрузочный сектор
