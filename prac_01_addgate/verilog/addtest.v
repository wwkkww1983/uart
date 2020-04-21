module addtest();

	reg p0;
	reg p1;
	wire p2;

	//----Code starts here: integrated by Robei-----
	initial begin 
		p0 = 0;  p1 = 1;
		#10;
		p0 = 1;  p1= 0;
		#10;
		p0 = 1;  p1 = 1; 
		#10;
		p0 = 0;  p1 = 0;
		#10;
		$finish;
	end
	
	
	
	initial begin
		$dumpfile ("F:/Robei/practice/prac_01_addgate/addtest.vcd");
		$dumpvars;
	end
	//---Module instantiation---
	andgate andgate1(
		.a(p0),
		.b(p1),
		.y(p2));

endmodule    //addtest

