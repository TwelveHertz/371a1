//this module clears 
module clear (clk, clear_in, clear);
	input clk;
	input [4:0]clear_in;
	output reg clear;
	
	always@(clk)
	begin
		if (clear_in == 1)
			clear = 1;
		else
			clear = 0;
	end	
	endmodule