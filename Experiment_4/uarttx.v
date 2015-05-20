//TODO: sending���߼����Ժ�tx_status���߼��ϲ�
module uarttx(clk, tx_data, tx_en, tx_status, txd);
	input clk;
	input [7:0] tx_data; 	//��Ҫ���͵�����
	input tx_en; 			//����ʹ��
	output reg tx_status;	//״ָ̬ʾ����Ϊ����
	output reg txd;
	reg sending;
	reg sigbuf, sigrise;
	reg[7:0] cnt; 			//������
	
	initial begin
		cnt <= 1'b0;
		sigbuf <= 1'b0;
		sigrise <= 1'b0;
		txd <= 1'b1;
		tx_status <= 1'b1;
		sending <= 1'b0;
	end
	
	//���ʹ���źŵ�������
	always @(posedge clk)
	begin
		sigbuf <= tx_en;
		sigrise <= (~sigbuf) & tx_en;
	end
	
	//���ݷ��ͽ��̿�ʼ�����
	always @(posedge clk)
	begin
		if (sigrise && tx_status)	//������������Ч����·Ϊ����ʱ�������µ����ݷ��ͽ���
			sending <= 1'b1;
		else
			if(cnt == 8'd160) 		//һ���ֽڷ������
				sending <= 1'b0;
	end
	
	//���ݷ��ͽ���
	always @(posedge clk)
	begin
		if (sending)
		begin
			case(cnt)
				//��ʼλ
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
				//ֹͣλ
				8'd144:
					begin
						txd <= 1'b1;
						tx_status <= 1'b0;
						cnt <= cnt + 8'd1;
					end
				//����
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