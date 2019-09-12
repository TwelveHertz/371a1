// The following module selects what we send to the display manager and how it is to be displayed. The module outputs a 32 bit register, and takes in clock, 
// display select, the storage for operands A and B, and BCDanswer (the result of the calculations). Special care is taken in this module to format the outputs 
// appropriately with the right information and correspondng location. Examples will be given of each case.
module displayMUX (clk, disp_sel, storeA, storeB, BCDanswer, register);
	input clk; // clock input
	input [1:0] disp_sel; // display select input
	input [12:0] storeA, storeB; // storage for operands A and B
	input [24:0] BCDanswer; // answer/result register
	
	output reg [31:0] register; // formatted 32 bit register that is sent to display manager
	
	always@(clk)
	begin
	
		case(disp_sel)
		2'b00: register = {{4{storeA[12]}}, 16'b0, storeA[11:0]}; // format the display to have negative at HEX7. This output will look like: nnnn0000000000000000xxxxxxxxxxxx where n is the negative bit, 0's correspond to 0's and x corresponds to the number information which is stored in groups of 4 
		2'b10: register = {{4{storeB[12]}}, 16'b0, storeB[11:0]}; // This output will look the same as the one above but for operand b. 
		2'b11: register = {{4{BCDanswer[24]}}, 4'b0, BCDanswer[23:0]}; // This output will look like: nnnn0000xxxxxxxxxxxxxxxxxxxxxxxx where n indicates a negative and x indicates the bcd number information, split into groups of 4.
		endcase
	end
		
endmodule