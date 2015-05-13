module freq_tb;
	reg sysclk,rst,modein;
	reg [1:0] select;
	wire modeout;
	wire [6:0] freqout3,freqout2,freqout1,freqout0;
	
	freq freq0(sysclk,rst,select,modein,modeout,freqout3,freqout2,freqout1,freqout0);
	
	initial begin
		sysclk<=0;
		rst<=0;
		modein<=0;
		select<=0'b00;
	end
	
	initial fork
		#10 rst<=1;
		forever
			#10 sysclk<=~sysclk;
		forever
			begin
				#10 rst<=0;
				#20 rst<=1;
				#2000000000 select<=select+2'b01;
				if (select==2'b10)
					modein<=1;
				else
					modein<=0;
			end
	join
	
endmodule

