class alu_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(alu_sequence)
	
	function new(string name="alu_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==1;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass


