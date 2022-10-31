`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:17 08/31/2019 
// Design Name: 
// Module Name:    sliding_window 
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
module sliding_window #(
	parameter data_width= 8,
	parameter clock_cycle = 317
	)
	(
	input 		clk,
	input 		rst_n,
	input		data_in_valid,
	input  [data_width-1:0] data_in,
	output	  reg  data_out_valid,
	output [data_width-1:0] P1,
	output [data_width-1:0] P2,
	output [data_width-1:0] P3,
	output [data_width-1:0] P4,
	output [data_width-1:0] P5,
	output [data_width-1:0] P6,
	output [data_width-1:0] P7,
	output [data_width-1:0] P8,
	output [data_width-1:0] P9
   );

	
	reg 		data_valid_p9;
	reg 		data_valid_p8;
	reg 		data_valid_p7;

	reg 		data_valid_p6;
	reg 		data_valid_p5;
	reg 		data_valid_p4;
	
	reg 		data_valid_p3;
	reg 		data_valid_p2;
	reg 		data_valid_p1;	
	
	reg [data_width-1:0]	p1;
	reg [data_width-1:0]	p2;
	reg [data_width-1:0]	p3;
	reg [data_width-1:0]	p4;
	reg [data_width-1:0]	p5;
	reg [data_width-1:0]	p6;
	reg [data_width-1:0]	p7;
	reg [data_width-1:0]	p8;
	reg [data_width-1:0]	p9;

	wire 		data_valid_line1;
	wire 		data_valid_line2;
	wire [data_width-1:0]	line1_out;
	wire [data_width-1:0]	line2_out;
	
	//reg [11:0]count;

	assign P1 = p1;
	assign P2 = p2;
	assign P3 = p3;
	assign P4 = p4;
	assign P5 = p5;
	assign P6 = p6;
	assign P7 = p7;
	assign P8 = p8;
	assign P9 = p9;
	
	always@(posedge clk)
	begin
	  if(!rst_n)
	    begin
	      data_out_valid <= 1'b0;
	    end
	   else if(data_in_valid)
	     begin
	     // repeat (1283) @(posedge clk);
	      data_out_valid <= 1'b1;
	      end
	    else
	      data_out_valid <= 1'b0;
	 end
	       
	     
	
	//assign data_out_valid = data_in_valid ;
	
   always @(posedge clk)
   begin
    if (!rst_n) 
    begin
         p9 <= 1'b0;
			   data_valid_p9 <= 0;
    end 
		else if (data_in_valid) 
		begin
         p9 <= data_in;
			   data_valid_p9 <= 1;
    end
    else 
     begin 
			   p9 <= 0 ;
         data_valid_p9 <= 0;
     end 
   end
		
   always @(posedge clk)
   begin
      if (!rst_n) 
      begin
         p8 <= 1'b0;
	       data_valid_p8 <= 0;
      end 
      else if (data_valid_p9) 
      begin
         p8 <= p9;
	       data_valid_p8 <= 1;
      end
      else 
      begin 
	       p8 <= 0 ;
	       data_valid_p8 <= 0 ;
      end 
    end		

   always @(posedge clk)
   begin
      if (!rst_n)
      begin
         p7 <= 1'b0;
	       data_valid_p7 <= 0;
      end
      else if (data_valid_p8) 
      begin
         p7 <= p8;
	       data_valid_p7 <= 1;
      end	
      else
       begin 
	       p7 <= 0 ;
	       data_valid_p7 <= 0 ;
     end
   end
    
	wire line1_valid_out;
	line_buffer #(
		.clock_cycles(clock_cycle),
		.data_width(data_width)
	) 
	buffer_1(
		.data_in( p7),  
		.clock_enable(data_valid_p7), 
		.clock(clk), 
		.data_out(line1_out),
		.line_valid(line1_valid_out)
	);
	

   always @(posedge clk)
   begin
      if (!rst_n) 
      begin
         p6 <= 1'b0;
	       data_valid_p6 <= 0;
      end 
      else if (line1_valid_out) 
      begin
         p6 <= line1_out;
	       data_valid_p6 <= 1;
      end
      else
       begin 
        	p6 <= 0 ;	
	       data_valid_p6 <= 0 ;
      end 
    end
		
   always @(posedge clk)
   begin
      if(!rst_n) 
      begin
         p5 <= 1'b0;
	       data_valid_p5 <= 0;
      end 
      else if (data_valid_p6) 
      begin
         p5 <= p6;
	       data_valid_p5 <= 1;
      end
      else
      begin 
	       p5 <= 0 ;
	       data_valid_p5 <= 0 ;
      end 
  end		

   always @(posedge clk)
   begin
      if (!rst_n) 
      begin
         p4 <= 1'b0;
	       data_valid_p4 <= 0;
      end 
      else if (data_valid_p5) 
      begin
         p4 <= p5;
	       data_valid_p4 <= 1;
      end	
      else 
      begin 
       p4 <= 0 ;
       data_valid_p4 <= 0 ;
      end 
  end
	
	wire line2_valid_out;
	line_buffer #(
		.clock_cycles(clock_cycle),
		.data_width(data_width)
	) 
	buffer_2(
		.data_in( p4 ), 
		.clock_enable(data_valid_p4), 
		.clock(clk), 
		.data_out(line2_out),
		.line_valid(line2_valid_out)
	);
	
//	assign line2_out = line1_out ; 

   always @(posedge clk)
   begin
      if (!rst_n) 
      begin
         p3 <= 1'b0;
			   data_valid_p3 <= 0;
      end 
      else if (line2_valid_out)
       begin
         p3 <= line2_out;
			   data_valid_p3 <= 1;
      end
	    else  
	    begin 
	       p3 <= 0;
	       data_valid_p3 <= 0;
	    end
	 end 
		
   always @(posedge clk)
   begin
      if (!rst_n) 
      begin
         p2 <= 1'b0;
			   data_valid_p2 <= 0;
      end 
      else if (data_valid_p3)
      begin
         p2 <= p3;
			   data_valid_p2 <= 1;
      end		
      else
      begin 
			   p2 <= 0 ;
			   data_valid_p2 <= 0 ;	
      end
  end 

   always @(posedge clk)
   begin
      if (!rst_n) 
      begin
         p1 <= 1'b0;
			   data_valid_p1 <= 0;
      end 
      else if (data_valid_p2) 
      begin
         p1 <= p2;
			   data_valid_p1 <= 1;
      end
      else  
      begin 
			   p1 <= 0 ; 
			   data_valid_p1 <= 0 ;
      end 
  end	

//		  
//	shift_clock #(
//      		.clock_cycles(clock_cycle)
//	)
//	valid_dly(
//		.data_in(data_valid_p9),
//		.clock(clk),
//		.rst_n(rst_n),
//		.clock_enable(data_valid_p9),
//		.data_out(data_valid_line1)
//	); 

endmodule
