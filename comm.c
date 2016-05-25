// Brandon Ngo, Brad Marquez, Quan Nguyen
// EE 371 - Lab 4
//
// application.c
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"

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
		/*while(1){
			*leds = 0b11111111;
		}*/

		/*
		char command = (char) 30;
		while (command != 31) { // escape - space
		   alt_putstr("Enter an ASCII character: ");
		   while (!(command >= 32 && command < 128)) {
				command = alt_getchar();
				alt_getchar();
				if(command < 32 || command >= 128) {
					alt_putstr("\nThis is not a valid character. Please enter another character. \n");
				} else {
					alt_printf("Transmitted Character: %c\n", command);
				}
			}
		    alt_printf("Character: %i\n", (unsigned int) command);
		    alt_putstr("\npast here1");
			write(command);
			alt_putstr("\npast here");
			// Read data
			char values = IORD_ALTERA_AVALON_PIO_DATA(receiveAddress);
			alt_printf("\n%c\n", values);
			IOWR_ALTERA_AVALON_PIO_DATA(leds, values);
			alt_printf("Received Character: %c\n", values);
		}*/
		while (1) {
			char command = ' ';
			alt_putstr("Enter an ASCII character: ");
			command = alt_getchar();
			alt_getchar();
			alt_printf("Transmitted Character: %c\n", command);
			write('0' + command + '1');
			char values = IORD_ALTERA_AVALON_PIO_DATA(receiveAddress);
			alt_printf("\n%c\n", values);
			IOWR_ALTERA_AVALON_PIO_DATA(leds, values);
			alt_printf("Received Character: %c\n", values);
		}
		return 0;
	}


// Writes given character
void write(char command) {
	IOWR_ALTERA_AVALON_PIO_DATA(sendAddress, command);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 1);
	IOWR_ALTERA_AVALON_PIO_DATA(transmitEnable, 1);
	usleep(4);
	IOWR_ALTERA_AVALON_PIO_DATA(load, 0);
	IOWR_ALTERA_AVALON_PIO_DATA(transmitEnable, 0);
}

