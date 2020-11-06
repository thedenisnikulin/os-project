#include "screen.h"
#include "lowlevel_io.h"

// #define REG_SCREEN_CTRL 0x3d4
// #define REG_SCREEN_DATA 0x3d5

void	putchar(char character, short attribute_byte)
{
	int offset;

	offset = get_cursor_position();
	write(character, attribute_byte, offset);
	set_cursor_position(offset+1);
}

void	clear_screen()
{
	char *vga = (char *) VIDEO_ADDRESS;
	int	pos = 0;
	while (pos < (MAX_ROWS * MAX_COLS - 1))
	{
		write('\0', 0x0f, pos);
		pos += 2;
	}
}

void	write(char character, short attribute_byte, int pos)
{
	char *vga = (char *) VIDEO_ADDRESS;
	vga[pos] = character;
	vga[pos + 1] = attribute_byte;
}

int		get_cursor_position()
{
	port_byte_out(REG_SCREEN_CTRL, 14);				// запрашиваем верхний байт
	char high_byte = port_byte_in(REG_SCREEN_DATA);	// принимаем
	port_byte_out(REG_SCREEN_CTRL, 15);				// запрашиваем нижний байт
	char low_byte = port_byte_in(REG_SCREEN_DATA);	// принимаем
	return (((high_byte << 8) + low_byte) * 2);		// возвращаем смещение
}

void	set_cursor_position(int pos)
{
	/* Устанавливаем позицию курсора. */
	port_byte_out(REG_SCREEN_CTRL, 14);				// указываем верхний байт
	port_byte_out(REG_SCREEN_DATA, (pos << 8));		// передаем верхний байт
	port_byte_out(REG_SCREEN_CTRL, 15);				// указываем нижний байт
	port_byte_out(REG_SCREEN_DATA, (pos & 0xff));	// передаем нижний байт
	/* Поиграться с битами можно тут http://bitwisecmd.com/ */
}