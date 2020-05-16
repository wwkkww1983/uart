module tran_data_tb();

	reg clk;
	reg rst_n;
	reg count_enable;
	wire tx;
	wire tx_done;

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
	  count_enable = 0;
	  repeat( 100 ) @( posedge clk ) #1;
	  count_enable = 1;
	  repeat( 100 ) @( posedge clk ) #1;
	  count_enable = 0;
	  repeat( 16*78*500 ) @( posedge clk ) #1;
	  repeat( 16*78*500 ) @( posedge clk ) #1;
	  repeat( 16*78*200 ) @( posedge clk ) #1;
	  // Test the second send
	  count_enable = 1;
	  repeat( 100 ) @( posedge clk ) #1;
	  count_enable = 0;
	  repeat( 16*78*200 ) @( posedge clk ) #1; 
	  $finish;
	end
	
	
	
	
	
	
	
	initial begin
		$dumpfile ("F:/Robei/practice/homework_02_uart_16550/tran_data_tb.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	tran_data tran_data1(
		.clk(clk),
		.rst_n(rst_n),
		.count_enable(count_enable),
		.tx(tx),
		.tx_done(tx_done));

endmodule    //tran_data_tb

