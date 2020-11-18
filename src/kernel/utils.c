#include "./utils.h"
#include "../drivers/screen.h"
#include "../common.h"

void	kprint_rick_and_morty()
{
	u8 *char_map[] = {
		"..#.#.#\n",
		"..#####....", "#####\n",
		"..#", "###", "#....", "#", "###", "#\n",
		"..#", "#", "#", "#", "#....", "#", "#", "#", "#", "#\n",
		"..#", "#", "#", "#", "#....", "#", "#", "#", "#", "#\n",
		"..#####....", "#####\n",
		"...###.....", ".###.\n",
		"..##", "#", "##....", "#####\n",
		"..##", "#", "##....", "#", "###", "#\n",
		"..##", "#", "##....", "#", "###", "#\n",
		"..#", "#", "#", "#", "#....", "#", "###", "#\n",
		"...##", "#......", "###\n",
		"...#.#......#.#\n"
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
		if (*str == '.')
			putchar(*str, 0x00);	
		else
			putchar(*str, attr);
		str++;
	}
}
