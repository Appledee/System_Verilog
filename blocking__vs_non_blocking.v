//Verilog blocking assignment

module comb_blocking(
input a, b, c, 
output reg x
);

always @(a, b, c)
begin
	x = a;
	x = x^b;
	x = x|c;
end

endmodule

/*
the value of a is immediately assigned to x, 
and updated to the second and third blocking assignment, 
from right to left. This synthesize to some logic gates. 
*/




//Verilog non-blocking assignment, 

module com_non_blocking (
input a, b, c, 
output reg x);

always @ (*) 
begin 
	x<= a;
	x<= x^b;
	x<=x|c;
end
end module

/*
Since it’s non-blocking assignment, 
the value will not be assigned to the left side immediately. 
At the end, only x<=x|c will be evaluated and which doesn’t make any sense. 

non-blocking assignment should not be used in the procedure 
statement in the combination circuit. 
*/
