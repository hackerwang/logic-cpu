// TODO: sending的逻辑可以和tx_status的逻辑合并
module uarttx(clk, tx_data, tx_en, tx_status, txd);
	input clk;
	input [7:0] tx_data; 	//需要发送的数据
	input tx_en; 			//发送使能
	output reg tx_status;	//状态指示，高为空闲
	output reg txd;
	reg sending;
	reg sigbuf, sigrise;
	reg[7:0] cnt; 			//计数器
	
	initial begin
		cnt <= 1'b0;
		sigbuf <= 1'b0;
		sigrise <= 1'b0;
		txd <= 1'b1;
		tx_status <= 1'b1;
		sending <= 1'b0;
	end
	
	//检测使能信号的上升沿
	always @(posedge clk)
	begin
		sigbuf <= tx_en;
		sigrise <= (~sigbuf) & tx_en;
	end
	
	//数据发送进程开始或结束
	always @(posedge clk)
	begin
		if (sigrise && tx_status)	//当发送命令有效且线路为空闲时，启动新的数据发送进程
			sending <= 1'b1;
		else
			if(cnt == 8'd160) 		//一个字节发送完成
				sending <= 1'b0;
	end
	
	//数据发送进程
	always @(posedge clk)
	begin
		if (sending)
		begin
			case(cnt)
				//起始位
				8'd0:
					begin
						txd <= 1'b0;
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				//tx_data
				8'd16:
					begin
						txd <= tx_data[0];
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				8'd32:
					begin
						txd <= tx_data[1];
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				8'd48:
					begin
						txd <= tx_data[2];
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				8'd64:
					begin
						txd <= tx_data[3];
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				8'd80:
					begin
						txd <= tx_data[4];
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				8'd96:
					begin
						txd <= tx_data[5];
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				8'd112:
					begin
						txd <= tx_data[6];
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				8'd128:
					begin
						txd <= tx_data[7];
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				//停止位
				8'd144:
					begin
						txd <= 1'b1;
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				//空闲
				8'd160:
					begin
						txd <= 1'b1;
						tx_status <= 1'b1;
						cnt <= 8'd0;
					end
				default:
						cnt <= cnt + 8'd1;
			endcase
		end
		else
		begin
			txd <= 1'b1;
			cnt <= 8'd0;
			tx_status <= 1'b1;
		end
	end
endmodule