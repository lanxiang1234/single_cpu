`timescale 1ns / 1ps
module dmemory32(read_data,address,write_data,Memwrite,clock);
// Clock signal
input clock;
// From the execution unit alu_resul
input[31:0] address;
// From the decoding unit Read_data2
input[31:0] write_data;
// From the control unit
input Memwrite;
// Data read from memory
output[31:0] read_data;
assign clk = !clock;
//Create a instance of RAM(IP core),binding the ports
RAM ram (
.clka(clk), // input wire clka
.wea(Memwrite), // input wire [0 : 0] wea
.addra(address[15:2]), // input wire [13 : 0] addra
.dina(write_data), // input wire [31 : 0] dina
.douta(read_data) // output wire [31 : 0] douta
);
endmodule
