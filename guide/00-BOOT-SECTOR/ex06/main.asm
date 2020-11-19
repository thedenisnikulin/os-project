; ------------------------------------------------------------------------------
; Guide:	00-BOOT-SECTOR
; File:		ex06 / main.asm
; Title:	Простая программа загрузочного сектора (boot sector), которая 
;			демонстрирует работу сегментации
; ------------------------------------------------------------------------------
; Description:
;	Когда процессор запущен в его начальном режиме (16-bit real mode), 
;	максимальный размер регистров = 16 бит, поэтому самый большой размер, 
;	который мы можем использовать это 0xffff, который равен примерно 64 KB.
;	Чтобы преодолеть этот лимит, существуют специальные регистры, которые 
;	называются регистры сегментов - CS, DS, SS, ES, означающие Code, Data, Stack
;	и Extra соответственно.
;	Память разделена на сегменты, которые индексированы регистрами сегментов
;	(т.е. к примеру в регистре DS лежит адрес начала Data-сегмента). Поэтому, 
;	когда мы указываем какой-либо 16-битный адрес, процессор автоматически
;	высчитывает абсолютный адрес, сдвигая указанный нами адрес от начала нужного
;	сегмента.
;	Высчитывая абсолютный адрес, процессор умножает на 16 значение в регистре 
;	сегмента и добавляет указанный нами адрес. Например, если мы установим 
;	значение сегмента DS как 0x4d и попробуем сделать что-то вроде 
;	"mov ax, [0x20]", то значение, добавляемое в AX, будет загружено 
;	из адреса 0x4f0 (16 * 0x4d + 0x20).
;	Как можно догадаться, с помощью сегментации мы можем добиться того же, что и
;	с помощью директивы [org <адрес>], как мы делали в ex02/org_demo.asm.
; ------------------------------------------------------------------------------


mov ah, 0x0e			; Перемещаем число 0x0e в регистр AH, указывая BIOS'у
						; что нам нужна рутина tele-type, то есть режим вывода 
						; информации на экран

mov al, '1'				; Выводим номер способа для удобства
int 0x10
mov al, [the_secret]	; #1: так как мы не указывали никакого смещения ни с
int 0x10				; помощью org директивы ни с помощью сегментации,
						; 'X' не выведется

mov al, '2'				; Выводим номер способа
int 0x10
mov bx, 0x7c0			; т.к. мы не можем напрямую написать "mov ds, 0x7c0",
mov ds, bx				; используем BX как промежуточное хранилище
mov al, [the_secret]	; 'X' выведется, так как мы сделали смещение.
int 0x10				; Стоит заметить, что мы переводим в DS 0x7c0, а не 
						; 0x7c00, так как помним, что значение, перемещаемое в
						; AL будет загружено из адреса, который будет
						; высчитываться как 16 * ds + the_secret,
						; а 16 * 0x7c0 == 0x7c00, то есть так как нам и нужно.

mov al, '3'				; Выводим номер способа
int 0x10
mov al, [es:the_secret]	; Явно указываем процессору, использовать сегмент ES
int 0x10				; (просто для демонстрации возможностей и чтобы понять
						; как это работает)
						; 'X' не выведется, т.к. мы не переместили в регистр ES
						; число 0x7c0, и поэтому смещение на адрес 16 * 0x7c0 
						; выполнено не будет.

mov al, '4'				; Выводим номер способа
int 0x10
mov bx, 0x7c0			; Используя BX как промежуточное хранилище, перемещаем
mov es, bx				; в регистр ES 0x7c0.
mov al, [es:the_secret]	; Явно указываем процессору сегмент ES
int 0x10				; 'X' выведется.

						; ------------------------------------------------------

jmp $					; бесконечный цикл

the_secret:
	db 'X'

times 510-($-$$) db 0	; Заполняем ненужные байты нулями
dw 0xaa55				; Вставляем в конец "магическое число"
