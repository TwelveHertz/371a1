// This takes a signal block and outputs a 1 clock cycle wide signal based on newClock's frequency/period.
// key is the block signal, and keyPulse is the pulse signal.
module pulseSignal(keyPulse, key, newClock);


	input [4:0] key; // 5 bit wide input representing the signal to pulse
	input newClock;
	
	output reg [4:0] keyPulse = 5'b00000;	// the signal that we output
	reg Q = 0;
	
	
	always @ (posedge newClock)
	begin
		//reset keyPulse from the signal that it had earlier such that we have a 1 clock cycle wide pulse
		keyPulse <= 5'b00000;	
		
		// checks if the current state is high, while the previous state is low (i.e posedge check on our signal)
		if ((key[4]) & ~Q)
		begin
			keyPulse <= key[4:0]; // if it is then we place the information into keyPulse.
		end
	
	// configure q to use in the next loop, q indicates whether a button was pressed or not.
	Q <= key[4];
	end
	endmodule