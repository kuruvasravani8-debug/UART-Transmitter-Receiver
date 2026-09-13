// Author: Kuruva Sravani | Project 25 LAST | UART RX
module uart_rx (
    input clk, rst, rx,
    output reg [7:0] rx_data,
    output reg rx_done
);
    parameter IDLE=0, START=1, DATA=2, STOP=3;
    reg [1:0] state;
    reg [2:0] bit_count;
    always @(posedge clk or posedge rst) begin
        if(rst) begin state<=IDLE; rx_done<=0; bit_count<=0; end
        else case(state)
            IDLE: if(rx==0) begin state<=START; rx_done<=0; end
            START: state<=DATA;
            DATA: begin rx_data[bit_count]<=rx; if(bit_count==7) state<=STOP; else bit_count<=bit_count+1; end
            STOP: begin rx_done<=1; state<=IDLE; end
        endcase
    end
endmodule
