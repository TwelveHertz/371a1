// This module checks for memory recall and, similar to the repeater outputs a 1 bit signal that lags 1 clock cycle behind buttonPulse. 
// This module checks for 1 specific case of buttonPulse (the recall button PB2) and outputs a high if it has been pressed.
module recall (clk, buttonPulse, ld_m);
	input [4:0] buttonPulse; // input button pulse from input manager
	input clk;
	output reg ld_m; // output a flag for load memory
	
	always@(posedge clk) // at every clock cycle we check buttonPulse and output high and low depending on what the signal is.
		if (buttonPulse == 5'b10010)
			ld_m = 1;
		else 
			ld_m = 0;
		
endmodule

				