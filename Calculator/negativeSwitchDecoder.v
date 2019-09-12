// The following module works by extracting information from a switch in a certain position, and decodes it into the standard 5 bit format which we debounce and pulse later.
// The module iscurrently used for our negative switch.
module negativeSwitchDecoder(SW17, negativeKey);

	input SW17;
	output reg [4:0] negativeKey; // 5 bit output reg
	
	
	always @(SW17) // whenever switch 17 goes high, we output a 5 bit register
	begin
	
		if (SW17)
		begin
			negativeKey <= 5'b10001;
		end
		else
		begin
			negativeKey <= 5'b0; // reset the key such that the user can re-toggle this state
		end
	
	end
	
	
	
endmodule
	