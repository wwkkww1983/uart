module tran_data_test();

	reg clk;
	reg rst_n;
	reg count_en;
	wire tx_doing;
	wire tx;

	//----Code starts here: integrated by Robei-----
	initial begin
	  clk = 0;
	end
	always #10 clk = ~clk;
	
	initial begin
	  rst_n = 1;
	  repeat(10) @( posedge clk ) #1;
	  rst_n = 0;
	  repeat(10) @( posedge clk ) #1;
	  rst_n = 1;
	end
	
	initial begin
	  count_en = 0;
	  repeat( 10 ) @( posedge clk ) #1;
	  count_en = 1;
	  repeat( 10 ) @( posedge clk ) #1;
	  count_en = 0;
	  repeat( 16*78*500 ) @( posedge clk ) #1;
	  repeat( 16*78*500 ) @( posedge clk ) #1;
	  repeat( 16*78*200 ) @( posedge clk ) #1;
	  count_en = 1;
	  repeat( 10 ) @( posedge clk ) #1;
	  count_en = 0;
	  repeat( 16*78*200 ) @( posedge clk ) #1;
	  $finish;
	end
	
	
	
	
	initial begin
		$dumpfile ("F:/Robei/practice/homework_01_uart/tran_data_test.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	tran_data tran_data1(
		.clk(clk),
		.rst_n(rst_n),
		.count_en(count_en),
		.tx_doing(tx_doing),
		.tx(tx));

endmodule    //tran_data_test

