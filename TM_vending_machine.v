`timescale 1ns/1ns     
module TM_vending_machine;

  reg clk, reset;
reg [2:0] howManyTicket,origin, destination ;
wire  [7:0] costOfticket, moneyTopay, totalMoney; 
reg [5:0] money;

parameter s0=2'b00; //state
parameter s1=2'b01;
parameter s2=2'b10;
parameter s3=2'b11;

sell s( clk, reset, howManyTicket,origin, destination, money, costOfticket, moneyTopay, totalMoney );

  always #5  clk=~clk;
  initial begin
    //Apply inputs
    clk = 1;
    reset = 1;
    howManyTicket = 3'd0;
    origin = 3'd0;
    destination = 3'd0;
    money = 6'd0;

    #5 reset = 0 ;

    #10 origin = 1;
    #10 destination = 5;
    #10 howManyTicket = 4;

    #25 money = 50 ;
    #10 money = 50 ;
    #10 money = 1;
    #10 money = 5 ;
    #10 money = 50 ;
    #10 money = 50 ;


    #10  $stop;
  end
endmodule
