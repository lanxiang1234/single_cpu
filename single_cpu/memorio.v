`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module memorio(caddress,
		address,
		memread,memwrite,ioread,iowrite,mread_data,ioread_data,wdata,rdata,write_data,LEDCtrl,SwitchCtrl);
    input[31:0] caddress;       // from alu_result in executs32
    input memread;				// read memory, from control32
    input memwrite;				// write memory, from control32
    input ioread;				// read IO, from control32
    input iowrite;				// write IO, from control32
    input[31:0] mread_data;		// data from memory
    input[15:0] ioread_data;	// data from io,16 bits
    input[31:0] wdata;			// the data from idecode32,that want to write memory or io
    output[31:0] rdata;			// data from memory or IO that want to read into register
    output[31:0] write_data;    // data to memory or I/O
    output[31:0] address;       // address to mAddress and I/O
    output LEDCtrl;				// LED CS
    output SwitchCtrl;          // Switch CS
    
    reg[31:0] write_data;
    wire iorw;
    
    assign  address = caddress;
    assign  rdata = (ioread==1) ? ioread_data:mread_data;
    assign  iorw = (iowrite||ioread);
	
	//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	assign	LEDCtrl = (iorw==1&&(caddress[31:0]==32'hfffffc60||caddress[31:0]==32'hfffffc62)) ? 1'b1:1'b0;
	assign	SwitchCtrl = (iorw==1&&(caddress[31:0]==32'hfffffc70||caddress[31:0]==32'hfffffc72)) ? 1'b1:1'b0;
							
    always @* begin
        if((memwrite==1)||(iowrite==1)) begin
            write_data = (memwrite) ? wdata:{16'd0,wdata[15:0]};
        end else begin
            write_data = 32'hZZZZZZZZ;
        end
    end
endmodule