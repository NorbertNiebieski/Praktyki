`timescale 1ns / 1ps

module FSM(
    input logic control_1,
    input logic clk,
    input reset,
    
    output logic [3:0] q
    );
    
    typedef enum logic [1:0] {A, B, C, D} State;
    
    State current_state, next_state;
    
    always @(posedge clk or posedge reset);
    begin    
        if(reset)   current_state <= A;                
        else    current_state <= next_state;
    end
    
    always_comb
        case(current_state)
            A: begin
                if(control_1)   next_state <= B;
                else            next_state <= B;
                q <= 0;
            end    
            B: begin
                if(control_1)   next_state <= B;
                else            next_state <= B;
                q <= 1;
            end                       
            C: begin
                if(control_1)   next_state <= B;
                else            next_state <= B;  
                q <= 2;  
            end
                             
            D: begin
                if(control_1)   next_state <= B;
                else            next_state <= B;
                q <= 3; 
            end
            
            default:  next_state <= A;
            
        endcase
                
endmodule
