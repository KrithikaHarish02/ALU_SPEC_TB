        `include "test_pkg.sv"
	`include "alu_if.sv"
	`include "ALU_DESIGN.sv"

 module top();       
	import uvm_pkg::*;
	import test_pkg::*;

	bit clk;
	bit rst;

	alu_if DUV_IF(clk,rst);

   
 //instatiate DUV
        ALU_DESIGN DUV(.OPA(DUV_IF.opa),.OPB(DUV_IF.opb),.CLK(clk),.RST(DUV_IF.rst),.CE(DUV_IF.ce),.MODE(DUV_IF.mode),
		.CIN(DUV_IF.cin),.CMD(DUV_IF.cmd),.INP_VALID(DUV_IF.inp_valid),.RES(DUV_IF.res),.COUT(DUV_IF.cout),
		.OFLOW(DUV_IF.oflow),.G(DUV_IF.g),.E(DUV_IF.e),.L(DUV_IF.l),.ERR(DUV_IF.err));

	/*initial 
	begin
		rst=1;
		#10;
		rst=0;
	end*/


 	initial
	begin
		uvm_config_db#(virtual alu_if)::set(null,"*","alu_if",DUV_IF);
		$dumpfile("waves.fsdb");
		  $dumpvars;

	        run_test("alu_test1");
		
	end


	
	initial
	begin
		clk=1'b0;
		forever 
		   #5 clk=~clk;
	end

endmodule

