// The following code is a ring counter module that is responsible for finding the user's inputs on the matrix keypad.
// The module works by implmenting a ring counter in the columns, and polls the rows to check for lows. 
// We output values, a 8 bit information wire that is then decoded later.
module matrixRingCounter (newClock, ROW, COL, values);

	input newClock; // new 500Hz clock
	input [3:0] ROW; // the row inputs that we poll
	
	output reg [3:0] COL = 4'b1110; // column value that we initialize with 1 0 such that the ring counter can work
	output wire [7:0] values; // output values
	
	always @(posedge newClock)
	begin
		if ((ROW[0]&ROW[1]&ROW[2]&ROW[3])) // If we have a push, this condition will stop as one of the rows will become 0,thereby stopping our ring counter and outputting a constant values wire (nothing changes)
		begin
		COL <= {COL[2:0], COL[3]}; // COL ring counter which works by scrolling the 0 in each of the 4 positions available 
		end
	end
	assign values = {COL[0], COL[1], COL[2], COL[3], ROW[0], ROW[1], ROW[2], ROW[3]}; // values register that remains constant while a button is pressed

endmodule