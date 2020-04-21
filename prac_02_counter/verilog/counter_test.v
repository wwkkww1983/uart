module counter_test();

	reg t_clk;
	reg t_nrst;
	reg t_enable;
	wire [3:0] t_count;

	//----Code starts here: integrated by Robei-----
	initial begin 
		t_clk = 0;
		#400;
		$finish;
	end
	always #10 t_clk = ~t_clk;
	
	initial begin
		t_nrst = 1;
		@( posedge t_clk ) #1;
		t_nrst = 0;
		@( posedge t_clk ) #1;
		t_nrst = 1;
	end
	
	initial begin 
		t_enable = 0;
		@( posedge t_clk ) #1;
		t_enable = 1;
	end
	
	initial begin
		$dumpfile ("F:/Robei/practice/prac_02_counter/counter_test.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	counter counter1(
		.clk(t_clk),
		.nrst(t_nrst),
		.enable(t_enable),
		.count(t_count));

endmodule    //counter_test

