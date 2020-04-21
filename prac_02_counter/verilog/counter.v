module counter(
	clk,
	nrst,
	enable,
	count);

	//---Ports declearation: generated by Robei---
	input clk;
	input nrst;
	input enable;
	output [3:0] count;

	wire clk;
	wire nrst;
	wire enable;
	reg [3:0] count;

	//----Code starts here: integrated by Robei-----
	always @(posedge clk or negedge nrst) begin
		if(!nrst) begin
			count <= 4'h0;
		end
		else if(enable) begin
			if( &count ) begin 
				count <= 4'h0;
			end
			else begin 
				count <= count +1'b1;
			end 
		end
	end
	
endmodule    //counter
