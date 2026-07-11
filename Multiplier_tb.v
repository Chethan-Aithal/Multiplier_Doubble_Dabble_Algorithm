`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2026 22:20:33
// Design Name: 
// Module Name: Multiplier_tb
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


module Multiplier_tb;

parameter n_bits=5;

reg [n_bits-1:0] a_in;
reg [n_bits-1:0] b_in;
reg clk;
reg start;
reg reset;

wire [(2*n_bits)-1:0] out;
wire finish;
wire [(((n_bits*2)/3)+1)*4-1:0] bcd;

Multiplier #(.N(n_bits)) dut(
.out(out),
.a_in(a_in),
.b_in(b_in),
.clk(clk),
.start(start),
.reset(reset),
.finish(finish),
.bcd(bcd)
);
initial
begin
clk=0;
forever #5 clk=~clk;
end
initial
begin
reset=0;
start=0;
a_in=0;
b_in=0;
#20;
reset=1;
a_in=26;
b_in=30;
start=0;
#10;
start=1;
wait(finish);
#20;
start=0;
a_in=13;
b_in=13;
#10;
start=1;
wait(finish);
#20;
$finish;
end
endmodule
