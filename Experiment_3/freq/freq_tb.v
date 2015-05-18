module freq_tb;
	reg sysclk,rst,modein;
	reg [1:0] select;
	wire modeout;
	wire [6:0] freqout3,freqout2,freqout1,freqout0;
	
	freq freq0(sysclk,rst,select,modein,modeout,freqout3,freqout2,freqout1,freqout0);
	
	initial begin
		sysclk<=0;
		rst<=1;
		modein<=0;
		select<=0'b00;
	end
	
	initial fork
		forever
			#10 sysclk<=~sysclk;
		forever
			begin
				#3000000000 select<=select+1;
				if (select==2'b10)
					modein<=1;
				else
					modein<=0;
			end
	join

endmodule

