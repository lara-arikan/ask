module lfsr(
	output outbit, 
	input clk, rst, load);
	
// Consider it a finite state machine
	wire[12:0] curr_state;
	reg [12:0] next_state;
	
	
// Define seed (change for different random behavior)
	parameter SEED = 13'd1;
	
	dffr #(13) ff (.clk(clk), .r(rst), .d(next_state), .q(curr_state));
	
	always @(*) begin
		next_state = load ? SEED : {curr_state[11:0], outbit};
	end
	
// Maximal length polynomial is x^13 + x^12 + x^11 + x^8 + 1
   assign outbit = rst ? 1'b0 : curr_state[12] ^ curr_state[11] ^ curr_state[10] ^ curr_state[7];
	
endmodule