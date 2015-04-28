module DFlipFlop_tb;
	wire q,q_bar;
	reg d,s,r,clk;
	DFlipFlop dff(.Q(q),.Q_bar(q_bar),.D(d),.s(s),.r(r),.clk(clk));
	initial begin
		d<=0;
		s<=1;
		r<=0;
		clk<=0;
	end
	initial fork
		forever
			#20 clk<=~clk;
		forever
			#50 d<=~d;
		#100 r<=1;
		#730 r<=0;
		#750 r<=1;
		#770 s<=0;
	join
endmodule
