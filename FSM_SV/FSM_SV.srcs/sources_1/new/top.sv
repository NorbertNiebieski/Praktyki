`timescale 1ns / 1ps

module FSM(
    input logic control_1,
    input logic clk,
    input logic reset,
    
    output logic [3:0] q
    );
    
    typedef enum logic [1:0] {A, B, C, D} State;
    
    State current_state, next_state;
    
    always_ff @(posedge clk)
    begin    
        if(reset)   current_state <= A;                
        else        current_state <= next_state;
    end
    
    always_comb
        case(current_state)
            A: begin
                if(control_1)   next_state <= B;
                else            next_state <= A;
                q <= 1;
            end    
            B: begin
                if(control_1)   next_state <= D;
                else            next_state <= C;
                q <= 2;
            end                       
            C: begin
                if(control_1)   next_state <= B;
                else            next_state <= C;  
                q <= 3;  
            end
                             
            D: begin
                if(control_1)   next_state <= B;
                else            next_state <= A;
                q <= 4; 
            end
            
            default:  next_state <= A;
            
        endcase
                
endmodule: FSM
