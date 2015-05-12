module counter1(clk,rst,dout);
input clk,rst;
output [6:0] dout;
reg [3:0] q;

initial
begin
	q<=0;
end

always @(negedge rst or negedge clk)
begin
	if (~rst) q<=4'b0000;
	else begin
			q[0]<=~q[0];
			if (q[0]) q[1]<=~q[1];
			if (q[0] && q[1]) q[2]<=~q[2];
			if (q[0] && q[1] && q[2]) q[3]<=~q[3];
		 end
end

assign	dout=(q==4'h0)?7'b1000000:
             (q==4'h1)?7'b1111001:
             (q==4'h2)?7'b0100100:
             (q==4'h3)?7'b0110000:
             (q==4'h4)?7'b0011001:
             (q==4'h5)?7'b0010010:
             (q==4'h6)?7'b0000010:
             (q==4'h7)?7'b1111000:
             (q==4'h8)?7'b0000000:
             (q==4'h9)?7'b0010000:
			 (q==4'hA)?7'b0001000:
			 (q==4'hB)?7'b0000011:
			 (q==4'hC)?7'b1000110:
			 (q==4'hD)?7'b0100001:
			 (q==4'hE)?7'b0000110:
			 (q==4'hF)?7'b0001110:7'b0;
endmodule
