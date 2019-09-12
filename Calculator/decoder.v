// This module decodes the 8 bit values array and outputs the relevant information in numberKey, operatorKey, equalKey, resetKey, and clearKey each of which are 5 bit registers with 1 
// enable bit followed by 4 information bits. 
module decoder(newClock, values, numberKey, operatorKey, equalKey, resetKey, clearKey);
	input newClock;
	input wire [7:0] values; // input 8 bit values wire
	
	output reg [4:0] numberKey; // Output registers that carry the relevant information
	output reg [4:0] operatorKey;
	output reg [4:0] equalKey;
	output reg [4:0] resetKey;
	output reg [4:0] clearKey;

	always @(values) // Everytime values changes, the outputs change and output the following:
	begin
		case(values)
		8'b01110111: numberKey <= 5'b10001;// 1 Number keys indicate a numeric input
		8'b10110111: numberKey <= 5'b10010;// 2
		8'b11010111: numberKey <= 5'b10011;// 3
		8'b01111011: numberKey <= 5'b10100;// 4
		8'b10111011: numberKey <= 5'b10101;// 5
		8'b11011011: numberKey <= 5'b10110;// 6
		8'b01111101: numberKey <= 5'b10111;// 7
		8'b10111101: numberKey <= 5'b11000;// 8
		8'b11011101: numberKey <= 5'b11001;// 9
		8'b10111110: numberKey <= 5'b10000;// 0
		8'b11100111: operatorKey <= 5'b11111;// F Operator keys indicate +(F), -(E) or x(D)
		8'b11101011: operatorKey <= 5'b11110;// E
		8'b11101101: operatorKey <= 5'b11101;// D
		8'b11011110: equalKey <= 5'b11011;// B  Equal key indicates the equals sign was pressed
		8'b11101110: clearKey <= 5'b11100;// C	Clear key indicates the clear key was pressed
		8'b01111110: resetKey <= 5'b11010;// A Reset key indicates that the reset key was pressed
		// Defaults
		default:begin // Default states for each of the Keys
		operatorKey <= 5'b00000;
		equalKey <= 5'b00000;
		clearKey <= 5'b00000;
		resetKey <= 5'b00000;
		numberKey <= 5'b00000;
		end
		endcase
	end
endmodule	