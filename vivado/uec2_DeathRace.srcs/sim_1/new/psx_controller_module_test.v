


module psx_controller_module_test;

reg clk,rst;
wire c_clk,READY,gen,CMD;
reg [32:0] counter =0; 
reg ack =1;
reg [3:0] mask_counter = 1;
reg[3:0] delay = 0;
wire err_f;
wire [1:0] Controller;
reg DATA = 0,vsync;
reg [32:0] c_count = 0;
reg cbit = 0;
 
 wire [7:0] Byte1,Byte2;
 wire [3:0] Add1,Add2;
 wire Read,rd1,rd2;
 
 reg pclk =0;

psx_controller_module myPsx
(
    .vsync(vsync),
    .clk(clk),
    .rst(rst),
    .DATA(DATA),
    .CMD(CMD),
    .Controller(Controller),
    .c_clk(c_clk),
    .err_f(err_f),
    .ack(ack),
    .ByteAddress1(Add1),
    .ByteAddress2(Add2),
    .ControllerByte1(Byte1),
    .ControllerByte2(Byte2),
    .DataReady(Read),
    .read_burst(rd1&&rd2)
);

Controller_status_decode myDecoder
(
    .pclk(pclk),
    .contByte(Byte1),
    .address(Add1),
    .ready(rd1),
    .Read(Read)

);

Controller_status_decode myDecoder2
(
    .pclk(pclk),
    .contByte(Byte2),
    .address(Add2),
    .ready(rd2),
    .Read(Read)

);






    initial
        begin
            rst  =  1;
            #8;
            rst = 0;
        end   


  always
  begin
    
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
    counter  = counter + 1;
    
  end
  
  
  always 
    begin
        pclk = 1;
        #1;
        pclk =0;
        #1;
    end

always @(negedge c_clk)
    begin
        DATA = cbit;
        cbit = !cbit;
    end
    
always @(posedge c_clk)
    begin
        c_count = c_count+1;
        if (c_count == 9)
            begin
                c_count = 1;
                #20; 
                ack = 0;
                #20 ack = 1;
            end
    end 

always @*
    if (counter == 3)
        vsync = 1;
    else if (counter == 4 ) 
        vsync = 0;
        
endmodule