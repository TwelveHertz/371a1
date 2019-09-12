// This module acts as a repeater for a single pulse. I.e it repeats the pulse but with a 1 clock cycle delay
// the module detects the enable bit which allows it to then repeat the functionality. This module can be adapted to repeat the pulse, but for 2 clock cycles
// instead of 1
module twoClockPulse(pulse, doublePulse, clock);
	input [4:0] pulse; // 5 bit 1 clock cycle long pulse to be repeated
	input clock;


	output reg [4:0] doublePulse; // repeated pulse that can last 1 or 2 clock cycles

	//reg [1:0] count;

	always @(posedge clock) // at the clock positive edge we check for the enable bit. If it is there then we output doublePulse but with a 1 clock cycle delay
	begin

		if (pulse[4] == 1)
		begin
			doublePulse <= pulse;
			//count <= 2'b01;
		end
		/*
		else if (count == 2'b01) // Uncomment this part and count <= 2'b01 for a 2 clock cycle long repeated pulse
		begin
			doublePulse <= doublePulse;
			count <= 2'b0;
		end
		*/
		else 
		begin
			doublePulse <= pulse; // resetting doublePulse back to pulse, which should have fallen to 0
		end
	end

endmodule
