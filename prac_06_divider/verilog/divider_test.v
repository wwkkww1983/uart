module divider_test();

	reg clk;
	reg rst_n;
	reg start_sig;
	reg [7:0] dividend;
	reg [7:0] divisor;
	wire done_sig;
	wire [7:0] quotient;
	wire [7:0] remainder;

	//----Code starts here: integrated by Robei-----
	initial
	begin
	clk=1'b0;
	rst_n=1'b0;
	#10 rst_n=1'b1;
	#1000 $finish;
	end
	always #5 clk=~clk;
	reg[3:0] i;
	always @(posedge clk or negedge rst_n)
	begin
	if(!rst_n)
	begin
	dividend<=8'd0;
	divisor<=8'd0;
	start_sig<=1'b0;
	i<=1'b0;
	end
	else
	begin
	case(i)
	0:if(done_sig)
	begin
	start_sig<=1'b0;
	i<=i+1;
	end
	else
	begin
	dividend<=8'd9;
	divisor<=8'd3;
	start_sig<=1'b1;
	end
	1:if(done_sig)
	begin
	start_sig<=1'b0;
	i<=i+1;
	end
	else
	begin
	dividend<=8'd3;
	divisor<=8'd9;
	start_sig<=1'b1;
	end
	2:if(done_sig)
	begin
	start_sig<=1'b0;
	i<=i+1;
	end
	else
	begin
	dividend<=8'd8;
	divisor<=8'd2;
	start_sig<=1'b1;
	end
	3:if(done_sig)
	begin
	start_sig<=1'b0;
	i<=i+1;
	end
	else
	begin
	dividend<=8'd8;
	divisor<=8'd4;
	start_sig<=1'b1;
	end
	4:if(done_sig)
	begin
	start_sig<=1'b0;
	i<=i+1;
	end
	else
	begin
	dividend<=8'd8;
	divisor<=8'd3;
	start_sig<=1'b1;
	end
	5:i<=4'd5;
	endcase
	end
	end
	
	
	
	initial begin
		$dumpfile ("F:/Robei/practice/prac_06_divider/divider_test.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	divider divider1(
		.clk(clk),
		.rst_n(rst_n),
		.start_sig(start_sig),
		.dividend(dividend),
		.divisor(divisor),
		.done_sig(done_sig),
		.quotient(quotient),
		.remainder(remainder));

endmodule    //divider_test

