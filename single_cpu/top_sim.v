module top_sim();
    reg clk       = 0;
    reg rst       = 1;
    reg [23:0]switch2N4 = 24'h00F876;
    wire [23:0]led2N4; 
    minisys u (.clk(clk), .rst(rst), .led(led2N4) , .switch(switch2N4));
    initial begin
       #7000 rst = 0;       
        #1000 switch2N4[23:21]=3'b001;
        $display("switch = %h hex", switch2N4);
        $display("led = %h hex", led2N4);
        $display("simulation time is %t ns",$time);
        #1000 switch2N4[23:21]=3'b010;
         $display("switch = %h hex", switch2N4);
        $display("led = %h hex", led2N4);
        $display("simulation time is %t ns",$time);
        #1000 switch2N4[23:21]=3'b011;
         $display("switch = %h hex", switch2N4);
        $display("led = %h hex", led2N4);
        $display("simulation time is %t ns",$time);
        #1000 switch2N4[23:21]=3'b101;
         $display("switch = %h hex", switch2N4);
        $display("led = %h hex", led2N4);
        $display("simulation time is %t ns",$time);
        #1000 switch2N4[23:21]=3'b111;
         $display("switch = %h hex", switch2N4);
        $display("led = %h hex", led2N4);
        $display("simulation time is %t ns",$time);
        #1000 switch2N4[23:21]=3'b110;
         $display("switch = %h hex", switch2N4);
        $display("led = %h hex", led2N4);
        $display("simulation time is %t ns",$time);
        
    end
    always #10 clk = ~clk;
endmodule
