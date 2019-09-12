// The following module works as a memory management module that alters a signal and a register based on a memoryFlag that is set in the FSM.
// The function has 2 important data output lines, bcdOutput, the new display register that is sent to the display manager, and bcdOutputMemory
// the output for the memory register. 
module memoryManagement(clk, memoryFlag, bcdInput, bcdOutput, bcdInputMemory, bcdOutputMemory);
	
	input clk;
	input [4:0] memoryFlag; // Flag that indicates how to treat the inputs
	input [31:0] bcdInput; // origional display
	input [12:0] bcdInputMemory; // memory we have stored that is in a BCD format
	
	//output reg [11:0] binaryOperand; // register that ensures the retrieved value works in calculation
	output reg [31:0] bcdOutput; // new display
	output reg [12:0] bcdOutputMemory; // new memory that we may/may not have updated.
	
	// wire [11:0] operand;
	reg negativeSign; // 1 if the user has entered a past input, 0 otherwise.
		
	parameter Store = 2'b01, Retrieve = 2'b10, Clear = 2'b11;
	
	//bcdDecoder memoryDecoder(.sign(0), .input1(bcdMemory[3:0]), .input2(bcdMemory[7:4]), .input3(bcdMemory[11:8]), .binaryOutput(operand)); // WHEN we have a negative this needs to change
	
	always @(posedge clk)//clk instead
	begin
	
		// in every case there are 2 streams of data we have to keep in mind. The output display (bcdOutput) and the output memory (bcdMemory)
	negativeSign <= (bcdInput[31]);
		
		case (memoryFlag[1:0])
			// Case 01 in memoryFlag represents that the user wants to store the least significant 3 bit variables in the bcdInput
			Store: begin
			
				bcdOutput <= bcdInput;
				bcdOutputMemory <= {negativeSign, bcdInput[11:0]};
			
			end
			// Case 10 in memoryFlag represents that the user wants to retrieve some memory, display it, and possibly use it
			Retrieve: begin
				bcdOutput <= {{4{negativeSign}}, 16'b0, bcdInputMemory}; // Pad the output with the correct format
 				//bcdOutput <= {20'b0, bcdInputMemory}; // pad the output
				bcdOutputMemory <= bcdInputMemory;
				//binaryOperand <= operand;
			end
			// Case 11 indicates that the user wishes to clear the memory. 
			Clear: begin
				bcdOutput <= bcdInput;
				bcdOutputMemory <= 12'b0;

			end
			// Default state with any unknown state
			default: begin
				
				bcdOutput <= bcdInput;
				bcdOutputMemory <= bcdInputMemory;
			
			end
		endcase
	end

endmodule