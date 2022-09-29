module posedge_testbench() ;

reg clk, reset;
reg [2:0] howManyTicket,origin, destination ;
wire  [7:0] costOfticket, moneyTopay, totalMoney; 
reg [5:0] money;

parameter s0=2'b00; //state
parameter s1=2'b01;
parameter s2=2'b10;
parameter s3=2'b11;

sell s( clk, reset, howManyTicket,origin, destination, money, costOfticket, moneyTopay, totalMoney );

initial clk = 1'b0;
always #5 clk = ~clk;

initial begin
    // posedge 160ps
	// test1
		reset = 1 ;
	#10 reset = 0 ;
	    origin = 2 ;
	    destination = 5 ; // costOfTicket = 20	   
	#10 howManyTicket = 2 ; // 40元
	#10	money = 10 ; // totalMoney: 10, notEnoughMoney: 30
	#10 money = 10 ; // totalMoney: 20, notEnoughMoney: 20
	#10	reset = 1 ; // change(返還的錢): 20
	
	// test2
	#10	reset = 0 ;
	    origin = 1 ;
	    destination = 3 ; // costOfTicket = 15
	#10	reset = 1 ;
	
	// test3
	#10	reset = 0 ;
	    origin = 3 ;
	    destination = 5 ; // costOfTicket = 15	
	#10 howManyTicket = 5 ; // 75元
	#10	money = 50 ; // totalMoney: 50, notEnoughMoney: 25
	#10 money = 10 ; // totalMoney: 60, notEnoughMoney: 15
	#10 money = 5 ; // totalMoney: 65, notEnoughMoney: 10
	#10 money = 5 ; // totalMoney: 70, notEnoughMoney: 5
	#10 money = 10 ; // totalMoney: 80, notEnoughMoney: 0, change: 5, numOfTicket: 5
	#30	reset = 1 ;
end
endmodule