// 分频
// 波特率9600，取16倍采样频率
// 50000000/(16*9600) = 325.52
module clkdiv(clkin, clkout);
	input clkin; //系统时钟
	output clkout; //采样时钟
	reg clkout;
	reg [15:0] cnt;
	initial begin
		cnt<=0;
		clkout<=0;
	end
	always @(posedge clkin)
	begin
		if(cnt == 16'd162)
		begin
			clkout <= 1'b1;
			cnt <= cnt + 16'd1;
		end
		else
			if(cnt == 16'd325)
			begin
				clkout <= 1'b0;
				cnt <= 16'd0;
			end
			else
				cnt <= cnt + 16'd1;
	end
endmodule