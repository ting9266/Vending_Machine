module sell(clk, reset, howManyTicket,origin, destination, money, costOfticket, moneyTopay, totalMoney);
input clk, reset;
input [2:0] howManyTicket,origin, destination ;
output reg [7:0] costOfticket, moneyTopay, totalMoney; 
reg [1:0] state, next_state;
reg [2:0] temp ;
input [5:0] money;

parameter s0=2'b00; //state
parameter s1=2'b01;
parameter s2=2'b10;
parameter s3=2'b11;
initial state = s0;
initial next_state = s1;
initial costOfticket = 0;
initial totalMoney = 0;
initial moneyTopay =0;
always @(posedge clk or reset)
  begin
    if(reset)
      begin
        state = s3;
        if ( totalMoney > 0 )
          $display("exchange: ",totalMoney," dollars") ;
        totalMoney = 0 ;
        moneyTopay =0;
        costOfticket=0;
        next_state = s0;
      end
    else
      state = next_state  ;
  end
  

always @( posedge clk or state ) begin 
  if(!reset) begin
  case (state)
    s0: begin 
        costOfticket = 0 ;
        totalMoney = 0 ;
        moneyTopay =0;
        if( origin > destination )
          temp = origin - destination ;
        else
          temp = destination - origin;
        costOfticket = 5 + temp*5 ;
        temp = costOfticket ; 
        moneyTopay = costOfticket;
        end
    s1: begin 
        costOfticket = howManyTicket*costOfticket ;
        moneyTopay = costOfticket;
        end 
    s2: begin
        totalMoney = totalMoney + money ;
        $display("money ",money, ", total ",totalMoney, " dollars" ) ;
        if( totalMoney < costOfticket ) begin
          moneyTopay = costOfticket - totalMoney ;
        end
        if ( costOfticket <= totalMoney )begin 
          moneyTopay = 0 ;
          
        end
        end
    s3: begin
          $display("Change:",totalMoney-costOfticket ) ;
          $display("Ticket num:",howManyTicket) ;
          $display("\n") ;
        end  
    endcase 
  end
  end


always @(posedge clk)
begin

case(state)
  s0: next_state = s1;
  s1: next_state = s2 ;
  s2: begin
      if( totalMoney < costOfticket ) begin
        $display("Amount payable:",moneyTopay) ;
        next_state = s2 ;
        end
        else begin 
          next_state = s3 ;
        end
      end
  s3:  next_state = s0 ;
  
endcase
end 

endmodule