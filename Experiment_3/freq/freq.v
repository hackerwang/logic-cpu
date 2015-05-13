module freq(sysclk,rst,select,modein,modeout,freqout3,freqout2,freqout1,freqout0);
	input sysclk,rst,modein;
	input [1:0] select;
	output modeout;
	output [6:0] freqout3,freqout2,freqout1,freqout0;
	wire initial_signal,div_10_signal,ctrl_clk;
	reg modeout,signal;
	//控制信号
	reg count_ena,count_clear,lock;
	//计数器输出
	wire [3:0]count3,count2,count1,count0;
	//锁存器输出
	reg [3:0]count33,count22,count11,count00;
	
	initial begin
		count_ena<=0;
		lock<=0;
		count_clear<=1;
		count33<=0;
		count22<=0;
		count11<=0;
		count00<=0;
	end
	
	//产生输入信号
	signalinput signalinput0(select,sysclk,initial_signal);
	//产生控制时钟
	ctrl_clk_gen ctrl_clk_gen0(sysclk,ctrl_clk);
	//10分频输入信号
	div_10 div_10_0(initial_signal,div_10_signal);
	//10进制计数器
	counter counter0(signal,count_ena,count_clear,count3,count2,count1,count0);
	
	//量程选择
	always@(modein or div_10_signal or initial_signal)
	begin
		modeout<=modein;
		if (modein)
			signal<=div_10_signal;
		else
			signal<=initial_signal;
	end
	
	//产生控制信号
	always@(posedge ctrl_clk or negedge rst)
	begin
		if (~rst)
		begin
			count_clear<=1;
		end
		else
			if (count_clear)
				begin
					lock<=0;
					count_clear<=0;
					count_ena<=1;
				end
			else
				begin
					count_ena<=0;
					lock<=1;
				end
	end
	
	//锁存器模块
	always@(lock or count3 or count2 or count1 or count0)
	begin
		if (~lock)
			begin
				count33<=count3;
				count22<=count2;
				count11<=count1;
				count00<=count0;
			end
	end
	
	//译码
	bcd7 bcd7_3(count33,freqout3);
	bcd7 bcd7_2(count22,freqout2);
	bcd7 bcd7_1(count11,freqout1);
	bcd7 bcd7_0(count00,freqout0);

endmodule		
				
module counter(clk,count_ena,count_clear,count3,count2,count1,count0);
	input clk,count_ena,count_clear;
	output [3:0] count3,count2,count1,count0;
	reg [3:0] count3,count2,count1,count0;
	
	initial begin
		count3<=0;
		count2<=0;
		count1<=0;
		count0<=0;
	end
	
	always@(posedge clk or posedge count_clear)
	begin
		if (count_clear)
			begin
				count3<=0;
				count2<=0;
				count1<=0;
				count0<=0;
			end
		else
			begin
				if (count_ena)
				begin
					count0<=count0+4'b0001;
					if (count0>=9)
						begin
							count0<=0;
							count1<=count1+4'b0001;
							if (count1>=9)
								begin
									count1<=0;
									count2<=count2+4'b0001;
									if (count2>=9)
										begin
											count2<=0;
											count3<=count3+4'b0001;
											if (count3>=9)
											begin
												count3<=4'b1110;
												count2<=4'b1110;
												count1<=4'b1110;
												count0<=4'b1110;
											end
										end
								end
						end
				end
			end
	end
endmodule
				
//控制时钟
module ctrl_clk_gen(sysclk,ctrl_clk);
	input sysclk;
	output ctrl_clk;
	reg ctrl_clk;
	reg [24:0] counter;
	initial begin
		ctrl_clk<=0;
		counter<=24000000;
	end
	always@(posedge sysclk)
	begin
		if (counter==24999999)
			begin
				counter<=0;
				ctrl_clk<=~ctrl_clk;
			end
		else
			counter<=counter+25'b0_0000_0000_0000_0000_0000_0001;
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

module bcd7(din,dout);
input 	[3:0]	din;
output 	[6:0] dout;

assign	dout=(din==4'h0)?7'b1000000:
             (din==4'h1)?7'b1111001:
             (din==4'h2)?7'b0100100:
             (din==4'h3)?7'b0110000:
             (din==4'h4)?7'b0011001:
             (din==4'h5)?7'b0010010:
             (din==4'h6)?7'b0000010:
             (din==4'h7)?7'b1111000:
             (din==4'h8)?7'b0000000:
             (din==4'h9)?7'b0010000:7'b0000110;
endmodule

