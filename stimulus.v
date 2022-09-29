module stimulus;
reg clk, reset;
reg [2:0] howManyTicket,origin, destination ;
wire  [5:0] costOfticket, moneyTopay, totalMoney; 
reg [5:0] money;

parameter s0=2'b00; //state
parameter s1=2'b01;
parameter s2=2'b10;
parameter s3=2'b11;

sell s( clk, reset, howManyTicket,origin, destination, money, costOfticket, moneyTopay, totalMoney );

initial clk = 1'b0;
always #5 clk = ~clk;

initial
begin
 reset = 1'b1;
 origin = 1;
 destination = 2 ;
 howManyTicket = 2 ;
 #5 reset = 1'b0;
 #20 money = 5;
 #10 money = 5;
 #10 money = 50;
 #20 reset = 1'b1;
 #5 reset = 1'b0;
end


endmodule



