//1Hz控制时钟
module ctrl_clk_gen(sysclk,ctrl_clk);
	input sysclk;
	output ctrl_clk;
	reg ctrl_clk;
	reg [24:0] counter;
	initial begin
		ctrl_clk<=0;
		counter<=24000000;
	end
	always@(posedge sysclk)
	begin
		if (counter==24999999)
			begin
				counter<=0;
				ctrl_clk<=~ctrl_clk;
			end
		else
			counter<=counter+25'b0_0000_0000_0000_0000_0000_0001;
	end
endmodule
