//4位十进制计数器
module counter(clk,count_ena,count_clear,count3,count2,count1,count0);
	input clk,count_ena,count_clear;
	output [3:0] count3,count2,count1,count0;
	reg [3:0] count3,count2,count1,count0;
	
	initial begin
		count3<=0;
		count2<=0;
		count1<=0;
		count0<=0;
	end
	
	always@(posedge clk or posedge count_clear)
	begin
		if (count_clear)
			begin
				count3<=0;
				count2<=0;
				count1<=0;
				count0<=0;
			end
		else
			begin
				if (count_ena)
				begin
					count0<=count0+4'b0001;
					if (count0>=9)
						begin
							count0<=0;
							count1<=count1+4'b0001;
							if (count1>=9)
								begin
									count1<=0;
									count2<=count2+4'b0001;
									if (count2>=9)
										begin
											count2<=0;
											count3<=count3+4'b0001;
											if (count3>=9)
											begin
												count3<=4'b1110;
												count2<=4'b1110;
												count1<=4'b1110;
												count0<=4'b1110;
											end
										end
								end
						end
				end
			end
	end
endmodule
