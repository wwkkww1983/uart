module key_uart_test();

	reg clk;
	reg rst_n;
	reg [3:0] key_in;
	wire tx_valid;
	wire tx;

	//----Code starts here: integrated by Robei-----
	//
	// Generate clk
	//
	initial begin 
	  clk = 0;
	end
	always #10 clk = ~clk;
	
	//
	// Generate reset signal
	//
	initial begin
	  rst_n = 1;
	  repeat(1) @( posedge clk ) #1;
	  rst_n = 0;
	  repeat(1) @( posedge clk ) #1;
	  rst_n = 1;  
	end
	
	// 
	// Generate key signal
	//
	initial begin
	  key_in = 4'b0000;
	  repeat(1000000) @( posedge clk ) #1;
	  key_in = 4'b0001;
	  repeat(1000000) @( posedge clk ) #1;
	  key_in = 4'b0010;
	  repeat(1000000) @( posedge clk ) #1;
	  key_in = 4'b0100;
	  repeat(1000000) @( posedge clk ) #1;
	  key_in = 4'b1000;
	  repeat(1000000) @( posedge clk ) #1;     
	  key_in = 4'b0000;
	  repeat(1000000) @( posedge clk ) #1;      
	  #10 $finish;
	end
	
	
	
	initial begin
		$dumpfile ("F:/Robei/practice/homework_01_uart/key_uart_test.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	key_uart key_uart1(
		.clk(clk),
		.rst_n(rst_n),
		.key_in(key_in),
		.tx_valid(tx_valid),
		.tx(tx));

endmodule    //key_uart_test

