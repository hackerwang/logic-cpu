module counter_tb;
reg clk,rst;
wire [6:0] dout;
counter1 cnt1(clk,rst,dout);
initial begin
	clk<=1;
	rst<=0;
end

initial fork
	#65 rst<=1;
	forever
		#25 clk<=~clk;
	#1200 rst<=0;
join
endmodule
