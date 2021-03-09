`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module minisys(clk,rst,led,switch);
input clk;
input rst;
input [23:0]switch;
output[23:0]led;
wire clki;
wire [31:0] Instruction;
wire [31:0] Pc_plus_4;
wire [31:0] Opcplus4;
wire [31:0]PC;
wire       Jrn;               
wire       RegDst;           
wire       ALUSrc;            
wire       MemorIOtoReg;      
wire       RegWrite;          
wire       MemRead;            
wire       MemWrite;           
wire       IORead;           
wire       IOWrite;           
wire       Branch;             
wire       nBranch;            
wire       Jmp;                 
wire       Jal;              
wire       I_format;           
wire       Sftmd;               
wire[1:0]  ALUOp;               
wire [31:0] Read_data_1;
wire [31:0] Read_data_2;
wire [31:0] Sign_extend;
wire [31:0] Add_Result;
wire [31:0] ALU_Result;
wire Zero;
wire [31:0]read_data;
wire [31:0]Write_data;
wire ledcs;
wire swcs;
wire [15:0] IOread_data;
wire [31:0] Address;
wire [15:0] ledi;
wire [15:0] switchi;
wire [31:0]mread_data;
cpuclk u_clk(
.clk_in1(clk),
.clk_out1(clki)
);
Ifetc32 u_Ifetc32(
.Instruction(Instruction),
.PC_plus_4_out(Pc_plus_4),
.Add_result(Add_Result),
.Read_data_1(Read_data_1),
.Branch(Branch),
.nBranch(nBranch),
.Jmp(Jmp),
.Jal(Jal),
.Jrn(Jrn),
.Zero(Zero),
.clock(clki
),
.reset(rst), 
.opcplus4(Opcplus4)
);
Idecode32 u_Idcode32(
.read_data_1(Read_data_1),
.read_data_2(Read_data_2),
.Instruction(Instruction),
.read_data(read_data),
.ALU_result(ALU_Result), 
.Jal(Jal),
.RegWrite(RegWrite),
.MemtoReg(MemorIOtoReg),
.RegDst(RegDst),
.Sign_extend(Sign_extend),
.clock(clki),
.reset(rst), 
.opcplus4(Opcplus4)
);

control32 u_control32(
.Opcode(Instruction[31:26]),
.Jrn(Jrn),
.Function_opcode(Instruction[5:0]),
.Alu_resultHigh(ALU_Result[31:10]),
.RegDST(RegDst),
.ALUSrc(ALUSrc),
.MemorIOtoReg(MemorIOtoReg),
.RegWrite(RegWrite),
.MemRead(MemRead),
.MemWrite(MemWrite),
.IORead(IORead), 
.IOWrite(IOWrite),
.Branch(Branch),
.nBranch(nBranch),
.Jmp(Jmp),
.Jal(Jal),
.I_format(I_format),
.Sftmd(Sftmd),
.ALUOp(ALUOp)
);
Executs32 u_exe32(
.Read_data_1(Read_data_1),
.Read_data_2(Read_data_2),
.Sign_extend(Sign_extend),
.Function_opcode(Instruction[5:0]),
.Exe_opcode(Instruction[31:26]),
.ALUOp(ALUOp),
.Shamt(Instruction[10:6]),
.ALUSrc(ALUSrc),
.I_format(I_format),
.Zero(Zero),
.Jrn(Jrn),
.Sftmd(Sftmd),
.ALU_Result(ALU_Result),
.Add_Result(Add_Result),
.PC_plus_4(Pc_plus_4)
);
dmemory32 u_dmemory32 (
.read_data(mread_data),
.address(Address) ,
.write_data(Write_data) ,
.Memwrite(MemWrite),
.clock(clki)
);
memorio u_memorio(
.caddress(ALU_Result),
.address(Address),
.memread(MemRead),
.memwrite(MemWrite),
.ioread(IORead),
.iowrite(IOWrite),
.mread_data(mread_data),
.ioread_data(IOread_data),
.wdata(Read_data_2),
.rdata(read_data),
.write_data(Write_data),
.LEDCtrl(ledcs),
.SwitchCtrl(swcs)
);
ioread u_ioread(
.reset(rst),
.ior(IORead),
.switchctrl(swcs),
.ioread_data(IOread_data),
.ioread_data_switch(switchi)
);
leds u_leds
(.led_clk(clki), 
.ledrst(rst),
.ledwrite(IOWrite), 
.ledcs(ledcs), 
.ledaddr(ALU_Result[1:0]),
.ledwdata(Write_data[15:0]), 
.ledout(led)
);
switchs u_switchs(
.switclk(clki), 
.switrst(rst), 
.switchread(IORead), 
.switchcs(swcs),
.switchaddr(ALU_Result[1:0]), 
.switchrdata(switchi), 
.switch_i(switch));
endmodule
