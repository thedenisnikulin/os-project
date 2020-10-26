; ------------------------------------------------------------------------------
; Guide:	00-BOOT-SECTOR
; File:		ex05 / print_hex.asm
; Title:	Функция вывода шестнадцатеричного числа на экран
; ------------------------------------------------------------------------------
; Description: 
;	Как выглядит регистр eax (32 b = 32 бита):
;
;						EAX (32 b)
;		---------------------------------------------
;		|					|			|			|
;		|					|  AH (8 b)	|  AL (8 b) |
;		|					|			|			|
;		---------------------------------------------
;									AX (16 b)
;
;	Как видим, eax содержит в себе регистр ax, который в свою очередь разделен 
;	на ah (a high, верхний) и al (a low, нижний).
; ------------------------------------------------------------------------------


; Помним, что в main.asm:
; dx  =  0x1fb6
; bx  =  "0x0000" (а точнее, bx="0", т.к. указывает на первый элемент)

print_hex:
	pusha						; Сохраняем значения регистров в стеке
	mov cx, 0					; Регистр cx будет служить счетчиком

loop1:
	cmp cx, 4					; if (cx < 4)
	jl print					; Переходим к print
	jmp end						; else переходим к end

print:
	mov ax, dx					; В ax теперь 0x1fb6
	and ax, 0x000f				; В ax теперь 6 (последняя цифра от 0x1fb6).
	cmp ax, 9					; if (ax > 9) (проверяем обозначается ли число
								; буквой т.к. мы помним что цифра больше 9 в 
								; 16-ричной системе исчисления обозначается
								; буквой латинского алфавита)
	jg num_to_abc				; Переходим к num_to_abc
	jmp next

num_to_abc:						; Перевод числа в букву (так, как она бы
								; выглядела в 16-ричной СИ), например число 15
								; в десятичной будет равно f в 16-ричной
	add ax, 39					; Добавляем к этому числу 39, чтобы затем еще
								; добавить 48 ('0'), получая код 
								; соответсвующего символа в ASCII (например,
								; f (как число, то есть 15) + 39 + 48 (код '0')
								; = 102 (то есть 'f' в ASCII, как нам и нужно)
	jmp next

next:
	add ax, '0'					; Добавляем 48 в ax
	mov bx, HEX_OUT + 5			; Теперь bx указывает на последний символ строки
								; HEX_OUT
	sub bx, cx					; bx = bx - counter (для итерации)
	mov [bx], al				; Так как мы разыменовываем bx (вот так: [bx]),
								; то [bx] это не регистр, а ссылка на память,
								; и так как ax = 16 бит (2 байта), чтобы нам не
								; перезаписать лишнюю память, в [bx] мы помещаем
								; не ax, а al, размер которого равен 1-му байту.
	ror dx, 4					; было: 0x1fb6, стало: 0x61fb (переносим
								; последнюю цифру в начало)
	inc cx						; counter++
	jmp loop1					; переходим обратно к loop1

end:
	mov bx, HEX_OUT				; Делаем так, чтобы bx снова указывал на первый
								; символ строки HEX_OUT
	call print_string			; выводи на экран строку из регистра bx
	popa						; Возвращаем регистрам их изначальное значение
	ret							; Заканчиваем выполнение функции


HEX_OUT:	db "0x0000", 0