// Brandon Ngo, Brad Marquez, Quan Nguyen
// EE 371 - Lab 4
//
// application.c
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#define DATA_SIZE 16
#define BUFFER_SIZE 4
#define TIME_OUT 150000
 
#define leds (volatile char *) 0x3050
#define sendAddress (volatile char *) 0x3080
#define receiveAddress (volatile char *) 0x3020
#define charReceived (volatile char *) 0x3030
#define charSent (volatile char *) 0x3040
#define transmitEnable (volatile char *) 0x3060
#define load (volatile char *) 0x3070

// IOWR_ALTERA_AVALON_PIO_DATA(targetAddress, aValue); : WRITE
// aValue = IORD_ALTERA_AVALON_PIO_DATA(sourceAddress); : READ
void write(char);
int main() {
		char command = ' ';
		while (command != 37) { // escape
		   alt_putstr("Enter an ASCII character: ");
		   while (command >= 0 && command < 128) {
				command = alt_getchar();
				alt_getchar();
				if(command < 0 || command >= 128) {
					alt_putstr("\nThis is not a valid character. Please enter another character. \n");
				} else {
					alt_printf("Transmitted Character: %c\n", command);
				}
			}

			write(command);
			// Read data
			*leds = *IORD_ALTERA_AVALON_PIO_DATA(sendAddress);
			alt_printf("Received Character: %c\n", receiveAddress);
		}
	}
	return 0;
}

// Writes given character
void write(char command) {
	IOWR_ALTERA_AVALON_PIO_DATA(sendAddress, command + '0');
	IOWR_ALTERA_AVALON_PIO_DATA(load, 1);
	IOWR_ALTERA_AVALON_PIO_DATA(transmitEnable, 1);
	usleep(4);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0);
	IOWR_ALTERA_AVALON_PIO_DATA(transmitEnable, 0);
}

