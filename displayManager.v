// The following module acts as an organizer for displayOperand. This module splits the 32 bit wide register into 4 bit chunks which are then went to be generate a
// display for their corresponding 7-segment display (represented by HEX 0 - 7) based on location. These are then output, and displayed.
module displayManager (register, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
	input [31:0] register; // input 32 bit register 
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7; // eight output hex's
	
	displayOperand d0(register[3:0], HEX0); // register is split into 8 4 bit wide registers that are then fed into displayOperand to generate a correct output for their 
	displayOperand d1(register[7:4], HEX1); // corresponding 7-seg display.
	displayOperand d2(register[11:8], HEX2);
	displayOperand d3(register[15:12], HEX3);
	displayOperand d4(register[19:16], HEX4);
	displayOperand d5(register[23:20], HEX5);
	displayOperand d6(register[27:24], HEX6);
	displayOperand d7(register[31:28], HEX7);
		
endmodule
