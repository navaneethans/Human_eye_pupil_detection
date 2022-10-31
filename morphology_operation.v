`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:08:52 07/16/2021 
// Design Name: 
// Module Name:    morphology_operation 
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
module morphology_operation #(
                  parameter clock_cycle = 317,
					parameter data_width = 8
             )( 
									  input clock, 
									  input rst_n, data_valid,
									  input [7:0] data_in,
									  output [7:0] data_out,
									  output data_out_valid
									);

wire [7:0] closed_dilated_data;
wire closed_dilate_valid;
dilation    #(
                  	.data_width (8),
	                 .clock_cycle(317)
             )
             closed_dilation_dut( .clock(clock),
                   .rst_n(rst_n), 
                   .data_valid(data_valid),
                   .data_in(data_in), 
                   .data_out(closed_dilated_data), 
                   .data_out_valid(closed_dilate_valid) 
                   
                   ); 
                   

erosion    #(
                  	.data_width (8),
	                 .clock_cycle(37)
             )
             erode_dut( .clock(clock),
                   .rst_n(rst_n), 
                   .data_valid(closed_dilate_valid),
                   .data_in(closed_dilated_data), 
                   .data_out(data_out), 
                   .data_out_valid(data_out_valid) 
                   
                   ); 
endmodule
