/*

101  			  --------------
		x		 |              |        y
		-------->|              |-------->
				 |     / \      |
				  --------------
				  		|
				  		|clk

		x 0   0   1   1   0   1   1   0   0   1   0   1   0   1   0   0
mealy 	y 0   0   0   0   0   1   0   0   0   0   0   1   0   1   0   0
time 	  0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15


state transition diagram: 
				
	 ------                  ------
	|	   |                |	   |      
	| 0/0 \|/	    1/0     | 1/0 \|/     0/0
     ------s0 ------------------> s1 --------------> s2
     	  /|\					  /|\				 |
     	   |					   |	  1/1		 |	
     	   |					    -----------------|
           |               							 |
           |            0/0  					     |
            -----------------------------------------


state transition analysis: 

reset state  s0, 

input: 0
output: 0
state transition: stay at s0. 
s0: seeing a ‘0’, or nothing

input: 1
output: 0 
state transition: transit to s1 from s0
s1: seeing a ‘1’, or ’01’

input: 0
output: 0 
state transition: transit to s2 from s1
s2: seeing a ’10’

input: 1
output: 1
state transition: transit to s1 from s2. because it allows for overlapping, so we just seeing a ‘1’

input: 1
output: 0
state transition: transit from s1 to s1

input: 0
output: 0 
state transition: transit from s2 to s0

*/

//Verilog code based on the state transit diagram. 

module mealy_101_detector(
	input clk, 
	input reset_n, 
	input x, 
	output y
);

reg[1 : 0] state_reg, state_next; // need two registers. 
localparam s0 = 0;
localparam s1 = 1;
localparam s2 = 2;

always @(posedge clk, negedge reset_n)
begin
	if(~reset_n)
		state_reg < = s0;
	else
		state_reg <=  state_next
end

always @(*)
begin
	case(state_reg)
		s0: if (x)
				state_next = s1;
			else
				state_next = s0;
		s1:  if (x)
				state_next = s1;
			else
				state_next = s2;
		s2:  if (x)
				state_next = s1;
			else
				state_next = s0;

		default: state_next = state_reg;
	endcase
end
 	assign y = (state_reg == s2) & x;
endmodule


/*
You can also use some encoding method (e.g. binary coding, one hot coding)
to encode the states. Then simplify the logic by using K-map, then implement
the state logic using verilog. 
*/









