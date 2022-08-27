module word_generator(
	input inbit, clk, rst,
	output [11:0] finished_word,
	output new_word);
	
wire [3:0] count;
reg [3:0] next_count; // Up to 10 necessary
wire [11:0] word;
reg [11:0] next_word, proto_finished_word;

parameter DEFAULT_WORD = 12'b100000000000;
parameter DEFAULT_COUNT = 4'd11;

// Keep track of where we are in the word
dffr #(4) count_ff (.clk(clk), .r(rst), .d(next_count), .q(count));
// Keep track of word itself
dffr #(12) word_ff (.clk(clk), .r(rst), .d(next_word), .q(word));

always @(*) begin
	if (count == 0 || rst) begin
		// Reset all values
		next_word = DEFAULT_WORD;
		next_count = DEFAULT_COUNT;
		// Generate final word
		proto_finished_word = word;
	end else if (count == 1) begin
		// I want to wait one cycle.
		next_word = word;
		next_count = 4'd0;
		// The word is finished
		proto_finished_word = word;
	end else begin
		// Make copy of word and insert bit into index
		next_word = word;
		next_word[count - 1] = inbit;
		// Update index
		next_count = count - 4'd1;
		// No final word yet
		proto_finished_word = 12'd0;
	end
		
end

// For pseudorandom bits
assign finished_word = rst ? 12'd0 : proto_finished_word;

// For testing
//assign finished_word = 12'b111111000000;
//assign finished_word = 12'b101010101010;

assign new_word = (~rst && count == 0) ? 1'b1 : 1'b0;


endmodule


