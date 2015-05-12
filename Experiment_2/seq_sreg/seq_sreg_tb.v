module seq_tb;
reg clk,rst;
reg [5:0] pointer;
reg [0:31] str;
wire din,dout;
wire [5:0]sreg6;
seq myseq(clk,rst,din,dout,sreg6);


initial begin
	clk<=0;
	rst<=0;
	pointer<=0;
	str<=31'b0010101011010101100101010101011;
end

initial fork
	#30 rst<=1;
	forever
		begin
			if (clk)
			begin
				if (pointer==31)
					pointer=0;
				else pointer=pointer+1;
				
			end
			#25 clk<=~clk;
		end
join

assign din=str[pointer];

endmodule
