// decodes the button press and outputs the information into buttonInformation to be debounced and pulsed later.
// This function should be able to work bit both KEY and SW. However, due to the unrelaibility of KEY we have chosed to 
// use SW instead. 
module buttonPressDecoder (newClock, SW, buttonInformation);

	input newClock;
	input [3:0] SW;
	//input [3:0] KEY; // KEY is for buttons. Uncomment when neccesary

	output reg [4:0] buttonInformation; // a 5 bit output with information around whether a button was pressed and the corresponding information about which button
	
	// This code selects the right information to output based on which button is currently giving a high.
	always @(SW) // KEY
	begin
			case(SW) // KEY ACTIVE HIGH TO ACTIVE LOW
			4'b1110: buttonInformation <= 5'b10000; 
			4'b1101: buttonInformation <= 5'b10001;
			4'b1011: buttonInformation <= 5'b10010;
			4'b0111: buttonInformation <= 5'b10011;
			// Default
			default: buttonInformation <= 5'b00000;
			endcase
	end
endmodule