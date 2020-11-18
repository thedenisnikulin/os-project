#include "../common.h"
#include "../drivers/screen.h"
#include "./utils.h"


s32		kmain()
{	
	clear_screen();
	
	kprint_rick_and_morty();
	
	kprint(
		"- Look Rick, we are in an OS!\n"
		"- Damn Morty, that's fantastic!\n\n"
	);
	kprint("So... Welcome to my OS!\n\n");
	kprint(
		"Actually, the functionality of this OS is limited only to displaying that creepy "
		"ASCII art. No commands, no more features. The only purpose of this OS is "
		"educational - you can follow easy steps in guide/ folder and create your own OS, "
		"just like this. The guide is well-documented and all written in Russian.\n\n"
	);
	kprint(
		"Thank you for your attention!\n"
		"Find me on GitHub: https://github.com/thedenisnikulin"
	);
	return 0;
}
