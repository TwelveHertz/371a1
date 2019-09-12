// This module is responsible for managing the internal registers of the calculators and acts based on flags from the FSM and pushbuttons.
// There are a series of outputs that correspond to operand A and B (StoreA, StoreB), calculated result (storeResult), and operator (storeOp) These will be sent to the ALU.
// Inputs include the load a, load b, load operator, load result, and load memory flags (ld_a, ld_b, ld_op, ld_r, ld_m), current operand, memory register, and the output
// register.
module registerTransfer (
	input ld_a, ld_b, ld_op, ld_r, ld_m, // The load a, load b, load operator, load result, and load memory flags
	input [12:0] currentOperand, memory, // current operand, memory register
	input [24:0] result, // calculated result 
	input [3:0] operator, // operator register
	output reg [12:0] storeA, storeB, // operand's a and b storage
	output reg [24:0] storeResult, // result storage
	output reg [3:0] storeOp // operation storage
);	
		
	always @(ld_a, ld_b, ld_op, ld_r, ld_m) // if any of the flags change the update the following registers accordingly
	begin
		if(ld_a) storeA <= currentOperand; 
		if(ld_m) storeB = memory;
		else if(ld_b) storeB <= currentOperand; // storeB is special as it enables users to use memory in operand A and B
		if(ld_r) storeResult <= result;
		if(ld_op) storeOp <= operator;
	end
			
endmodule