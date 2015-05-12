module seq(clk,rst,din,dout,state);
input clk,rst,din;
output dout;
output [2:0] state;
reg dout;
reg [2:0] state;

parameter A=3'b001, B=3'b011, C=3'b010, D=3'b101, E=3'b111, F=3'b100;

initial begin
	state<=A;
	dout<=0;
end

always @(negedge clk or negedge rst)
begin
	if (~rst)
		begin
			state<=A;
			dout<=0;
		end
	else begin
		dout<=0;
		case (state)
			A: if (din)
						state<=B;
				else
					state<=A;
			B: if (din)
					state<=B;
				else
					state<=C;
			C: if (din)
					state<=D;
				else
					state<=A;
			D: if (din)
					state<=B;
				else
					state<=E;
			E: if (din)
					state<=F;
				else
					state<=A;
			F: if (din)
					begin
						state<=B;
						dout<=1;
					end
				else
					state<=E;
		endcase
	end
end

endmodule
