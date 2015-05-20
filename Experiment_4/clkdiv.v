//��Ƶ
//������9600��ȡ16������Ƶ��
//50000000/(16*9600) = 325.52
module clkdiv(clkin, clkout);
	input clkin; //ϵͳʱ��
	output clkout; //����ʱ��
	reg clkout;
	reg [15:0] cnt;
	initial begin
		cnt<=0;
		clkout<=0;
	end
	always @(posedge clk) //��Ƶ����
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