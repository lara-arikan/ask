

// Example 15a: x7segbc: Display 7 seg with leading blanks
// This version - omit DE10Lite "multiplexing" - just direct drive
module x7segbAc (
input wire [15:0] x,
output reg [6:0] HX3, HX2, HX1, HX0
// output reg [3:0] an, 
// output wire dp
);

wire [3:0] aen;
wire [6:0] dig0, dig1, dig2, dig3;

assign aen[3] = x[15]| x[14] | x[13] | x[12] ;
assign aen[2] = x[15]| x[14] | x[13] | x[12]
						| x[11] | x[10] | x[9] | x[8] ;
assign aen[1] = x[15]| x[14] | x[13] | x[12]
						| x[11] | x[10] | x[9] | x[8] 
						| x[7] | x[6] | x[5] | x[4];
assign aen[0] = 1;  // digit 0 always on;

// 7-segment decoder for DE10Lite
hex7segA hseg0 ( x[3:0], dig0 ) ;
hex7segA hseg1 ( x[7:4], dig1 ) ;
hex7segA hseg2 ( x[11:8], dig2 ) ;
hex7segA hseg3 ( x[15:12], dig3 ) ;

always @(*)
begin
 HX3 = dig3 | {7{~aen[3]}};
 HX2 = dig2 | {7{~aen[2]}};
 HX1 = dig1 | {7{~aen[1]}};
 HX0 = dig0 ;
end
	
endmodule
