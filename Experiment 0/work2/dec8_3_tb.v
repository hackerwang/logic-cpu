module DEC8_3_tb;
	reg [2:0] a;
	wire [7:0] d;
	DEC8_3 dec(.d(d),.a(a));
	initial begin
		a=0;
		forever
			if (a==3'b111)
				#100 a=0;
			else
				#100 a=a+1;
	end
endmodule
