`default_nettype none

module mul_shft_add
#(parameter A_WIDTH = 'd32,
  parameter B_WIDTH = 'd32)
(
   input   logic [A_WIDTH-1:0]               a, 
   input   logic [B_WIDTH-1:0]               b,
   input   logic                             start, 
   input   logic                             clk,
   input   logic                             rst_n,
   output  logic                             ready,
   output  logic  [((A_WIDTH+B_WIDTH)-1):0]  product
);

localparam 

logic [A_WIDTH:0]    abs_a;
logic [5:0]          bit_count; 


assign abs_a = a[A_WIDTH-1] ? -a : a;

logic [B_WIDTH:0] adder_out=product[((2*NUM_BITS)-1):NUM_BITS] + abs_multiplicand;



always @( posedge clk  or negedge rst_n) begin
     if(~rst_n) begin
         bit_count<=6'd32;
         product<=0;
     end else if(start) begin
        bit_count  <= 6'd32;
        product    <= {{NUM_BITS{1'b0}}, (multiplier[NUM_BITS-1] & !sign) ? -multiplier : multiplier };
     //end else if( ~bit_count_last ) begin
     //   product      <= product >> 1;
     //   bit_count    <= bit_count - 6'd1;
     //   if( product[0] ) product[((2*NUM_BITS)-1):0] <= {adder_out,product[NUM_BITS-1:1]};
     //end else if(!sign && bit_count_last_clk && (multiplicand[NUM_BITS-1] ^ multiplier[NUM_BITS-1]) ) begin
     //   product <= -product;
     //end
  end
endmodule

`default_nettype logic

//****************************************************************************************
//                     * CONFIDENTIAL - ORACLE HIGHLY RESTRICTED *
