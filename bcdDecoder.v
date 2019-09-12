// This module takens in 3 4 bit wide BCD values, and a sign and converts them into a binary equivalent by multiplying them by their respective base 10 powers.
// 1 signed 11 bit binary output is large enough such that it is able to store the values.
module bcdDecoder(sign, input1, input2, input3, binaryOutput);

	input sign; // a 1 in sign indicates a negative
	// Note that inputs will only be of values 0-9. Therefore, the maximum value is 999 which gives
	// an output of 11'b01111100111 for 999 and 11'b10000011001 for -999 (negative indicated by a
	// sign bit of 1).
	input [3:0] input1; // input 1 indicates the LSB
	input [3:0] input2;
	input [3:0] input3; // input 3 indicates the MSB

	//output reg [17:0] LEDR;
	output reg signed [10:0] binaryOutput; // 11 bits to store a 2's compliment number from -999 to 999 2^n+1

	// with any changes to our number, we re-decode the value. negative isnt included here as it is redundant, users cannot suddenly choose to have a negative number without either of the inputs changing
	always@(input1, input2, input3) 
	begin
	// Binary output = LSB*1 + ... + MSB*100
	// note that in verilog, multiplication uses context-determined expression. s indicates signed, though it is currently redundant.
	// it could be used if we decide that input1, 2, or 3 are signed.
	binaryOutput = input1[3:0]*11'sb00000000001 + input2[3:0]*11'sb00000001010 + input3[3:0]*11'sb00001100100;
	
	if (sign == 1'b1) 
		binaryOutput = ~binaryOutput + 1'b1; // Conversion into 2's compliment negative
	//LEDR <= binaryOutput;
	end

endmodule