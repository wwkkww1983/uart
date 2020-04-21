module uart_led_test();

	reg clk;
	reg rst_n;
	reg rx;
	wire t_led_valid;
	wire [3:0] t_led0;
	wire [3:0] t_led1;
	wire [3:0] t_led2;

	//----Code starts here: integrated by Robei-----
	//
	// Gebnerate clock
	//
	initial begin
	  clk = 0;
	end
	always #10 clk = ~clk;
	
	//
	// Generate other input signals
	//
	initial begin 
	  rx = 1;
	  repeat(10)@( posedge clk ) #1; 
	  //
	  // receive data, data is 1_1001_1011_0( 155 )
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
	  repeat(64)@( posedge clk ) #1;
	  $finish;
	end
	
	
	
	initial begin
		$dumpfile ("F:/Robei/practice/homework_01_uart/uart_led_test.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	uart_led uart_led1(
		.clk(clk),
		.rst_n(rst_n),
		.rx(rx),
		.u_led_valid(t_led_valid),
		.u_led0(t_led0),
		.u_led1(t_led1),
		.u_led2(t_led2));

endmodule    //uart_led_test

