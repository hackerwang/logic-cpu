module ShiftReg4(Q,D,Load,Clk,ResetB);
	output [3:0] Q;
	input [3:0] D;
	input Load,Clk,ResetB;
	wire t1,t2,t3;
	MUX2x1  m1(t1,Q[0],D[1],Load),
			m2(t2,Q[1],D[2],Load),
			m3(t3,Q[2],D[3],Load);
	DFlipFlop   dff0(.Q(Q[0]),.Q_bar(),.D(D[0]),.s(1),.r(ResetB),.clk(Clk)),
				dff1(.Q(Q[1]),.Q_bar(),.D(t1),.s(1),.r(ResetB),.clk(Clk)),
				dff2(.Q(Q[2]),.Q_bar(),.D(t2),.s(1),.r(ResetB),.clk(Clk)),
				dff3(.Q(Q[3]),.Q_bar(),.D(t3),.s(1),.r(ResetB),.clk(Clk));
endmodule
