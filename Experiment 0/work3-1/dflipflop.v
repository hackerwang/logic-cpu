module DFlipFlop(Q,Q_bar,D,s,r,clk);
	output Q,Q_bar;
	input D,s,r,clk;
	wire t1,t2,t3;
	nand #3 u1(t1,s,t4,t2),
			u2(t2,t1,r,clk),
			u3(t3,t2,clk,t4),
			u4(t4,t3,r,D),
			u5(Q,s,t2,Q_bar),
			u6(Q_bar,Q,r,t3);
endmodule
