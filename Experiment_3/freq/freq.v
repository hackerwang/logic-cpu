module freq(sysclk,rst,select,modein,modeout,freqout3,freqout2,freqout1,freqout0);
	input sysclk,rst,modein;
	input [1:0] select;
	output modeout;
	output [6:0] freqout3,freqout2,freqout1,freqout0;
	wire initial_signal,signal,ctrl_clk;

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
	//10进制计数器
	counter counter0(signal,count_ena,count_clear,count3,count2,count1,count0);
	//量程指示
	assign modeout=modein;
	//量程选择
	range range0(modein,initial_signal,signal);
	
	//产生控制信号
	always@(posedge ctrl_clk or negedge rst)
	begin
		if (~rst)
		begin
			count_ena<=0;
			lock<=0;
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
					if (lock)
						count_clear<=1;
					else
						begin 
							count_ena<=0;
							lock<=1;
						end
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
