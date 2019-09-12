// This module is a moore type FSM that acts as the control unit for our calculator. 
// The FSM takes in the inputs of clock (clock), operator (operator), digit (number), execute, reset, and clear (special commands) and outputs
// display select (disp_sell), load a(ld_a), load b(ld_b), load operator(ld_op), load result(ld_r), clear, and reset all which act as flags for our other modules
// LEDG is also used to dispaly the curent state of the FSM.
module FSM
(
	input	clk, op_in, digit_in, execute_in, reset, clear_in, // input flags/pulses
	input [4:0] buttonPulse, // memory buttons
	output reg [1:0] disp_sel, // display select which is sent to register transfer
	output reg ld_a, ld_b, ld_op, ld_r, clear, resetAll, // output flags which are used to control calculator operations later
	output reg [4:0] LED // LED to display the current state of the FSM
);

	// Declare state register
	reg [2:0]state;

	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0:begin // Initial state
				ld_a = 0;
				ld_b = 0;
				ld_op = 0;
				ld_r = 0;
				disp_sel = 2'b00;
				clear = (clear_in == 1)?1:0; 
				resetAll = 1;
				LED = 5'b00001;
				end
			S1:begin // OperandA state
				ld_a = 1;
				ld_b = 0;
				ld_op = 0;
				ld_r = 0;
				disp_sel = 2'b00;
				clear = (clear_in == 1)?1:0;
				resetAll = 0;
				LED = 5'b00010;
				end
			S2:begin // Operation state
				ld_a = 0;
				ld_b = 0;
				ld_op = 1;
				ld_r = 0;
				disp_sel = 2'b01;
				clear = 1;
				resetAll = 0;
				LED = 5'b00100;
				end
			S3:begin // OperandB state
				ld_a = 0;
				ld_b = 1;
				ld_op = 0;
				ld_r = 0;
				disp_sel = 2'b10;
				clear = (clear_in == 1)?1:0;
				resetAll = 0;
				LED = 5'b01000;
				end
			S4:begin // Result state
				ld_a = 0;
				ld_b = 0;
				ld_op = 0;
				clear = (clear_in == 1)?1:0;
				disp_sel = 2'b11;
				clear = 0;
				resetAll = 0;
				LED = 5'b10000;
				end
			default:begin // default state which is added as an entry point into the FSM and for safety in case we get a unknown case
				ld_a = 0;
				ld_b = 0;
				ld_op = 0;
				ld_r = 0;
				disp_sel = 2'b00;
				clear = (clear_in == 1)?1:0;
				resetAll = 1;
				LED = 5'b00000;
				end
		endcase
	end

	// Determine the next state
	always @ (posedge clk or posedge reset) begin 
		if (reset)
			state <= S0; // set to state Initial
		else
			case (state)
				S0:
					state <= S1; // immediately take us to state operandA
				S1:
					if (op_in) // If we have an operation that was entered go to state Operation, otherwise if there is a reset, digit, or execute do nothing
						state <= S2;
					else if (digit_in | reset | execute_in)
						state <= S1;
				S2:
					if (digit_in | (buttonPulse == 5'b10010)) // If we have a digit that was entered, or memory restore was pressed then we can move to state operandB
						state <= S3;
					else if (op_in | reset | execute_in) // otherwise if there is a reset, digit, or execute do nothing
						state <= S2;
				S3:
					if (execute_in) // execute will take us to state 5
						state <= S4;
					else if (digit_in | op_in | reset)
						state <= S3;
				S4:
					if (reset)
						state <= S0; // pressing reset will take us back to state initial
					else if (digit_in | op_in | execute_in)
						state <= S4;
			endcase
	end

endmodule
