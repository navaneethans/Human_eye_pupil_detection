`timescale 1ns / 1ps
module proposed_pupildetection_top_tb;
  wire [7:0]edge_data;
  reg clk,rst;
   wire [9:0]xcenter,ycenter;
  
 proposed_pupildetection_top dut( clk,rst,edge_data,xcenter,ycenter);
  
  initial
  begin
    clk = 1'b0;
    rst = 1'b0;
    #510 
    rst = 1'b1;
  end
  
  always #10 clk = ~clk;
  
endmodule
