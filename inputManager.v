// Input manager is the module that contains the interfacing logic with the hardware. The board takes in the matrix keyboard rows (ROW) and columns(COL), switch inputs(SW), and button (KEY)
// and outputs the following important outputs:
// numberPulse: - a single clock cycle wide pulse that indicates whether or not a number was pressed, and the relevant information such as which number on the keypad was pressed (0-9)
// buttonPulse: - a single clock cycle wide pulse that indicates whether or not a button (or switch) was pressed, and the relevant information such as which button was pressed (PB0-4) or (SW0-4)
// operatorPulse: - a single clock cycle wide pulse that indicates whether or not an operator key was pressed, and the relevant information such as which operator was pressed (+(F), -(E), or x(D))
// equalPulse: - a single clock cycle wide pulse that indicates whether or not the reset sign was pressed (B)
// resetPulse: - a single clock cycle wide pulse that indicates whether or not the reset key was pressed (A)
// clearPulse: - a single clock cycle wide pulse that indicates whether or not the clear key was pressed (C)
// negativePulse: - a single clock cycle wide pulse that indicates whether or not the negative input key was toggled (SW17)
// newClock: - a 500hz clock signal

module inputManager(CLOCK_50, ROW, COL, SW, KEY, numberPulse, buttonPulse, operatorPulse, equalPulse, resetPulse, clearPulse, negativePulse, newClock);

	input CLOCK_50; // 50MHz base clock we prescale off to get the 500Hz clock
	input [3:0] ROW; // Rows of the matrix keypad that have an active low
	input [17:0] SW; // Switches input that can be used both for the negative switch and for memory if needed
	input [3:0] KEY; // Button inputs that are active low
	
	output [3:0] COL; // Columns of the matrix keypad that we raise take low 
	output newClock; // newClock that has been prescaled. 
	
	// Output pulses that are 1 pulse wide. Each pulse is in the following format: XYYYY where X is the enable bit, and Y is the corresponding information
	output [4:0] buttonPulse, numberPulse, operatorPulse, equalPulse, resetPulse, clearPulse, negativePulse;	
	
	// Intermediate wires that carry information between modules as each signal is processed for the matrix keypad.
	wire [4:0] numberKey, operatorKey, equalKey, clearKey, resetKey;
	wire [4:0] numberBlock, operatorBlock, equalBlock, clearBlock, resetBlock;
	
	// Button and Switch information. Each of these will be of the same 5 bit wire format as with the matrix keypad information
	wire [4:0] buttonInformationBlock, negativeKey;
	wire [4:0] buttonInformation, negativeBlock;
	wire [7:0] values;

	// clockDivider that generates a 500Hz clock by dividing CLOCK_50 by a 100000 prescaler
	clockDivider clock500Hz(CLOCK_50, newClock, 100000);
	
	// The data sequence is input -> decoder -> debouncer -> pulser
	
	
	// Retrieve input
	matrixRingCounter keypadMatrixRingCounter(.newClock(newClock), .ROW(ROW), .COL(COL), .values(values));
	
	
	// Decode and split input
	decoder matrixDecoder(.values(values), .numberKey(numberKey), .operatorKey(operatorKey), .equalKey(equalKey), .clearKey(clearKey), .resetKey(resetKey), .newClock(newClock)); 
	
	// Debounce inputs
	debouncer numberDebouncer(.newClock(newClock), .information(numberKey), .key(numberBlock));
	debouncer operatorDebouncer(.newClock(newClock), .information(operatorKey), .key(operatorBlock));
	debouncer equalDebouncer(.newClock(newClock), .information(equalKey), .key(equalBlock));
	debouncer clearDebouncer(.newClock(newClock), .information(clearKey), .key(clearBlock));
	debouncer resetDebouncer(.newClock(newClock), .information(resetKey), .key(resetBlock));
	
	// Pulse inputs
	pulseSignal numberPulser(.keyPulse(numberPulse), .key(numberBlock), .newClock(newClock));
	pulseSignal operatorPulser(.keyPulse(operatorPulse), .key(operatorBlock), .newClock(newClock));
	pulseSignal equalPulser(.keyPulse(equalPulse), .key(equalBlock), .newClock(newClock));
	pulseSignal clearPulser(.keyPulse(clearPulse), .key(clearBlock), .newClock(newClock));
	pulseSignal resetPulser(.keyPulse(resetPulse), .key(resetBlock), .newClock(newClock));
	
	// Retrieve and decode buttons (or switches)
	//buttonPressDecoder buttonBoardDecoder(.newClock(newClock), .SW(SW), .buttonInformation(buttonInformationBlock));
	buttonPressDecoder buttonBoardDecoder(.newClock(newClock), .SW(KEY), .buttonInformation(buttonInformationBlock));
	
	// Debounce buttons (or switches)
	debouncer buttonDebouncer(.newClock(newClock), .information(buttonInformationBlock), .key(buttonInformation));
	
	// Pulse input 
	pulseSignal buttonPulser(.keyPulse(buttonPulse), .key(buttonInformation), .newClock(newClock)); 
	
	// Retrieve and decode negative switch
	negativeSwitchDecoder negativeIndicator(.SW17(SW[17]), .negativeKey(negativeKey));
	
	// Debounce the switch
	debouncer negativeDebouncer(.newClock(newClock), .information(negativeKey), .key(negativeBlock));
	
	// Pulse the signal
	pulseSignal negativePulser(.keyPulse(negativePulse), .key(negativeBlock), .newClock(newClock));

endmodule