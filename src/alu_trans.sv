`include "defines.svh"
class alu_trans extends uvm_sequence_item;
	

	rand bit [`dw-1:0]opa;
	rand bit [`dw-1:0]opb;
	rand bit [`cw-1:0]cmd;
	rand bit [1:0]inp_valid;
	rand bit mode,ce,cin;
	bit [`dw*2-1:0]res;
	bit cout,oflow,g,l,e,err;

	constraint c1{
			if(mode)
				cmd<11;
			else
				cmd<13;
	}

	constraint cin_c {
    		if(!(mode && (cmd inside {4'b0010,4'b0011})))
        cin==0;
}

	`uvm_object_utils_begin(alu_trans)
		`uvm_field_int(opa,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(opb,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(cmd,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(inp_valid,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(mode,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(ce,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(cin,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(res,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(cout,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(oflow,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(g,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(l,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(e,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(err,UVM_ALL_ON | UVM_DEC)
	`uvm_object_utils_end
	
	
	function new(string name="alu_trans");
		super.new(name);
	endfunction

endclass
