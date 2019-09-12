// This function samples in pulses at every positive edge of a clock tick and performs debouncing on the input signal
// This function is not currently used
module pulseDebouncer(keyPulse, Key, newClock);

	input [4:0] Key;
	input newClock;
	
	output reg [4:0] keyPulse = 5'b00000;	
	reg Q = 0;
	
	always @ (posedge newClock)
	begin
		keyPulse <= 5'b00000;	
		
		if ((Key[4]) & ~Q)
		begin
			keyPulse <= Key[4:0];
		end
		
	Q <= Key[4];
	end
	endmodule