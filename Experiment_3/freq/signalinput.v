//输入信号
module signalinput(
	input [1:0] testmode,//00,01,10,11分别代表4种频率，分别为3125，6250，50，12500Hz，使用SW1~SW0来控制
	input sysclk,//系统时钟50M
	output reg sigin//输出待测信号
);

	reg[20:0] state;
	reg[20:0] divide;
	initial
	begin
		sigin=0;
		state=21'b000000000000000000000;
		divide=21'b000000_1111_1010_0000000;
	end
	always@(testmode)
	begin
		case(testmode[1:0])
			2'b00:divide=21'd16000; //3125Hz
			2'b01:divide=21'd8000; //6250Hz
			2'b10:divide=21'd1000000; //50Hz
			2'b11:divide=21'd4000; //12500Hz
		endcase
	end
	always@(posedge sysclk)//按divide分频
	begin
		if(state==0)
			sigin=~sigin;
		state=state+21'b0_00__0000_0000_0000_0000_10;
		if(state==divide)
			state=21'b0_0000_0000_0000_0000_0000;
	end
endmodule
