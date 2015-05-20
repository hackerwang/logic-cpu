module uartrx(clk, rxd, rx_dataout, rx_status);
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
		idle <= 1'b1;		//1��ʾ����
	end
	
	//��������ź��½���
	always @(posedge clk) 
	begin
		sigbuf <= rxd;
		sigfall <= sigbuf & (~rx);
	end
	
	always @(posedge clk)
	begin
		if (sigfall && idle) //��⵽�ź��½��ز���ԭ����·Ϊ���У������������ݽ���
			receiving <= 1'b1;
		else
			if(cnt == 8'd152) //�����������
				receiving <= 1'b0;
	end

	always @(posedge clk)
	begin
		if (receiving)
		begin
			case (cnt)
				//��ʼλ
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
				//ֹͣλ
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
