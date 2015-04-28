module MUX4x1(z,c,s);
	output z;
	input [3:0] c;
	input [1:0] s;
	wire t1,t2;
	MUX2x1  m1(.y(t1), .a(c[0]), .b(c[2]), .s(s[1])),
			m2(.y(t2), .a(c[1]), .b(c[3]), .s(s[1])),
			m3(.y(z), .a(t1), .b(t2), .s(s[0]));
endmodule
