// 4-bit register
// Stuctural model 

module 4b_register
	#(parameter N = 4) (
	input clk, 
	input [N-1:0] I, 
	output [N-1:0] Q
);

genvar k;

generate 
	for(k = 0; k < N; k = k+1)
		begin: DFF
			 DFF_r(
				.clk(clk),
				.D(I[k]),
				.Q(Q[k]), 
				.rstn(),
				//.clear_n()
			);
		end
endgenerate
endmodule



//behavior model 

module 4b_register_b
	#(parameter N = 4) (
	input clk, 
	input [N-1:0] I, 
	output [N-1] Q
);

reg [N-1:0] q_reg, q_next;

always @(posedge clk)
	begin
		q_reg <= q_next;
	end

always @(I)
	begin
		q_next = I;
	end

assign Q = q_reg;

endmodule



// 4-big register with load
module 4b_register_with_load 
	#(parameter N = 4) (
	input clk, 
	input load, 
	output [N-1 : 0] I;
	output [N-1 : 0] Q;
);

reg [N-1 : 0] q_reg, q_next;

always @(posedge clk)
	begin
		q_reg <= q_next;
	end

always @(I, load)
	begin
 		if (load)
			q_next = I;
		else
			q_next = q_reg;
	end

assign Q = q_reg;

endmodule



//4-bit shift register. async reset. 
//Used for multiplying/dividing by 2 or in serial communication. 

module shift_register 
	#(parameter N = 4) (
	input clk,
	input SI, 
	input load, 
	output SO    
	output is [N-1 : 0] Q
);

reg [N-1 : 0] q_reg, q_next;

always@(posedge clk, negedge reset_n)
begin
	if(!reset_n)
		q_reg <= 1’b0;
	else 	
		q_reg <= q_next;
end

always @(SI, q_reg, load)
begin
	//right shift. 
 	if (load)
		q_next = I;
	else
		q_next = {SI, q_reg[N-1 : 1]};

	// left shift. 
	
	//q_next = {q_reg[N-2 : 0], SI};
end

assign SO = q_reg[0];
assign  Q = q_reg;
endmodule





