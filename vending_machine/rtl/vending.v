`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2025 14:01:02
// Design Name: 
// Module Name: vending
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vending(input wire clk, reset, [1:0] money, output reg pdt, change);

    parameter sin = 4'b0000, s10 = 4'b0001, s20 = 4'b0010, s30 = 4'b0011, s40 = 4'b0100,
                s50 = 4'b0101, s60 = 4'b0110, s70 = 4'b0111, s80 = 4'b1000;
    parameter ten = 2'b00, twenty = 2'b01, fifty = 2'b10; //0 = 10 rupees, 1 = 20 rupees, 2 = 50 rupees
    reg [3:0] state, next_state;
    
    always @ (posedge clk)
        begin
            if (reset == 1)
            state <= sin;
            else
            state <= next_state;
        end
    
    //insert money part
    always @ (state, money)
        begin
            case (state)
            
                sin:
                    begin
                        if (money == ten)
                            next_state = s10;
                        else if (money == twenty)
                            next_state = s20;
                        else
                            next_state = s50;
                    end
                
                s10:
                    begin
                        if (money == ten)
                            next_state = s20;
                        else if (money == twenty)
                            next_state = s30;
                        else
                            next_state = s60;
                    end
                
                s20:
                    begin
                        if (money == ten)
                            next_state = s30;
                        else if (money == twenty)
                            next_state = s40;
                        else
                            next_state = s70;
                    end
                
                s30:
                    begin
                        if (money == ten)
                            next_state = s40;
                        else if (money == twenty)
                            next_state = s50;
                        else
                            next_state = s80;
                    end

                s40: next_state = sin;
                
                s50: next_state = sin;                            
                
                s60: next_state = sin;
                
                s70: next_state = sin;
                
                s80: next_state = sin;
                
                default: next_state = sin;
                                                                
            endcase
        end

    //product & change dispensing part
    always @ (state, money)
        begin
            case (state)
                
                sin: begin pdt = 0; change = 0; end
                s10: begin pdt = 0; change = 0; end
                s20: begin pdt = 0; change = 0; end
                s30: begin pdt = 0; change = 0; end
                s40: begin pdt = 1; change = 0; end
                s50: begin pdt = 1; change = 1; end
                s60: begin pdt = 1; change = 1; end
                s70: begin pdt = 1; change = 1; end
                s80: begin pdt = 1; change = 1; end
            
            endcase
        end

endmodule
