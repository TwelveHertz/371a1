// Stored an operator based on the operatorPulse signal from the control unit.
// We will be able to store the information into a seperate register, storeOP, which will hold the value unlike the operatorPulse
module storeOperator (operatorPulse, storeOp);
	input [4:0] operatorPulse;
	output reg [3:0] storeOp;
	
	always@(posedge operatorPulse[4]) // whenever the enable bit goes from low to high we store the information in the operator pulse into storeOP
		storeOp = operatorPulse [3:0];
		
endmodule