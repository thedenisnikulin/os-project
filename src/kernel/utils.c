#include "./utils.h"
#include "../drivers/screen.h"
#include "../common.h"

void	kprint_rick_and_morty()
{
	u8 *char_map[] = {
		"__#_#_#\n",
		"__#####____", "#####\n",
		"__#", "###", "#____", "#", "###", "#\n",
		"__#", "#", "#", "#", "#____", "#", "#", "#", "#", "#\n",
		"__#", "#", "#", "#", "#____", "#", "#", "#", "#", "#\n",
		"__#####____", "#####\n",
		"___###_____", "_###_\n",
		"__##", "#", "##____", "#####\n",
		"__##", "#", "##____", "#", "###", "#\n",
		"__##", "#", "##____", "#", "###", "#\n",
		"__#", "#", "#", "#", "#____", "#", "###", "#\n",
		"___##", "#______", "###\n",
		"___#_#______#_#\n"
	};
	u8 color_map[] = { 
		0xbb,
		0xbb, 0x66,
		0xbb, 0xff, 0xbb, 0x66, 0xff, 0x66,
		0xff, 0x00, 0xff, 0x00, 0xff, 0xff, 0x00, 0xff, 0x00, 0xff,
		0xff, 0x00, 0xff, 0x00, 0xff, 0xff, 0x00, 0xff, 0x00, 0xff,
		0xff, 0xff,
		0xff, 0xff,
		0x77, 0xbb, 0x77, 0xee,
		0x77, 0xbb, 0x77, 0xff, 0xee, 0xff,	
		0x77, 0xbb, 0x77, 0xff, 0xee, 0xff,
		0xff, 0x77, 0xbb, 0x77, 0xff, 0xff, 0xee, 0xff,
		0x99, 0x77, 0x99,
		0x99
	};
	u8 i = 0;
	while (i < 61)
	{
		kprint_colored(char_map[i], color_map[i]);
		i++;
	}
}

void	kprint_colored(u8 *str, u8 attr)
{
	while (*str)
	{
		if (*str == '_')
			putchar(*str, 0x00);	
		else
			putchar(*str, attr);
		str++;
	}
}
