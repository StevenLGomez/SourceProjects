
// Simple ncurses test program from:
// https://www.cyberciti.biz/faq/linux-install-ncurses-library-headers-on-debian-ubuntu-centos-fedora/

// Compiles & runs on build VM using: cc -o hello hello.c -lncurses

#include <ncurses.h>

int main(void)
{
	initscr();	/* Starts curses mode     */
	printw("Hello World! Press any key to exit ...");  /* Prints Hello World!"
	refresh();	/* Print it on to the real screen */
	getch();	/* Wait for user input */
	endwin();	/* End curses mode */
	return 0;
}

