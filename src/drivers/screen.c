/*------------------------------------------------------------------------------
*	Guide:	01-KERNEL
*	File:	ex01 / drivers / screen.c
*	Title:	Функции работы с экраном
* ------------------------------------------------------------------------------
*	Description:
* ----------------------------------------------------------------------------*/


#include "screen.h"
#include "lowlevel_io.h"
#include "../common.h"


void	kprint(u8 *str)
{
	/* Функция печати строки */
	
	// u8 *str: указатель на строку (на первый символ строки). Строка должна
	// быть null-terminated.

	while (*str)
	{
		putchar(*str, WHITE_ON_BLACK);
		str++;
	}
}

void	putchar(u8 character, u8 attribute_byte)
{
	/* Более высокоуровневая функция печати символа */

	// u8 character: байт, соответствующий символу
	// u8 attribute_byte: байт, соответствующий цвету текста/фона символа

	u16 offset;

	offset = get_cursor();
	if (character == '\n')
	{
		// Переводим строку.
		if ((offset / 2 / MAX_COLS) == (MAX_ROWS - 1)) 
			scroll_line();
		else
			set_cursor((offset - offset % (MAX_COLS*2)) + MAX_COLS*2);
	}
	else 
	{
		if (offset == (MAX_COLS * MAX_ROWS * 2)) scroll_line();
		write(character, attribute_byte, offset);
		set_cursor(offset+2);
	}
}

void	scroll_line()
{
	/* Функция скроллинга */

	u8 i = 1;		// Начинаем со второй строки.
	u16 last_line;	// Начало последней строки.

	while (i < MAX_ROWS)
	{
		memcpy(
			(u8 *)(VIDEO_ADDRESS + (MAX_COLS * i * 2)),
			(u8 *)(VIDEO_ADDRESS + (MAX_COLS * (i-1) * 2)),
			(MAX_COLS*2)
		);
		i++;
	}

	last_line = (MAX_COLS*MAX_ROWS*2) - MAX_COLS*2;
	i = 0;
	while (i < MAX_COLS)
	{
		write('\0', WHITE_ON_BLACK, (last_line + i * 2));
		i++;
	}
	set_cursor(last_line);
}

void	clear_screen()
{
	/* Функция очистки экрана */

	u16	offset = 0;
	while (offset < (MAX_ROWS * MAX_COLS * 2))
	{
		write('\0', WHITE_ON_BLACK, offset);
		offset += 2;
	}
	set_cursor(0);
}

void	write(u8 character, u8 attribute_byte, u16 offset)
{
	/* Функция печати символа на экран с помощью VGA по адресу 0xb8000 */

	// u8 character: байт, соответствующий символу
	// u8 attribute_byte: байт, соответствующий цвету текста/фона символа
	// u16 offset: смещение (позиция), по которому нужно распечатать символ
	
	u8 *vga = (u8 *) VIDEO_ADDRESS;
	vga[offset] = character;
	vga[offset + 1] = attribute_byte;
}

u16		get_cursor()
{
	/* Функция, возвращающая позицию курсора (char offset). */

	port_byte_out(REG_SCREEN_CTRL, 14);				// Запрашиваем верхний байт
	u8 high_byte = port_byte_in(REG_SCREEN_DATA);	// Принимаем его
	port_byte_out(REG_SCREEN_CTRL, 15);				// Запрашиваем нижний байт
	u8 low_byte = port_byte_in(REG_SCREEN_DATA);	// Принимаем и его
	// Возвращаем смещение умножая его на 2, т.к. порты возвращают смещение в
	// клетках экрана (cell offset), а нам нужно в символах (char offset), т.к.
	// на каждый символ у нас 2 байта
	return (((high_byte << 8) + low_byte) * 2);
}

void	set_cursor(u16 pos)
{
	/* Функция, устаналивающая курсор по смещнию (позиции) pos */
	/* Поиграться с битами можно тут http://bitwisecmd.com/ */

	// конвертируем в cell offset (в позицию по клеткам, а не символам)
	pos /= 2;

	// Указываем, что будем передавать верхний байт
	port_byte_out(REG_SCREEN_CTRL, 14);
	// Передаем верхний байт
	port_byte_out(REG_SCREEN_DATA, (u8)(pos >> 8));
	// Указываем, что будем передавать нижний байт
	port_byte_out(REG_SCREEN_CTRL, 15);
	// Передаем нижний байт
	port_byte_out(REG_SCREEN_DATA, (u8)(pos & 0xff));
}
