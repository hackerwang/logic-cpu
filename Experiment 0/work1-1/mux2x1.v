module MUX2x1(y,a,b,s);
	output y;
	input a,b,s;
	wire s_bar,t1,t2,t3;
	not #2 u0(s_bar,s);
	and #2 u1(t1,s_bar,a),
		u2(t2,s,b),
		u3(t3,a,b);
	or #2 u4(y,t1,t2);
endmodule
