`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2025 14:36:35
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(input clk, reset, output reg [2:0] N_light, S_light, E_light, W_light);
    
    reg [2:0] state;
    reg [3:0] count;
    parameter [2:0] N = 3'b000, N_Y = 3'b001, W = 3'b010, W_Y = 3'b011, 
                E = 3'b100, E_Y = 3'b101, S = 3'b110, S_Y = 3'b111;     //N, S, E, W are for green lights
    
    always @ (posedge clk, posedge reset)   //for direction
        begin
        
            if (reset)
            begin
                state = N;          //come back to N, so G light at N 
                count = 3'b0000;
            end
            
            else
            begin
                case (state)        //we are going from N -> W -> S -> E
                    
                    N:                          //if N is G
                        begin
                            if (count == 4'b1111)                   //count = 15
                                begin
                                    count = 4'b0000;                //count back to 0
                                    state = N_Y;                    //and snd swith N to N yellow
                                end
                            else
                                begin
                                    count = count + 4'b0001;        //otherwise keep counting plus
                                    state = N;                      //and keep state N
                                end
                        end                                         //for 16 clk cycles until we reach 15 we remain in N and others are R

                    N_Y:                          //if N is yellow
                        begin
                            if (count == 4'b0011)                   //count = 3
                                begin
                                    count = 4'b0000;                //count back to 0
                                    state = W;                      //and snd swith N_Y to W
                                end
                            else
                                begin
                                    count = count + 4'b0001;        //otherwise keep counting plus
                                    state = N_Y;                    //and keep state N_Y
                                end
                        end

                    W:                          
                        begin
                            if (count == 4'b1111)
                                begin
                                    count = 4'b0000;
                                    state = W_Y;
                                end
                            else
                                begin
                                    count = count + 4'b0001;
                                    state = W;
                                end
                        end

                    W_Y:                          
                        begin
                            if (count == 4'b0011)
                                begin
                                    count = 4'b0000;
                                    state = S;
                                end
                            else
                                begin
                                    count = count + 4'b0001;
                                    state = W_Y;
                                end
                        end

                    S:                          
                        begin
                            if (count == 4'b1111)
                                begin
                                    count = 4'b0000;
                                    state = S_Y;
                                end
                            else
                                begin
                                    count = count + 4'b0001;
                                    state = S;
                                end
                        end

                    S_Y:                          
                        begin
                            if (count == 4'b0011)
                                begin
                                    count = 4'b0000;
                                    state = E;
                                end
                            else
                                begin
                                    count = count + 4'b0001;
                                    state = S_Y;
                                end
                        end

                    E:                          
                        begin
                            if (count == 4'b1111)
                                begin
                                    count = 4'b0000;
                                    state = E_Y;
                                end
                            else
                                begin
                                    count = count + 4'b0001;
                                    state = E;
                                end
                        end

                    E_Y:                          
                        begin
                            if (count == 4'b0011)
                                begin
                                    count = 4'b0000;
                                    state = N;
                                end
                            else
                                begin
                                    count = count + 4'b0001;
                                    state = E;
                                end
                        end
                        
                endcase
            end
        
        end
    
    always @ (state)        //for R, G, B
        begin
            case (state)
                
                N:
                    begin
                        N_light = 3'b001;   //Green
                        W_light = 3'b100;   //Red
                        S_light = 3'b100;
                        E_light = 3'b100;
                    end

                N_Y:
                    begin
                        N_light = 3'b010;   //Yellow
                        W_light = 3'b100;
                        S_light = 3'b100;
                        E_light = 3'b100;
                    end

                W:
                    begin
                        N_light = 3'b100;
                        W_light = 3'b001;
                        S_light = 3'b100;
                        E_light = 3'b100;
                    end

                W_Y:
                    begin
                        N_light = 3'b100;
                        W_light = 3'b010;
                        S_light = 3'b100;
                        E_light = 3'b100;
                    end

                S:
                    begin
                        N_light = 3'b100;
                        W_light = 3'b100;
                        S_light = 3'b001;
                        E_light = 3'b100;
                    end

                S_Y:
                    begin
                        N_light = 3'b100;
                        W_light = 3'b100;
                        S_light = 3'b010;
                        E_light = 3'b100;
                    end

                E:
                    begin
                        N_light = 3'b100;
                        W_light = 3'b100;
                        S_light = 3'b100;
                        E_light = 3'b001;
                    end

                E_Y:
                    begin
                        N_light = 3'b100;
                        W_light = 3'b100;
                        S_light = 3'b100;
                        E_light = 3'b010;
                    end

            endcase
        end
        
endmodule
