  // Top module that should probably be renamed
// Currently it is only taking in inputs that are being read from the matrix keyboard
module RingCounter (CLOCK_50, ROW, COL, SW, keyPulse, buttonPulse, LEDG, HEX0, HEX1, HEX2);

	input CLOCK_50;
	input [3:0] ROW;
	input [3:0] SW;
	
	output [6:0] HEX0, HEX1, HEX2;
	output [7:0] LEDG;
	output [3:0] COL;
	output [4:0] buttonPulse;
	output [4:0] keyPulse;
	
	wire [11:0] register;
	
	assign test = register;
	
	inputmanager matrixInputManager (CLOCK_50, ROW, COL, SW, keyPulse, buttonPulse, specialPulse);
	storeBCD currentOperand(keyPulse, register);
		
	displayOperand displayCurrentOperand1(register[3:0], HEX0);
	displayOperand displayCurrentOperand2(register[7:4], HEX1);
	displayOperand displayCurrentOperand3(register[11:8], HEX2);

endmodule