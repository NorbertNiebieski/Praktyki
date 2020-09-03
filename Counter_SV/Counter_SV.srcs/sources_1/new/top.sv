`timescale 1ns / 1ps

module counter(
    input stop_start,
    input reset,
    input count_up_or_down,
    input load,
    input [7:0] data,
    input clk,

    output reg[7:0] Q
);

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            Q <= 0;
        else
            if (stop_start)
                if (load)
                    Q <= data;
                else
                    if (count_up_or_down)
                        Q <= Q + 1;
                    else
                        Q <= Q - 1;
    end
           
endmodule
