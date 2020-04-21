module key_uart(
	clk,
	rst_n,
	key_in,
	tx_valid,
	tx);

	//---Ports declearation: generated by Robei---
	input clk;
	input rst_n;
	input [3:0] key_in;
	output tx_valid;
	output tx;

	wire clk;
	wire rst_n;
	wire [3:0] key_in;
	wire tx_valid;
	wire tx;
	wire [7:0] key2_key_out;
	wire key2_key_pressed;

	//----Code starts here: integrated by Robei-----
	
	
	
	
	//---Module instantiation---
	uart uart2(
		.clk(clk),
		.rst_n(rst_n),
		.tx_en(key2_key_pressed),
		.data_send(key2_key_out),
		.tx_buf_full(tx_valid),
		.tx(tx));

	key key2(
		.clk(clk),
		.rst_n(rst_n),
		.key_in(key_in),
		.key_out(key2_key_out),
		.key_pressed(key2_key_pressed));

endmodule    //key_uart

