//NOT FINISHED!
//UART������
module uart(sysclk,reset,rxd,txd);
	input sysclk, reset, rxd;
	output txd;
	wire clk, tx_status;
	reg tx_en;
	reg [7:0] data;
	
	initial begin
		tx_en <= 0;
		data <= 8'b0;
	end
	
	//16��������ʱ��
	clkdiv clkgen(sysclk,clk);
	uarttx tx0(clk, data, tx_en, tx_status, txd);
	
	//���Ͳ���
	always @(posedge clk)
	begin
		if (tx_status)
		begin
			data <= data + 8'd1; //ÿ�����ݼӡ�1��
			tx_en <= 1'b1; //������������
		end
		else
			tx_en <= 1'b0;
	end
	
endmodule
