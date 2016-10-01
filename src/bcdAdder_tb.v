`timescale 1ns/1ns //Group 4 ECE811 - William Nitsch, Raashid Ansari, Jonathan Frey
module bcdAdder_tb;
	reg [7:0] a_in;
	reg [7:0] b_in;
	reg cin_in;
	wire [11:0] sum_out;
	wire cout_out;
	//Testing variables
	reg[3:0] A0, A1, B0, B1; //A1A0 & B1B0 = 2 digit number inputs
	reg[11:0] compANS; //12 bit output and register for comparison (error checking)
	
	bcdAdder bcd(
					.a8_in(a_in),
					.b8_in(b_in),
					.sum12_out(sum_out),
					.cout8_out(cout_out),
					.cin8_in(cin_in)
				);

	initial	begin
		//Testing output with input carry of 0
		cin_in = 1'b0;
		for(A1 = 4'd0; A1 < 4'd10; A1 = A1 + 4'd1) begin
			for(A0 = 4'd0; A0 < 4'd10; A0 = A0 + 4'd1) begin
				for(B1 = 4'd0; B1 < 4'd10; B1 = B1 + 4'd1) begin
					for(B0 = 4'd0; B0 < 4'd10; B0 = B0 + 4'd1) begin
						compANS = B1*10+B0+A1*10+A0+cin_in; //answer calculated for error checking
						a_in[3:0] = A0;
						a_in[7:4] = A1;
						b_in[3:0] = B0;
						b_in[7:4] = B1;
						#5
						if((sum_out[11:8]*100+sum_out[7:4]*10+sum_out[3:0]) !== compANS) begin
							$display("Error: compANS (%b, %d) is not equal to sum_out (%b, %d%d%d)", compANS, compANS, sum_out, sum_out[11:8],
							sum_out[7:4], sum_out[3:0]);
						end
						else begin
							//$display("compANS: %b (%d), sum_out: %b (%d)", compANS, compANS, sum_out, //enable this if you wish to see real outputs
							// sum_out[11:8]*100+sum_out[7:4]*10+sum_out[3:0]);
						end
					end
				end
			end
		end
		
		//Testing output with input carry of 1
		cin_in = 1'b1;
		for(A1 = 4'd0; A1 < 4'd10; A1 = A1 + 4'd1) begin
			for(A0 = 4'd0; A0 < 4'd10; A0 = A0 + 4'd1) begin
				for(B1 = 4'd0; B1 < 4'd10; B1 = B1 + 4'd1) begin
					for(B0 = 4'd0; B0 < 4'd10; B0 = B0 + 4'd1) begin
						compANS = B1*10+B0+A1*10+A0+cin_in; //answer calculated for error checking
						a_in[3:0] = A0;
						a_in[7:4] = A1;
						b_in[3:0] = B0;
						b_in[7:4] = B1;
						#5
							if((sum_out[11:8]*100+sum_out[7:4]*10+sum_out[3:0]) !== compANS) begin //if calculated answer does not equal system output display error
								$display("Error: compANS (%b, %d) is not equal to sum_out (%b, %d%d%d)", compANS, compANS, sum_out, sum_out[11:8],
								sum_out[7:4], sum_out[3:0]);
							end
							else begin
								//$display("compANS: %b (%d), sum_out: %b (%d)", compANS, compANS, sum_out, //enable this if you wish to see real outputs
								// sum_out[11:8]*100+sum_out[7:4]*10+sum_out[3:0]);
							end
					end
				end
			end
		end

		//Special case: All inputs greater than 9 (all equal 10)
		a_in [3:0] = 4'b1010;
		a_in [7:4] = 4'b1010;
		b_in [3:0] = 4'b1010;
		b_in [7:4] = 4'b1010;
		//$display("Special cases - Calculated answer: %d,\tActual answer: %d", a_in[3:0]+a_in[7:4]*10+b_in[3:0]+b_in[7:4]*10, sum_out[11:8]*100+sum_out[7:4]*10+sum_out[3:0]);
		cin_in = 1'b0;
		#5
		a_in[3:0] = 4'b1010;
		a_in[7:4] = 4'b0000;
		b_in[3:0] = 4'b1010;
		b_in[7:4] = 4'b0000;
		//$display("Special cases - Calculated answer: %d,\tActual answer: %d", a_in[3:0]+a_in[7:4]*10+b_in[3:0]+b_in[7:4]*10, sum_out[11:8]*100+sum_out[7:4]*10+sum_out[3:0]);
		#5 $finish;
	end
endmodule