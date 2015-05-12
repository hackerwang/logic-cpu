module MUX4x1_tb;
	reg [3:0] c;
	reg [1:0] s;
	wire z;
	MUX4x1 mux(z,c,s);
	
	initial begin
		s<=2'b00;
		c<=4'b0101;
	end
	
	initial fork
		forever
			if (s==3)
				#130 s<=0;
			else
				#130 s<=s+1;
		forever
			#30 c[0]<=~c[0];
		forever
			#40 c[1]<=~c[1];
		forever
			#50 c[2]<=~c[2];
		forever
			#60 c[3]<=~c[3];
	join
endmodule
