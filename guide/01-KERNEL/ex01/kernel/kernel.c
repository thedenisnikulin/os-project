/*------------------------------------------------------------------------------
*	Guide:	01-KERNEL
*	File:	ex01 / kernel / kernel.c
*	Title:	Ядро
* ------------------------------------------------------------------------------
*	Description:
* ----------------------------------------------------------------------------*/


#include "../common.h"
#include "../drivers/screen.h"


s32		kmain()
{
	u16 offset;
	u8 *msg = "Hello\n\nworld";

	clear_screen();
	kprint(msg);	
	return 0;
}
