module uart_top_test();

	reg clk;
	reg rst_n;
	reg [3:0] key_in;
	wire tx;
	reg count_enable;
	wire tx_buf_full;
	reg rx;
	wire [3:0] led0_out;
	wire [3:0] led1_out;
	wire clk_out;

	//----Code starts here: integrated by Robei-----
	//
	// Generate clk
	//
	initial begin 
	  clk = 0;
	end
	always #10 clk = ~clk;
	
	
	initial begin
	  rst_n = 1;
	  key_in = 4'b0000;
	  count_enable = 0;
	  rx = 1;
	
	  //
	  // Generate reset signal
	  //
	  repeat(1) @( posedge clk ) #1;
	  rst_n = 0;
	  repeat(1) @( posedge clk ) #1;
	  rst_n = 1;  
	
	  // 
	  // Generate key signal
	  //
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
	
	  //
	  // Generate countdown signals
	  //
	  count_enable = 0;
	  repeat( 4 ) @( posedge clk ) #1;
	  count_enable = 1;
	  repeat( 2 ) @( posedge clk ) #1;
	  count_enable= 0;
	  repeat( 50 ) @( posedge clk ) #1;
	  count_enable = 1;
	  repeat( 2 ) @( posedge clk ) #1;
	  count_enable= 0;
	  repeat( 50000 ) @( posedge clk ) #1;
	
	  //**************************************************************************//
	  // Generate led display signals.
	  //
	  // Attension: There should be two datas in once send, the first data is used
	  // to display, while the second one is set to 0( all datas are 8 bits ).
	  // Because we had integretd the display module and the division_duty module
	  // together, if you only send the data once, it will cause the division_duty
	  // output error.
	  //
	  // Please pay attention!!!
	  //**************************************************************************//
	  
	  // 
	  // The display data
	  //
	  rx = 1;
	  repeat(10)@( posedge clk ) #1; 
	  
	  // Receive display data, which is 1_1001_1011_0( 155 )
	  //
	  repeat(32)@( posedge clk ) #1;
	  rx = 0;  // Start signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;  // Least significant signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0; 
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;  // Most significant signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;  // Parity check
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;  // Stop bit   
	  repeat(16)@( posedge clk ) #1;
	
	  rx = 1;
	  repeat(10)@( posedge clk ) #1; 
	  
	  // Receive 0, which is 0_0000_0000_0
	  //
	  repeat(32)@( posedge clk ) #1;
	  rx = 0;  // Start signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;  // Least significant signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0; 
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;  // Most significant signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;  // Parity check
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;  // Stop bit   
	  repeat(16)@( posedge clk ) #1;
	
	  //
	  // Uart division_duty testbench
	  //
	  rx = 1;
	  repeat(10)@( posedge clk ) #1; 
	  //
	  // Receive division data, division is 0_0001_0100_0( 20 )
	  //
	  repeat(32)@( posedge clk ) #1;
	  rx = 0;  // Start signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;  // Least significant signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;  // Most significant signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;  // Parity check
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;  // Stop bit   
	  repeat(16)@( posedge clk ) #1; 
	  rx = 1;   
	  repeat(32)@( posedge clk ) #1; 
	
	  //
	  // Receive duty_num data, duty_num is 1_0000_1000_0( 8 )
	  //
	  rx = 1;
	  repeat(32)@( posedge clk ) #1;
	  rx = 0;  // Start signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;  // Least significant signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;
	  repeat(16)@( posedge clk ) #1;
	  rx = 0;  // Most significant signal
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;  // Parity check
	  repeat(16)@( posedge clk ) #1;
	  rx = 1;  // Stop bit   
	  repeat(300)@( posedge clk ) #1;
	
	  $finish;
	end
	initial begin
		$dumpfile ("F:/Robei/practice/homework_01_uart/uart_top_test.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	uart_top uart_top1(
		.clk(clk),
		.rst_n(rst_n),
		.key_in(key_in),
		.tx(tx),
		.count_enable(count_enable),
		.tx_buf_full(tx_buf_full),
		.rx(rx),
		.led0_out(led0_out),
		.led1_out(led1_out),
		.clk_out(clk_out));

endmodule    //uart_top_test

