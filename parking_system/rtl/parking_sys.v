`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.12.2025 17:12:23
// Design Name: 
// Module Name: parking_sys
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


module parking_sys (input [7:0] car, output reg [3:0] num, [3:0] avail); //for 8 parking slots [7:0], 0-8 no. of cars

    always @ (car)
        num = car[7] + car[6] + car[5] + car[4] + car[3] + car[2] + car[1] + car[0];
        assign avail = 8 - num;

endmodule
