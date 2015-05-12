module seq(clk,rst,din,dout,sreg6);
input clk,rst,din;
output dout;
output [5:0] sreg6;
reg dout;
reg [5:0] sreg6;

initial begin
	sreg6<=6'b000_000;
	dout<=0;
end

always @(negedge clk or negedge rst)
begin
	if (~rst)
		begin
			sreg6<=6'b000_000;
			dout<=0;
		end
	else
		begin
			sreg6 = (sreg6<<1) + din;
			if (sreg6 == 6'b101011)
				dout<=1;
			else
				dout<=0;
		end
end

endmodule
