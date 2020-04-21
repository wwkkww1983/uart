module light_test();

	reg [3:0] switches;
	wire [3:0] leds;

	//----Code starts here: integrated by Robei-----
	initial begin
		#5 switches=4'b1111;
		#5 switches=4'b1110;
		#5 switches=4'b1101;
		#5 switches=4'b1010;
		#5 switches=4'b1011;
		#5 switches=4'b0110;
		#5 switches=4'b0101;
		#5 switches=4'b0110;
		#10 $finish;
	end
	
	
	
	initial begin
		$dumpfile ("F:/Robei/practice/prac_04_led/light_test.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	light light1(
		.swt(switches),
		.led(leds));

endmodule    //light_test

