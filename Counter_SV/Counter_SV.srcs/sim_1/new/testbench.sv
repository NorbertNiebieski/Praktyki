`timescale 1ns / 1ns
 
module counter_test;
    timeunit 1ns;
    
    reg stop_start = 1;
    reg reset = 0;
    reg count_up_or_down = 1;
    reg load = 0;
    reg [7:0] data;
    reg clk = 0;

    wire[7:0] Q;

    always
        begin
        #5 clk = 1;  // clk generator
        #5 clk = 0;
    end
    
    default clocking test @ (posedge clk);
    
    endclocking
    
    initial begin
        stop_start = 0;            
        load = 0;
        count_up_or_down = 1;
        reset = 1;
        data <= 8'b00001100;
        // Will be applied on negedge of clk!
        #5 reset  <= 0;
        // Will be applied 4ns after the clk!
        #5 stop_start <= 1;
        #10 count_up_or_down   <= 0;
        #50 count_up_or_down   <= 1;
        #55 load <= 1;
        #5 load <= 0;
        
    end
    
    counter G1 (stop_start, reset, count_up_or_down, load, data, clk, Q);
    
endmodule