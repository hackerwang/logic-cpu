module DEC8_3(d,a);
	input [2:0] a;
	output [7:0] d;
	wire [2:0] a_bar;
	not #2  n2(a_bar[2],a[2]),
			n1(a_bar[1],a[1]),
			n0(a_bar[0],a[0]);
	and #3  a7(d[7],a[2],a[1],a[0]),
			a6(d[6],a[2],a[1],a_bar[0]),
			a5(d[5],a[2],a_bar[1],a[0]),
			a4(d[4],a[2],a_bar[1],a_bar[0]),
			a3(d[3],a_bar[2],a[1],a[0]),
			a2(d[2],a_bar[2],a[1],a_bar[0]),
			a1(d[1],a_bar[2],a_bar[1],a[0]),
			a0(d[0],a_bar[2],a_bar[1],a_bar[0]);
endmodule
