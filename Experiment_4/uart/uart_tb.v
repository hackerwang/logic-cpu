module uart_tb;
	reg sysclk, reset, rxd, cnt;
	reg [7:0] rdata,tdata;
	wire txd;
	
	uart uart0(sysclk,reset,rxd,txd);
	
	initial begin
		sysclk <= 1'b0;
		reset <= 1'b0;
		rdata <= 8'h41;
		tdata <= 8'b0;
		rxd <= 1'b1;
		cnt<=1'b1;
	end
	
	initial fork
		forever
			#10 sysclk<=~sysclk;
		#10 reset<=1'b1;
		forever
			begin
				#104166.667 rxd=1'b0;
				#104166.667 rxd=rdata[0];
				#104166.667 rxd=rdata[1];
				#104166.667 rxd=rdata[2];
				#104166.667 rxd=rdata[3];
				#104166.667 rxd=rdata[4];
				#104166.667 rxd=rdata[5];
				#104166.667 rxd=rdata[6];
				#104166.667 rxd=rdata[7];
				#104166.667 rxd=1'b1;
				if (cnt)
					rdata<=~rdata;
				else
					rdata<=rdata+8'b1;
				cnt<=~cnt;
			end
		forever
			begin
				wait(~txd)
				begin
					#156250.001 tdata[0]=txd;
					#104166.667 tdata[1]=txd;
					#104166.667 tdata[2]=txd;
					#104166.667 tdata[3]=txd;
					#104166.667 tdata[4]=txd;
					#104166.667 tdata[5]=txd;
					#104166.667 tdata[6]=txd;
					#104166.667 tdata[7]=txd;
					#156250.001;
				end
			end
	join
	
endmodule
