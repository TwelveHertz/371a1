// This module is used to toggle 2 flags based on a button pulse, and FSM outputs.
// Currently this module is only being used for the negative bit indication for operands
module toggle(clk, pulse, reset, clear, ld_a, ld_b, ld_op, memoryFlag, memory, toggledOutputA, toggledOutputB);
	input [12:0] memory;
	input clk; // 500hz clock input
	input [4:0] pulse, memoryFlag; // negative pulse from input manager
	input reset, clear, ld_op; // special operation (reset, clear, operation) flags
	output reg toggledOutputA, toggledOutputB; // toggled negative bits
	input ld_a, ld_b; // FSM flags that indicate whether we are currently dealing with operand A or B

	always @(posedge clk)
	begin
		

		if (reset) // if reset, then we remove all our negatives
		begin
			toggledOutputA <= 0;
			toggledOutputB <= 0;
		end
		else if (clear && ld_a) // operand a's negative bit is cleared if it itself is cleared
			toggledOutputA <= 0;
		else if (clear && ld_b) // operand b's negative bit is cleared if it itself is cleared
			toggledOutputB <= 0;
		else if ((memoryFlag == 5'b10010) && (ld_a))
			toggledOutputA <= memory[12];
		else if ((memoryFlag == 5'b10010) && (ld_b))
			toggledOutputB <= memory[12];
		else if(ld_a && pulse[4]) // operand a's negative bit is toggled on and off if we toggle the switch and we are currently viewing operand a
			toggledOutputA <= ~toggledOutputA;
		else if(ld_b && pulse[4]) // operand b's negative bit is toggled on and off if we toggle the switch and we are currently viewing operand b
			toggledOutputB <= ~toggledOutputB;
		
	end


endmodule