//量程选择
module range(modein,sigin,sigout);
	input modein,sigin;
	output reg sigout;
	wire signal_div_10;
	//10分频输入信号
	div_10 div_10_0(sigin,signal_div_10);
	always@(modein or signal_div_10 or sigin)
	begin
		if (modein)
			sigout<=signal_div_10;
		else
			sigout<=sigin;
	end
endmodule


//10分频
module div_10(sigin,sigout);
	input sigin;
	output reg sigout;
	reg [2:0] counter;
	initial begin
		counter<=0;
		sigout<=0;
	end
	always@(posedge sigin)
	begin
		if (counter==4)
			begin
				counter<=0;
				sigout<=~sigout;
			end
		else
			counter<=counter+3'b001;
	end
endmodule
