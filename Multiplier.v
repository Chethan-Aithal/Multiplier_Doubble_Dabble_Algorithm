`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2026 21:47:34
// Design Name: 
// Module Name: Multiplier
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


module Multiplier(
out,
a_in,
b_in,
clk,
start,
reset,
finish,
bcd
);

parameter N=8;

output [(2*N)-1:0] out;
output finish;
output [(((2*N)/3)+1)*4-1:0] bcd;

input clk,start,reset;
input [N-1:0] a_in,b_in;

reg [(2*N)-1:0] out_reg;
reg [(2*N)-1:0] a_in_reg;
reg [(2*N)-1:0] b_in_reg;
reg finish_reg;
reg [(((2*N)/3)+1)*4-1:0] bcd_reg;

assign out=out_reg;
assign finish=finish_reg;
assign bcd=bcd_reg;

reg [8:0] bits;
reg convert;
reg [(((2*N)/3)+1)*4-1:0] bcd_temp;

integer i;

always@(posedge clk or negedge reset)
begin
if(!reset)
begin
out_reg<=0;
a_in_reg<=0;
b_in_reg<=0;
finish_reg<=0;
bcd_reg<=0;
bits<=0;
convert<=0;
end
else
begin
// Load inputs
if(!start)
begin
a_in_reg<=a_in;
b_in_reg<=b_in;
out_reg<=0;
finish_reg<=0;
bcd_reg<=0;
bits<=N;
convert<=0;
end
else
begin
// Shift and add multiplication
if(bits!=0)
begin
if(b_in_reg[0])
out_reg<=out_reg+a_in_reg;

a_in_reg<=a_in_reg<<1;
b_in_reg<=b_in_reg>>1;
bits<=bits-1;

if(bits==1)
convert<=1;
end
// Convert binary result to BCD
else if(convert)
begin
bcd_temp=0;

for(i=0;i<(2*N);i=i+1)
begin
if(bcd_temp[3:0]>=5)
bcd_temp[3:0]=bcd_temp[3:0]+3;

if((((2*N)/3)+1)>1)
if(bcd_temp[7:4]>=5)
bcd_temp[7:4]=bcd_temp[7:4]+3;

if((((2*N)/3)+1)>2)
if(bcd_temp[11:8]>=5)
bcd_temp[11:8]=bcd_temp[11:8]+3;

if((((2*N)/3)+1)>3)
if(bcd_temp[15:12]>=5)
bcd_temp[15:12]=bcd_temp[15:12]+3;

if((((2*N)/3)+1)>4)
if(bcd_temp[19:16]>=5)
bcd_temp[19:16]=bcd_temp[19:16]+3;

bcd_temp={bcd_temp[(((2*N)/3)+1)*4-2:0],out_reg[(2*N)-1-i]};
end

bcd_reg<=bcd_temp;
finish_reg<=1;
convert<=0;
end
end
end
end

endmodule
