`timescale 1ns / 1ns
 
module counter_test;
    timeunit 1ns;
    
    reg control_1;
    reg clk = 0;
    reg reset;
    
    wire [3:0] q;
    
    // clk generator
    always begin
        #5 clk = 1;  
        #5 clk = 0;
    end
    
    default clocking test @ (posedge clk);
    endclocking
    
    initial begin
        control_1 = 0;
        reset = 1;
 
        #7 reset  <= 0;
        #10 control_1 = 1;
        #30 control_1 = 0;
        #20 control_1 = 1;
        #20 control_1 = 0;
        #20 control_1 = 1;
        #100 reset = 1;
    end
    
    FSM G1 (control_1, clk, reset, q);
    
endmodule