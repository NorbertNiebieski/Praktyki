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
    
    /*
    program test;

        clocking cb_counter @(posedge clk);
            default input #1step output #4;
            output negedge reset;
            output stop_start, load, count_up_or_down, data;
            input Q;
        endclocking

        initial begin
   
            stop_start = 0;            
            load = 0;
            count_up_or_down = 1;
            reset = 1;

            // Will be applied on negedge of clk!
            ##1 cb_counter.reset  <= 0;
            // Will be applied 4ns after the clk!
            ##1 cb_counter.stop_start <= 1;
            ##2 cb_counter.count_up_or_down   <= 0;
            ##4 cb_counter.count_up_or_down   <= 1;
            // etc. ...      
        end

        // Check the results - could combine with stimulus block
        *//*initial begin
            ##1   
            // Sampled 1ps (or whatever the precision is) before posedge clk
            ##1 assert (cb_counter.Q == 4'b0000);
            ##1 assert (cb_counter.Q == 4'b0000);
            ##2 assert (cb_counter.Q == 4'b0010);
            ##4 assert (cb_counter.Q == 4'b1110);
            // etc. ...      
        end
        *//*
    // Simulation stops automatically when both initials have been completed

    endprogram

    // Instance the counter
    counter G1 (clk, reset, stop_start, load, count_up_or_down, data, Q);

    // Instance the test program - not reQuired, because program will be
    // instanced implicitly.
    // test_COUNTER T1 ();
    */    
endmodule