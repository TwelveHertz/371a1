// This module is responsible for debouncing decoded button outputs. If the output remains constant for 4 clock cycles
// then the relevant information will be output through key. key is kept at 5 bits so that earlier code such as pulseDebouncer can be reused. The MSB goes high to 
// indicate a button being pressed. the least significant 3 bits represent the button information (i.e which button was pressed).
module debouncer(newClock, information, key);

	// newClock is used to ensure a constant frequency for polling
	input newClock;
	input [4:0] information; // information is a 5 bit input that tells the user whether a button was pressed, and the appropriate information
	

	output reg [4:0] key;
	reg [19:0] ringCount; // This register stores all our stuff.
	
	
	always @(newClock)
	begin
		
		ringCount <= {ringCount[14:0], information}; // concantenate the information for storage in a moving ring counter.
	
		if ((ringCount[4:0] == ringCount[9:5]) && (ringCount[19:15] == ringCount[14:10]) && (ringCount[9:5] == ringCount[14:10])) // check if all the ringcounts are the same, if so then there is no bouncing and we can be confident when outputting a signal
		begin
			
			// This key is the output and should display a data line at constant until the input is no longer the same as the previous 4 iterations of the clock
			key <= ringCount[9:5];
	
		end
		else 
		begin
			key <= 5'b0;
		end
	
	end
	
endmodule