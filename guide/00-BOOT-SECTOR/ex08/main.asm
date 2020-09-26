; ------------------------------------------------------------------------------
; Guide:	00-BOOT-SECTOR
; File:		ex08 / main.asm
; Title:	Программа загрузочного сектора, которая входит в 32-битный 
; 			Защищенный Режим
; ------------------------------------------------------------------------------
; Description: null
; ------------------------------------------------------------------------------


[org 0x7c00]

	mov bp, 0x9000					; Устанавливаем стэк
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print_string				; Печатаем сообщение на экран

	call switch_to_pm				; Переключаемся на загрузочный режим

	jmp $

%include "../ex06/print_string.asm"	; Вывод строки
%include "gdt.asm"					; GDT
%include "print_string_pm.asm"		; Вывод строки в 32 PM
%include "switch.asm"				; Переключиться на 32 PM

[bits 32]

BEGIN_PM:							; Сюда мы попадем после переключения в PM
	mov ebx, MSG_PROT_MODE
	call print_string_pm			; Печатаем сообщение на экран

	jmp $

MSG_REAL_MODE:
	db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE:
	db "Successfully landed in 32-bit Protected mode", 0

times 510-($-$$) db 0
dw 0xaa55