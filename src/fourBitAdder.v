`timescale 1ns/1ns
module fourBitAdder(a4_in, b4_in, sum4_out, cin4_in, cout4_out);
	input [3:0] a4_in, b4_in;
	input cin4_in;
	output [3:0] sum4_out;
	output cout4_out;
	wire [3:0] a4_in, b4_in, sum4_out;
	wire cin4_in, ctemp0, ctemp1, ctemp2;
	
	// always @(a4_in or b4_in or sum4_out or cin4_in or cout4_out)
	// assign ctemp0 = 1'b0;
	fullAdder fa0( 	.a_in(a4_in[0]),
					.b_in(b4_in[0]),
					.cin_in(cin4_in),
					.cout_out(ctemp0),
					.sum_out(sum4_out[0])
				);
	// assign ctemp1 = ctemp0;
	
	fullAdder fa1( 	.a_in(a4_in[1]),
					.b_in(b4_in[1]),
					.cin_in(ctemp0),
					.cout_out(ctemp1),
					.sum_out(sum4_out[1])
				);
	// assign ctemp3 = ctemp2;
	
	fullAdder fa2( 	.a_in(a4_in[2]),
					.b_in(b4_in[2]),
					.cin_in(ctemp1),
					.cout_out(ctemp2),
					.sum_out(sum4_out[2])
				);
	// assign ctemp4 = ctemp3;
	fullAdder fa3( 	.a_in(a4_in[3]),
					.b_in(b4_in[3]),
					.cin_in(ctemp2),
					.cout_out(cout4_out),
					.sum_out(sum4_out[3])
				);
endmodule