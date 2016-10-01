`timescale 1ns/1ns
module bcdAdder(a8_in, b8_in, sum12_out, cout8_out, cin8_in);
	input [7:0] a8_in, b8_in;
	input cin8_in;
	output [11:0] sum12_out;
	output cout8_out;
	wire cout8_out,cin8_in;
	wire [7:0] a8_in, b8_in;
	wire [11:0] sum12_out;
	wire [7:0] sumtemp;
	wire [3:0] couttemp, fba2_b4, fba3_b4;
	
	fourBitAdder fba0(
						.a4_in(a8_in[3:0]),
						.b4_in(b8_in[3:0]),
						.sum4_out(sumtemp[3:0]),
						.cin4_in(cin8_in),
						.cout4_out(couttemp[0])
					);
	assign couttemp[1] = (sumtemp[3]&sumtemp[2])|(sumtemp[3]&sumtemp[1])|couttemp[0];
	
	fourBitAdder fba1(
						.a4_in(a8_in[7:4]),
						.b4_in(b8_in[7:4]),
						.sum4_out(sumtemp[7:4]),
						.cin4_in(couttemp[1]),
						.cout4_out(couttemp[2])
					);
	assign couttemp[3] = (sumtemp[7]&sumtemp[6])|(sumtemp[7]&sumtemp[5])|couttemp[2];
	assign fba2_b4[1] = couttemp[1];
	assign fba2_b4[2] = couttemp[1];
	assign fba2_b4[0] = 1'b0;
	assign fba2_b4[3] = 1'b0;

	fourBitAdder fba2(
						.a4_in(sumtemp[3:0]),
						.b4_in(fba2_b4[3:0]),
						.sum4_out(sum12_out[3:0]),
						.cin4_in(1'b0),
						.cout4_out()
					);
	assign fba3_b4[1] = couttemp[3];
	assign fba3_b4[2] = couttemp[3];
	assign fba3_b4[0] = 1'b0;
	assign fba3_b4[3] = 1'b0;

	fourBitAdder fba3(
						.a4_in(sumtemp[7:4]),
						.b4_in(fba3_b4[3:0]),
						.sum4_out(sum12_out[7:4]),
						.cin4_in(1'b0),
						.cout4_out()
					);
	assign sum12_out[11:9] = 3'b000;
	assign sum12_out[8] = couttemp[3];
endmodule