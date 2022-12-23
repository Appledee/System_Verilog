//D latch
module D_latch (
	input D, 
 	input clk,
	output reg Q, 
	output Q_b
);

assign Q_b = ~Q;

always @(D, clk)
begin
	Q = Q;
	if(clk)
		Q = D;
	else
		Q = Q;
end
endmodule


/*
D flipflop:
A sequential element that follows 
the input pin D at the given edge of a clock passing to the output Q
*/

module D_FF(
	input D, 
	input clk, 
	output reg Q, 
	output Q_b
);
always @(negedge clk)
begin
	Q = D;
end
endmodule




//D flipflop with async active-low reset. 

module DFF 	( input D,
              input rstn,
              input clk,
              output reg Q);

	always @ (posedge clk or negedge rstn)
       if (!rstn)
          Q <= 0;
       else
          Q <= D;
endmodule


//test bench
module tb_DFF;
	reg clk;
	reg D;
	reg rstn;
	reg [2:0] delay;

    DFF  D_FF0 ( .D(D),
                .rsnt (rstn),
                .clk (clk),
                .Q (Q));

    // Generate clock
    always #10 clk = ~clk;

    // Testcase
    initial begin
    	clk <= 0;
    	D <= 0;
    	rstn <= 0;

    	#15 D <= 1;
    	#10 rstn <= 1;
    	for (int i = 0; i < 5; i=i+1) begin
    		delay = $random;
    		#(delay) D <= i;
    	end
    end
endmodule



//D flipflop with sync active-low reset. 
module DFF 	( input D,
              input rstn,
              input clk,
              output reg Q);

	always @ (posedge clk)
       if (!rstn)
          Q <= 0;
       else
          Q <= D;
endmodule

//test bench
module tb_DFF;
	reg clk;
	reg D;
	reg rstn;
	reg [2:0] delay;

    DFF  D_FF0 ( .D(D),
                .rsnt (rstn),
                .clk (clk),
                .Q (Q));

    // Generate clock
    always #10 clk = ~clk;

    // Testcase
    initial begin
    	clk <= 0;
    	D <= 0;
    	rstn <= 0;

    	#15 D <= 1;
    	#10 rstn <= 1;
    	for (int i = 0; i < 5; i=i+1) begin
    		delay = $random;
    		#(delay) D <= i;
    	end
    end
endmodule







