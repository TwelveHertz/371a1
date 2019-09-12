// The following module works to control the operand registers based on inputs, negative signs, memory, and special operations flags (clear, reset etc.)
// The output is register which represents either of the two operands, and is assigned to either of them in register transfer
// 
module storeBCD (clk, memoryFlag, numberPulse, clear, reset, bcdOutput, negativeSignA, negativeSignB, register, ld_a, ld_b);
	input [4:0] numberPulse, memoryFlag; // inputs that can either be memory or the number form the matrix keypad
	input clk, clear, reset, negativeSignA, negativeSignB, ld_a, ld_b; // flags that determine how we deal with bcdOutput
	input [12:0] bcdOutput;
	
	
	output reg [12:0] register;
	
	always @(posedge clk) // Output is synchronized with clock
	begin
	if (numberPulse[4] == 1)
		register = {register[12], register[7:0], numberPulse[3:0]}; // normal functionality will simply concatenate register which 'shifts' digits to the left
	else if (clear || reset)
		register = {negativeSignA, 12'b000000000000}; // If clear and reset will remove the information in register
	else if (memoryFlag == 5'b10010) // a memoryFlag of 10010 indicates that we want to retrieve memory
		register = bcdOutput[12:0];
	else if (memoryFlag == 5'b10000) // a memoryFlag of 10000 indicates backspace
		register[11:0] = {{4'b0000}, register[11:4]};
	else if(ld_a)
		register = {negativeSignA, register[11:0]}; // Loads a and b with corresponding negatives
	else if(ld_b)
		register = {negativeSignB, register[11:0]};
	end
endmodule