`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:11 08/30/2019 
// Design Name: 
// Module Name:    line_buffer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module line_buffer #
	(
	parameter clock_cycles = 317,
	parameter data_width = 8
	)
	(
	input [data_width-1:0] 	data_in,
	input 			clock_enable,
	input 			clock,
	output [data_width-1:0] data_out,
	output reg line_valid
	);

 
   reg [clock_cycles-1:0] shift_reg [data_width-1:0];

   //synthesis translate off
   integer j;
   initial 
	for(j=0;j<clock_cycles;j=j+1)
		shift_reg[j] = 0 ;
   //synthesis translate on	

   genvar i;
   generate
      for (i=0; i < data_width; i=i+1) 
      begin: label
         always @(posedge clock)
            if (clock_enable)
              begin
                 shift_reg[i] <= {shift_reg[i][clock_cycles-2:0], data_in[i]};
                 line_valid <= 1'b1;
              end
           else
                  line_valid <= 1'b0;

				 
         assign data_out[i] = shift_reg[i][clock_cycles-1];
      end
   endgenerate
	
endmodule
