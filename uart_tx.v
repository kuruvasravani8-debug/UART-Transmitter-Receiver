// Author: Kuruva Sravani | Project 25 LAST | UART TX | 25 Projects Completed
module uart_tx (
    input clk, rst, tx_start,
    input [7:0] tx_data,
    output reg tx,
    output reg tx_done
);
    parameter IDLE=0, START=1, DATA=2, STOP=3;
    reg [1:0] state;
    reg [2:0] bit_count;
    reg [7:0] shift;

    always @(posedge clk or posedge rst) begin
        if(rst) begin state<=IDLE; tx<=1; tx_done<=0; bit_count<=0; end
        else case(state)
            IDLE: if(tx_start) begin state<=START; shift<=tx_data; tx_done<=0; end
            START: begin tx<=0; state<=DATA; bit_count<=0; end
            DATA: begin tx<=shift[0]; shift<=shift>>1;
                  if(bit_count==7) state<=STOP; else bit_count<=bit_count+1; end
            STOP: begin tx<=1; tx_done<=1; state<=IDLE; end
        endcase
    end
endmodule
