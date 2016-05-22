// Brandon Ngo, Brad Marquez, Quan Nguyen
// EE 371 - Lab 4
//
// networkInterface.c
#include "sys/alt_stdio.h"
#define DATA_SIZE 16
#define BUFFER_SIZE 4
#define TIME_OUT 150000
 
#define leds (volatile char *) 0x3020
// define send register
// define receive register
// define character received register
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
				// put dataBuilder(command2) in to appropriate register
				// assigne LEDs to data
		   }
		} else if (command == 'R') {
			int count = 0;
			char command3 = ' ';
			while (1 /*receive register != bits*/) {
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

int * dataBuilder(unsigned char input) {
	int i;
	int temp = input;
	int out[DATA_SIZE];
	
	// Pads data with start bits
	for (i = 0; i < BUFFER_SIZE; i++) {
		out[i] = 0;
	}
	
	// Building the binary version of input
	while (i < DATA_SIZE - BUFFER_SIZE) {
		out[i] = temp % 2;
		temp = temp >> 1;
		i++;
	}
	
	// Pads data with end bits
	for (i = DATA_SIZE - BUFFER_SIZE; i < DATA_SIZE; i++) {
		out[i] = 1;
	}
	
	return out;
}