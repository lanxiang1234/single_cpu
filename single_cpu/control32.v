`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module control32(
    Opcode,Jrn,Function_opcode,Alu_resultHigh,RegDST,ALUSrc,MemorIOtoReg,RegWrite,MemRead,MemWrite,IORead, IOWrite,Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp
);
    input [5:0] Opcode;
    input [5:0] Function_opcode;
    output Jrn;
    input[21:0] Alu_resultHigh; // From the execution unit Alu_Result[31..10]
    output RegDST;
    output ALUSrc;
    output MemorIOtoReg; // 1 indicates that data needs to be read from memory or I/O
    output RegWrite; // 1 indicates that the instruction needs to write to the register
    output MemRead; // 1 indicates that the instruction needs to read from the memory
    output MemWrite; // 1 indicates that the instruction needs to write to the memory
    output IORead; // 1 indicates I/O read
    output IOWrite; // 1 indicates I/O write
    output Branch;
    output nBranch;
    output Jmp;
    output Jal;
    output I_format;
    output Sftmd;
    output [1:0]ALUOp;
    wire R_format;		
    wire Lw;          
    wire Sw;            
    assign R_format = (Opcode==6'b000000)? 1'b1:1'b0;        //--00h 
    assign RegDST = R_format;                               
    assign I_format = (Opcode==6'b001000 || Opcode==6'b001001 || Opcode==6'b001100 || Opcode==6'b001101 || Opcode==6'b001110 || Opcode==6'b001111 || Opcode==6'b001010 || Opcode==6'b001011)?1'b1:1'b0;  
    assign Lw = (Opcode == 6'b100011)? 1'b1:1'b0;
    assign Sw = (Opcode == 6'b101011)? 1'b1:1'b0;
    assign Jal = (Opcode == 6'b000011)?1'b1:1'b0;
    assign Jrn = (Opcode == 6'b000000 &&  Function_opcode==6'b001000)?1'b1:1'b0;
    assign RegWrite = (R_format || Lw || Jal || I_format) && !(Jrn) ;
    assign IORead = (Lw == 1'b1 && Alu_resultHigh[21:0] == 22'H3FFFFF)?1'b1:1'b0; 
    assign IOWrite= (Sw == 1'b1 && Alu_resultHigh[21:0] == 22'H3FFFFF)?1'b1:1'b0; 
    assign Branch = (Opcode == 6'b000100)? 1'b1:1'b0;
    assign nBranch = (Opcode == 6'b000101)? 1'b1:1'b0;
    assign ALUSrc = (Opcode == 6'b001000||Opcode==6'b001001||Opcode==6'b001100||Opcode==6'b001101||Opcode==6'b001110||Opcode==6'b001111||Opcode==6'b100011||Opcode==6'b101011||Opcode==6'b001010||Opcode==6'b001011) ? 1'b1 : 1'b0;
    assign Jmp = (Opcode == 6'b000010)? 1'b1:1'b0;
    assign MemWrite = ((Sw==1) && (Alu_resultHigh[21:0] != 22'H3FFFFF)) ? 1'b1:1'b0;
    assign MemRead = ((Lw==1) && (Alu_resultHigh[21:0] != 22'H3FFFFF)) ? 1'b1:1'b0;
    assign MemorIOtoReg = IORead || MemRead;
    assign Sftmd = (Opcode==6'b000000&&(Function_opcode==6'b000000||Function_opcode==6'b000010||Function_opcode==6'b000011||Function_opcode==6'b000100||Function_opcode==6'b000110||Function_opcode==6'b000111))? 1'b1:1'b0 ;
    assign ALUOp = {(R_format || I_format),(Branch || nBranch)}; 
endmodule
