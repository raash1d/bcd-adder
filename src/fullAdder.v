`timescale 1ns/1ns
module fullAdder(a_in,b_in,cin_in,sum_out,cout_out);
	input wire a_in, b_in, cin_in;
	output wire sum_out, cout_out;

	assign sum_out = a_in^b_in^cin_in;
	assign cout_out = (a_in&cin_in)|(a_in&b_in)|(b_in&cin_in);
endmodule