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
    out,a_in,b_in,clk,start,reset,finish,bcd
);

parameter N=8;

output[(N*2)-1:0] out;
output finish;
output[(((N*2)/3)+1)*4-1:0] bcd;

input clk;
input start;
input reset;
input[N-1:0] a_in;
input[N-1:0] b_in;

reg[(N*2)-1:0] out_reg;
reg[(N*2)-1:0] a_in_reg;
reg[(N*2)-1:0] b_in_reg;
reg finish_reg;
reg[(((N*2)/3)+1)*4-1:0] bcd_reg;
reg[8:0] bits;

assign out=out_reg;
assign finish=finish_reg;
assign bcd=bcd_reg;

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
end

else
begin

if(!start)
begin
a_in_reg<=a_in;
b_in_reg<=b_in;
out_reg<=0;
bcd_reg<=0;
finish_reg<=0;
bits<=N;
end

else
begin

if(bits!=0)
begin

if(b_in_reg[0])
out_reg<=out_reg+a_in_reg;

a_in_reg<=a_in_reg<<1;
b_in_reg<=b_in_reg>>1;
bits<=bits-1;

end

else if(!finish_reg)
begin

finish_reg<=1'b1;
bcd_reg<=0;

for(i=0;i<(N*2);i=i+1)
begin

if(3<=(((N*2)/3)+1)*4-1 && bcd_reg[3:0]>=5)
bcd_reg[3:0]=bcd_reg[3:0]+3;

if(7<=(((N*2)/3)+1)*4-1 && bcd_reg[7:4]>=5)
bcd_reg[7:4]=bcd_reg[7:4]+3;

if(11<=(((N*2)/3)+1)*4-1 && bcd_reg[11:8]>=5)
bcd_reg[11:8]=bcd_reg[11:8]+3;

if(15<=(((N*2)/3)+1)*4-1 && bcd_reg[15:12]>=5)
bcd_reg[15:12]=bcd_reg[15:12]+3;

bcd_reg={bcd_reg[(((N*2)/3)+1)*4-2:0],out_reg[(N*2)-1-i]};

end
end
end
end
end
endmodule