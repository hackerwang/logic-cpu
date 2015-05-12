module MUX2x1_tb;
	reg s,a,b;
	wire y;
	MUX2x1 mux(y,a,b,s);
	
	initial begin
		s<=0;
		a<=0;
		b<=0;
	end
	
	initial fork
		forever
			#20 s<=~s;
		forever
			#30 a<=~a;
		forever
			#50 b<=~b;
	join
endmodule
