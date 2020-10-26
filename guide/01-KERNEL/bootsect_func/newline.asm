newline:
	pusha
	mov ah, 0x0e
	mov al, 0x0a	; \n - new line
	int 0x10
	mov al, 0x0d	; \r - carriage return
	int 0x10
	popa
	ret
