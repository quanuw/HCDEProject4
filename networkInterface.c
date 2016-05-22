// Brandon Ngo, Brad Marquez, Quan Nguyen
// EE 371 - Lab 4
//
// networkInterface.c
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#define DATA_SIZE 16
#define BUFFER_SIZE 4
#define TIME_OUT 150000
 
#define leds (volatile char *) 0x3020
// #define sendAddress (volatile char *) 
// #define receiveAddress (volatile char *) 
// #define charReceived (volatile char *) 

// IOWR_ALTERA_AVALON_PIO_DATA(targetAddress, aValue); : WRITE
// aValue = IOWR_ALTERA_AVALON_PIO_DATA(sourceAddress); : READ
int main() {
	char command = ' ';
	while(1){
	   alt_putstr("Would you like to receive or send?\n\nPossible Commands:\n1. \'S\' - Send Mode\n2. \'R\' - Receive Mode\n");
	   while (command != 'S' && command != 'R') {
        	command = alt_getchar();
        	alt_getchar();
        	alt_printf("Mode: %c\n", command);
        	if (command != 'S' && command != 'R') {
            	alt_putstr("\nThis is not a valid command. Please enter a valid command:\n\nPossible Commands:\n1. \'S\' - Send Mode\n2. \'R\' - Receive Mode\n");
        	}
    	}
		char command2 = ' ';
		if (command == 'S') {
		   while (command2 != 37) { // escape
			   alt_putstr("Enter an ASCII character: ");
			   while (command2 >= 0 && command2 < 256) {
					command2 = alt_getchar();
					alt_getchar();
					alt_printf("Character: %c\n", command2);
					if(command2 < 0 || command2 >= 256) {
						alt_putstr("\nThis is not a valid character. Please enter another character. \n");
					}
				}
				IOWR_ALTERA_AVALON_PIO_DATA(sendAddress, command2 + '0');
				*leds = *IOWR_ALTERA_AVALON_PIO_DATA(sendAddress);
		   }
		} else if (command == 'R') {
			int count = 0;
			char command3 = ' ';
			while (go) {
				if (count > TIME_OUT){
					alt_putstr("Would you like to continue receiving?\n\nPossible Commands:\n1. \'Y\' - Yes\n2. \'N\' - No\n");
					while (command3 != 'Y' && command3 != 'N') {
						command3 = alt_getchar();
						alt_getchar();
						alt_printf("Command: %c\n", command3);
						if (command3 != 'Y' && command3 != 'N') {
							alt_putstr("\nThis is not a valid command. Please enter a valid command:\n\nPossible Commands:\n1. \'Y\' - Yes\n2. \'N\' - No\n");
						}
					}
					if (command3 == 'N') {
						continue;
					}
					count = 0;
				}
				// if characterReceived {
					// print character
					// store character in register
				//}
			}
		}
	}
	return 0;
}