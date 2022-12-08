`timescale 1 ns / 1 ps

module tb();
  reg clk;
  reg data;
  reg enable;
  reg initialize;
  wire [14:0] crc;
  
  always #5 clk = ~clk;
  
  can_crc uut(clk, data, enable, initialize, crc);
  
  //reg [26:0] r_BITSTREAM = 27'b000000010100000000100000001;
  //reg [71:0] r_BITSTREAM = 72'h123456789;
  reg [83:0] r_BITSTREAM = 84'b000011000001000100001000000000000010000100001110101000000000000000000000000000000001;  // add extra one to see where data ends
  integer i;
  
  initial
    begin 
      $dumpfile("dump.vcd");
      $dumpvars(0,uut);
      clk = 0;
      initialize = 0;
      enable = 0;
      #20
      initialize = 1;
      #10
      initialize = 0;
      #10
      enable = 1;
      #10
      for(i = 83; i >= 0; i=i-1)
        begin 
          data = r_BITSTREAM[i];
          #10;
        end 
      #2000
      $finish;
    end 
endmodule
