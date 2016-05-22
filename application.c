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
		command = ' ';
		while (command != 37) { // escape
		   alt_putstr("Enter an ASCII character: ");
		   while (command2 >= 0 && command2 < 256) {
				command2 = alt_getchar();
				alt_getchar();
				if(command2 < 0 || command2 >= 256) {
					alt_putstr("\nThis is not a valid character. Please enter another character. \n");
				} else {
					alt_printf("Transmitted Character: %c\n", command2);
				}
			}
			IOWR_ALTERA_AVALON_PIO_DATA(sendAddress, command2 + '0');
			*leds = *IOWR_ALTERA_AVALON_PIO_DATA(sendAddress);
			alt_printf("Received Character: %c\n", receiveAddress);
		}
	}
	return 0;
}