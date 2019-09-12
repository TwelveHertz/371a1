// This module generates the correct 7 bit wide information register to be outputted to the 7-seg displays. 
// The module takes in a 4 bit register that will then output 0-9 or a - sign depending on the input.
module displayOperand (register, Hex);
	input [3:0] register; // 4 bit register with information
	output reg [6:0] Hex; // 7 bit hex reg
	
	always @(*) // whenever anything changes, update the hex register with the corresponding information based on the current input
	begin
		case(register)
		4'b0000: Hex = 7'b1000000; // 0
		4'b0001: Hex = 7'b1111001; // 1
		4'b0010: Hex = 7'b0100100; // 2
		4'b0011: Hex = 7'b0110000; // 3
		4'b0100: Hex = 7'b0011001; // 4
		4'b0101: Hex = 7'b0010010; // 5
		4'b0110: Hex = 7'b0000010; // 6
		4'b0111: Hex = 7'b1111000; // 7   
		4'b1000: Hex = 7'b0000000; // 8
		4'b1001: Hex = 7'b0010000; // 9
		4'b1111: Hex = 7'b0111111; // -
		default:	Hex = 7'b1111111;
		endcase
	end
		
endmodule