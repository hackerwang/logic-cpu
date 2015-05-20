module uartrx(clk, rxd, rx_data, rx_status);
	input clk, rxd;
	output reg [7:0] rx_data;
	output reg rx_status;
	reg [7:0] cnt;
	reg sigbuf, sigfall, receiving, idle;
	
	initial begin
		cnt <= 8'b0;
		rx_data <= 8'b0;
		rx_status <= 1'b0;
		sigbuf <= 1'b1;
		sigfall <= 1'b0;
		receiving <= 1'b0;
		idle <= 1'b1;		//1表示空闲
	end
	
	//检测输入信号下降沿
	always @(posedge clk) 
	begin
		sigbuf <= rxd;
		sigfall <= sigbuf & (~rxd);
	end
	
	always @(posedge clk)
	begin
		if (sigfall && idle) //检测到信号下降沿并且原先线路为空闲，启动接收数据进程
			receiving <= 1'b1;
		else
			if(cnt == 8'd152) //接收数据完成
				receiving <= 1'b0;
	end

	always @(posedge clk)
	begin
		if (receiving)
		begin
			case (cnt)
				//起始位
				8'd0:
					begin
						idle <= 1'b0;
						cnt <= cnt + 8'd1;
						rx_status <= 1'b0;
					end
				//rx_data
				8'd24: 
					begin
						idle <= 1'b0;
						rx_data[0] <= rxd;
						cnt <= cnt + 8'd1;
						rx_status <= 1'b0;
					end
				8'd40: 
					begin
						idle <= 1'b0;
						rx_data[1] <= rxd;
						cnt <= cnt + 8'd1;
						rx_status <= 1'b0;
					end
				8'd56: 
					begin
						idle <= 1'b0;
						rx_data[2] <= rxd;
						cnt <= cnt + 8'd1;
						rx_status <= 1'b0;
					end
				8'd72: 
					begin
						idle <= 1'b0;
						rx_data[3] <= rxd;
						cnt <= cnt + 8'd1;
						rx_status <= 1'b0;
					end
				8'd88: 
					begin
						idle <= 1'b0;
						rx_data[4] <= rxd;
						cnt <= cnt + 8'd1;
						rx_status <= 1'b0;
					end
				8'd104: 
					begin
						idle <= 1'b0;
						rx_data[5] <= rxd;
						cnt <= cnt + 8'd1;
						rx_status <= 1'b0;
					end
				8'd120: 
					begin
						idle <= 1'b0;
						rx_data[6] <= rxd;
						cnt <= cnt + 8'd1;
						rx_status <= 1'b0;
					end
				8'd136: 
					begin
						idle <= 1'b0;
						rx_data[7] <= rxd;
						cnt <= cnt + 8'd1;
						rx_status <= 1'b0;
					end
				//停止位
				8'd152: 
					begin
						idle <= 1'b0;
						rx_status <= rxd;
						cnt <= 8'd0;
					end
				default:
					begin
						cnt <= cnt + 8'd1;
					end
			endcase
		end
		else
		begin
			cnt <= 8'd0;
			idle <= 1'b1;
		end
	end
endmodule
