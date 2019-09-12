// Clock divider that reduces a clock's frequency down to a number based on the specified preScaler.
// The duty cycle of the new clock is 50%.
// Everytime the 50MHz clock ticks, we increase the count in a variable that is then compared to a prescaler.
// When we reach the prescaler then we output a high in the new clock which effectively divides the frequency.
module clockDivider(CLOCK_50, newClock, preScaler);

	input CLOCK_50; // input 50MHz clock
	output reg newClock; // output clock that depends on prescaler
	input [19:0] preScaler; // 20 bit prescaler 
	reg [25:0] counter; // counter that is used in conjunction with the prescaler
	always @(posedge CLOCK_50)
		begin
		counter = counter + 1; // Counts clock ticks
			if (counter == preScaler) // reached prescaler so we reset clock for the next count
			begin
				newClock = 1;
				counter = 0;
			end
				
			if (counter == (preScaler>>1)) // preScaler >> 1 indicates prescaler/2. we push out clock to low at this point to ensure that we have a 50% duty cycle
			begin
				newClock = 0;
			
			end
			
		end

endmodule
