`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:01:22 07/14/2021
// Design Name:   proposed_pupildetection_top
// Module Name:   E:/Navi_Research/Low_computational_complexity_pupil_detection/HDL_Design/Proposed/logical_or.v
// Project Name:  synthesis_work
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: proposed_pupildetection_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module logical_or;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] image_data;
	wire [9:0] xcenter;
	wire [9:0] ycenter;

	// Instantiate the Unit Under Test (UUT)
	proposed_pupildetection_top uut (
		.clk(clk), 
		.rst(rst), 
		.image_data(image_data), 
		.xcenter(xcenter), 
		.ycenter(ycenter)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

