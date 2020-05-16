`define DEL 1
// This parameter is used to control the division length, DIV_LENGTH = the bin length of ( CLOCK / ( 16 * ( the least baud_rate ) ) ), e.g., if the least baud_rate you limited is 300, then the DIV_LENGTH is equal to the bin length of ( 12000000 / ( 16 * 300 ) = 2500 = 12'b1001_1100_0100 ) = 12
`define DIV_LENGTH 12
