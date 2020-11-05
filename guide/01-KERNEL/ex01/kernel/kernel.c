#include "../drivers/screen.h"

int		main()
{
	set_cursor_position(1);
	char cpos = get_cursor_position();
	write(cpos+'0', 0, 0, 0x0f);
	return 0;
}
