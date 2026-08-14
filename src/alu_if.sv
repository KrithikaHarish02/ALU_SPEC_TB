`include "defines.svh"
interface alu_if(input bit clk,input bit rst);

	bit [`dw-1:0]opa;
	bit [`dw-1:0]opb;
	bit [`cw-1:0]cmd;
	bit [1:0]inp_valid;
	bit [`dw*2-1:0]res;
	bit ce,mode,cin,cout,oflow,g,l,e,err;

clocking in_drv_cb @(negedge clk);
	default input #1 output #0;
	output opa;
	output opb;
	output inp_valid;
	output cmd;
	output ce,mode,cin;
endclocking

clocking in_mon_cb@(posedge clk);
	default input #0 output #0;
	input opa;
	input opb;
	input inp_valid;
	input cmd;
	input ce,mode,cin;
endclocking

clocking out_mon_cb @(posedge clk);
	default input #1 output #0;
	
	input res;
	input cout,oflow,g,l,e,err;
endclocking

modport INP_DRV(clocking in_drv_cb);
modport OUT_MON(clocking out_mon_cb);
modport IN_MON(clocking in_mon_cb);

endinterface
