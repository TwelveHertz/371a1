module TOP (
	input CLOCK_50,
	input [3:0] ROW,
	input [17:0] SW,
	input [3:0] KEY,
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
	output [4:0] LEDG,
	output [3:0] COL);

	wire clock_500Hz, ld_a, ld_b, ld_op, ld_r, ld_m, clear, encodeSign, reset, toggleNegativeSignalA, toggleNegativeSignalB;
	wire [1:0] disp_sel;
	wire [3:0] digit1, digit2, digit3, digit4, digit5, digit6, operator, storeOp, storeOp1;
	wire [4:0] buttonPulse, numberPulse, operatorPulse, equalPulse, resetPulse, clearPulse, negativePulse, doubleButton;
	wire [12:0] BCDoperand, storeA, storeB, bcdMemory;
	wire [24:0] BCDanswer, storeAnswer;
	wire [31:0] displayReg, register;
	
	wire signed [10:0] binaryOperandA, binaryOperandB;
	wire signed [20:0] binaryAnswer;

	// Call the input manager to retireve matrix keypad, button, and switch information
	inputManager iM1 
	(
		.CLOCK_50(CLOCK_50), 
		.ROW(ROW), 
		.COL(COL), 
		.SW(SW), 
		.KEY(KEY), 
		.numberPulse(numberPulse), 
		.buttonPulse(buttonPulse), 
		.operatorPulse(operatorPulse), 
		.equalPulse(equalPulse), 
		.resetPulse(resetPulse), 
		.clearPulse(clearPulse), 
		.negativePulse(negativePulse), 
		.newClock(clock_500Hz)
	);
	
	// toggle will indicate whether operandA or operandB is negative
	toggle t1
	(
		.clk(clock_500Hz), 
		.reset(reset), 
		.clear(clear), 
		.ld_a(ld_a), 
		.ld_b(ld_b), 
		.ld_op(ld_op), 
		.memory(bcdMemory),
		.memoryFlag(doubleButton),
		.pulse(negativePulse), 
		.toggledOutputA(toggleNegativeSignalA), 
		.toggledOutputB(toggleNegativeSignalB)
	);	
	
	// storeBCD here is responsible for taking the numberPulse input and storing it into the operand register which is then sent for display
	storeBCD sB1
	(
		.clk(clock_500Hz), 
		.memoryFlag(doubleButton), 
		.numberPulse(numberPulse), 
		.clear(clear), 
		.reset(reset), 
		.bcdOutput(bcdMemory), 
		.negativeSignA(toggleNegativeSignalA), 
		.negativeSignB(toggleNegativeSignalB), 
		.register(BCDoperand), 
		.ld_a(ld_a), 
		.ld_b(ld_b)
	);
	
	// twoClockPulse outputs a pulse followup button pulse that is identical to the input button pulse, just 1 clock cycle delayed. This is used in storeBCD
	twoClockPulse	tC1
	(
		.pulse(buttonPulse), 
		.doublePulse(doubleButton), 
		.clock(clock_500Hz)
	);
	
	// decodes operand A as required from BCD to binary
	bcdDecoder bD1 
	(
		.sign(storeA[12]), 
		.input1(storeA[3:0]), 
		.input2(storeA[7:4]), 
		.input3(storeA[11:8]), 
		.binaryOutput(binaryOperandA)
	);
	// decodes operand B as required from BCD to binary
	bcdDecoder bD2 
	(
		.sign(storeB[12]), 
		.input1(storeB[3:0]), 
		.input2(storeB[7:4]), 
		.input3(storeB[11:8]), 
		.binaryOutput(binaryOperandB)
	);
	// performs the calculations for the system
	ALU ALU1 
	(
		.operandA(binaryOperandA), 
		.operandB(binaryOperandB), 
		.equalPulse(equalPulse), 
		.operator(storeOp1), 
		.answer(binaryAnswer)
	);
	
	// encodes the result from binary to BCD
	bcdEncoder bE1
	(
		.signedInput(binaryAnswer), 
		.sign(encodeSign), 
		.binary1(digit1), 
		.binary2(digit2), 
		.binary3(digit3), 
		.binary4(digit4), 
		.binary5(digit5), 
		.binary6(digit6)
	);
	
	// store the operator information from operatorPulse
	storeOperator sO1
	(
		.operatorPulse(operatorPulse), 
		.storeOp(storeOp1)
	);
	
	// format a 25 bit wire that holds the answer information from the calculation
	assign BCDanswer = {encodeSign, digit6, digit5, digit4, digit3, digit2, digit1};
	
	// The FSM is the control unit of our programme that sets and lowers flags which control other processes
	FSM fsm1
	(
		.clk(clock_500Hz), 
		.op_in(operatorPulse[4]), 
		.digit_in(numberPulse[4]), 
		.execute_in(equalPulse[4]), 
		.reset(resetPulse[4]),
		.clear_in(clearPulse[4]),
		.buttonPulse(buttonPulse),
		.disp_sel(disp_sel), 
		.ld_a(ld_a), 
		.ld_b(ld_b), 
		.ld_op(ld_op), 
		.ld_r(ld_r), 
		.clear(clear),
		.LED(LEDG),
		.resetAll(reset)
	);
	
	// creates a new 1 clock cycle delayed signal for memory retrieval
	recall r1
	(
		.clk(clock_500Hz), 
		.buttonPulse(buttonPulse), 
		.ld_m(ld_m)
	);
	

	// Transfer registers in the program. This is the programs internal memory manager that shifts register information around
	registerTransfer rT1
	(
		.ld_a(ld_a), 
		.ld_b(ld_b), 
		.ld_op(ld_op), 
		.ld_r(ld_r), 
		.ld_m(ld_m),
		.currentOperand(BCDoperand), 
		.result(BCDanswer), 
		.operator(operatorPulse[3:0]), 
		.storeA(storeA), 
		.storeB(storeB), 
		.storeResult(storeAnswer), 
		.storeOp(storeOp),
		.memory(bcdMemory)
	);	
	
	// memory module that is responsible for dealing with all of the users memory requests
	memoryManagement calcultorMemory
	(
		.clk(clock_500Hz),
		.memoryFlag(buttonPulse[4:0]), 
		.bcdInput(register), 
		.bcdInputMemory(bcdMemory), 
		.bcdOutput(displayReg), 
		.bcdOutputMemory(bcdMemory)
	);
	
	// selects what to display
	displayMUX dMUX1
	(
		.clk(clock_500Hz), 
		.disp_sel(disp_sel), 
		.storeA(storeA), 
		.storeB(storeB), 
		.BCDanswer(BCDanswer), 
		.register(register)
	);


	// takes the display information and generates the corresponding outputs to be outputted to the 7-seg displays
	displayManager dM1
	(
		.register(displayReg), 
		.HEX0(HEX0), 
		.HEX1(HEX1), 
		.HEX2(HEX2), 
		.HEX3(HEX3), 
		.HEX4(HEX4), 
		.HEX5(HEX5), 
		.HEX6(HEX6), 
		.HEX7(HEX7)
	);
	
endmodule