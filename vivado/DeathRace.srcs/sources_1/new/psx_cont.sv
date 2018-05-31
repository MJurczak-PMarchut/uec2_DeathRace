module controller_io(
             input logic    clk, rst, start,
		     input logic 	DATA, ACK,
		     output logic 	err,
		     output logic 	COMMAND, ATT, 
		     output logic 	c_clk,
		     output logic 	SLCT, STRT, UP, RGHT, DOWN, LEFT,
		     output logic 	L1, L2, R1, R2, TRI, SQU, XXX, CIR,
		     output logic [7:0] RJOY_X, RJOY_Y, LJOY_X, LJOY_Y,
		     output logic 	RJOY, LJOY);

   /* PARAMETERS */
   
   /* states */
   parameter [15:0] upCount = 400;
//   parameter [2:0] IDLE     = 3'b000;
//   parameter [2:0] CLK_FALL = 3'b001;
//   parameter [2:0] LOAD_TX  = 3'b010;
//   parameter [2:0] CLK_RISE = 3'b011;
//   parameter [2:0] LOAD_RX  = 3'b100;
//   parameter [2:0] ACK_FALL = 3'b101;
//   parameter [2:0] ACK_RISE = 3'b110;
//   parameter [2:0] ERROR    = 3'b111;
     
   reg [7:0] current_state, next_state;
   reg [3:0] mode,next_mode;
   reg Init = 1;
   reg status = 1;
   reg c_clk_next = 0;
   reg [15:0] counter = 0;
   reg [4:0] DELAY_CLK;
   reg [5:0] BytesToReceive= 0;
   reg [5:0] ByteCounter = 0;
   reg [7:0] Data [3:0];
   
   
   localparam IDLE = 8'h1;
   localparam CLK_FALL = 8'h2;
   localparam CLK_RISE = 8'h3;
   localparam DELAY = 8'h4;
   localparam START = 8'h5;
   localparam FINISHED = 8'h6;
   
   localparam SEND = 4'h1;
   localparam RECEIVE  = 4'h2;
   localparam SLEEP = 4'h4;
   localparam mSTART = 4'h5;
   
   localparam IN_PROGRESS = 1'b0;
   localparam STOP = 1'b1;
   
   /* controller signatures */
   localparam ID_DIGITAL = 8'h41;  // digital
   localparam ID_ANALOGR = 8'h73;  // analog red LED
   localparam ID_ANALOGG = 8'h53;  // analog green LED

   /* controller type encoding */
   localparam TYPE_XX = 4'b0001;  // no type
   localparam TYPE_DI = 4'b0010;  // digital
   localparam TYPE_AR = 4'b0100;  // analog reg
   localparam TYPE_AG = 4'b1000;  // analog green
   
   /* byte sequences */
   localparam START_COMM   = 8'h01;  // signal start of transfer
   localparam DATA_REQUEST = 8'h42;  // PSX -> Controller; request data
   localparam DATA_READY   = 8'h5A;  // Controller -> PSX; data coming
   localparam NO_DATA      = 8'hFF;
   
//   always @(clk)
//    if(clk)
//        if(mode == mSTART)
//            next_state = CLK_RISE;
//        else if(mode == SLEEP)
//            next_state = FINISHED;
//        else if(mode == mDELAY)
//            next_state = DELAY;
//        else
//            next_state = CLK_RISE;
//    else 
//        if(mode == mSTART)
//            next_state = CLK_FALL;
//        else if(mode == SLEEP)
//            next_state = FINISHED;
//        else if(mode == mDELAY)
//            next_state = DELAY;
//        else 
//            next_state = CLK_FALL;
            
            
//     always @counter
//        if(counter == upCount) 
//                c_clk_next = ~c_clk;                
            
            
//      always @clk
//        if(status  == IN_PROGRESS)
//            if(counter <= upCount) 
//                counter++;
//            else 
//                counter = 0;
        
//        always @c_clk_next
//        begin
//            if((mode != SLEEP) || (current_state != FINISHED) || (current_state != IDLE) || (current_state != DELAY))
//                c_clk = c_clk_next;
//            else
//                c_clk =1;
//        end      
             
             
// generuj zegar
reg last_clk = 0 ;

    always @(posedge clk)
        begin
            if(current_state == START)
            begin
                counter = 0;
                c_clk = 0;
            end
            else if(current_state != IDLE)
                if(counter  >= upCount)
                    begin
                        counter = 0;
                        if(current_state == DELAY)
                            c_clk_next = 1;
                        else 
                            c_clk_next = ~c_clk_next;
                    end
                else
                    counter++;           
        end  
        
//state 

    always @(posedge clk)        
        begin
            if((c_clk = 1) || (last_clk = 0) && (current_state != DELAY))
                if(DELAY_CLK == 8)
                    begin
                        next_state = DELAY;
                        DELAY_CLK = 0;
                    end
                else 
                    DELAY_CLK++;
            last_clk = c_clk;    
        end
                
                
   /* DEBUG LINES */
   //reg 		  ACK;



 



endmodule // controller_io