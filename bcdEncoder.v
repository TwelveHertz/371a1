// This converts a number from a signed bianry number to 6 4-bit BCD's and a sign that can be passed into a display.
// A simple division and remainder method is used here to encode binary signals. It works by extracting each digit in the ones, tens, hundreds, thousands, tens of
// thousands and hundreds of thousands positions through division by the corresponding power of 10 to reduce the number to be between 0-9 then using modulus 10 to 
// extract the number
module bcdEncoder(signedInput, sign, binary1, binary2, binary3, binary4, binary5, binary6);

	input [20:0] signedInput; // 21 bit signed register representing the value to convert.

	output reg [3:0] binary1; // This is the LSB for the BCD
	output reg [3:0] binary2; 
	output reg [3:0] binary3; 
	output reg [3:0] binary4; 
	output reg [3:0] binary5; 
	output reg [3:0] binary6; // This is the MSB for the BCD
	// a 1 in sign will indicate that we have a negative number.
	output reg sign;
	
	reg [20:0] modulus;
	
	always @(signedInput)
	begin
	if (signedInput[20]) // convert to a positive 2's compliment if the number is negative
		begin
		modulus <= ~signedInput + 1'b1; // modulus is the number we are working with
		sign <= 1;	
		end
	else 
		begin
		modulus <= signedInput;
		sign <= 0;
		end
	binary1 <= (modulus)%10; 
	binary2 <= (modulus/10)%10; // division the modulus will allow the extraction of the digit in the corresponding power of 10's position
	binary3 <= (modulus/100)%10;
	binary4 <= (modulus/1000)%10;
	binary5 <= (modulus/10000)%10;
	binary6 <= (modulus/100000)%10;
	end
	
endmodule