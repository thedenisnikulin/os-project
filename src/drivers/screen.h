/*------------------------------------------------------------------------------
*	Guide:	01-KERNEL
*	File:	ex01 / drivers / screen.h
*	Title:	Заголовочный файл для screen.c
* ------------------------------------------------------------------------------
*	Description:
* ----------------------------------------------------------------------------*/


#include "../common.h"

#define VIDEO_ADDRESS 0xb8000	// Адрес начала VGA для печати символов
#define MAX_ROWS 25				// макс. строк
#define MAX_COLS 80				// макс. столбцов

#define WHITE_ON_BLACK 0x0f		// 0x0 == white fg, 0xf == black bg

// Адреса I/O портов для взаимодействия с экраном.
#define REG_SCREEN_CTRL 0x3d4	// этот порт для описания данных
#define REG_SCREEN_DATA 0x3d5	// а этот порт для самих данных

void	kprint(u8 *str);
void	putchar(u8 character, u8 attribute_byte);
void	clear_screen();
void	write(u8 character, u8 attribute_byte, u16 offset);
void	scroll_line();
u16		get_cursor();
void	set_cursor(u16 pos);
