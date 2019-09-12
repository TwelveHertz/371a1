// This is the arithmetic logic unit that is reponsible for all the calculations performed by the code. 
// Calculations are performed on signed operands using verilogs functionality. As a result, a simple case statement was enough to achieve the desired results
// The output is a 21 bit signed register, and the input operator chooses which operation to perform on input operands operandA and operandB
module ALU (operandA, operandB, , equalPulse, operator, answer);
	input signed [10:0] operandA, operandB; // signed inputs. The signed part is neccessary for verilog's calculation, and avoids complex case structures when determining the sign of a number
	input [3:0] operator; // operator select 
	input [4:0]equalPulse; // The actual calculation will take place at the positive edge of this point
	output reg signed [20:0] answer; // The output answer
	
	always@(posedge equalPulse[4]) // when we have a equalPulse, we update the answer
	begin
		case(operator)
		4'b1111: answer = operandA + operandB;
		4'b1110: answer = operandA - operandB;
		4'b1101: answer = operandA * operandB;
		endcase
	end
		
endmodule