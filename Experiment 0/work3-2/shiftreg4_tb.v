module ShiftReg4_tb;
	wire [3:0] Q;
	reg [3:0] D;
	reg Load,Clk,ResetB;
	ShiftReg4 myreg(Q,D,Load,Clk,ResetB);

	initial begin
		D<=0;
		Load<=0;
		Clk<=0;
		ResetB<=0;
	end
	
	initial fork
		forever
			#20 Clk<=~Clk;
		forever
			for (D=0;D<16;D=D+1)
				begin
					#130 Load<=1;
					#30 Load<=0;
				end
		#50 ResetB<=1;
	join
endmodule
