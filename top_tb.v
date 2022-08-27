`timescale 1ns / 1ps

module top_tb ();

reg MAX10_CLK1_50, rst, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, demodulated, neg_demodulated, new_word;
reg [6:0] HEX0, HEX1, HEX2, HEX3;
	
top dut(MAX10_CLK1_50, rst, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, demodulated, neg_demodulated, new_word,
HEX0, HEX1, HEX2, HEX3);


// Drive clock
initial forever begin
	MAX10_CLK1_50 = 0;
   #5;
   MAX10_CLK1_50 = 1;
   #5;
 end

initial begin
rst = 0;

// Apply reset pulse
#10 rst = 1;
#10 rst = 0;
// Observe behavior for a long time
#1000

$stop;

end

endmodule