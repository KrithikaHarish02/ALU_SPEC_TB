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
			assert(req.randomize());
			finish_item(req);
		end
		end
	endtask
endclass

class add_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(add_sequence)
	
	function new(string name="add_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==0;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class sub_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(sub_sequence)
	
	function new(string name="sub_sequence");
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


class add_c_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(add_c_sequence)
	
	function new(string name="add_c_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==2;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class sub_c_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(sub_c_sequence)
	
	function new(string name="sub_c_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==3;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class inc_a_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(inc_a_sequence)
	
	function new(string name="inc_a_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==4;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class dec_a_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(dec_a_sequence)
	
	function new(string name="dec_a_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==5;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class inc_b_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(inc_b_sequence)
	
	function new(string name="inc_b_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==6;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class dec_b_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(dec_b_sequence)
	
	function new(string name="dec_b_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==7;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class compare_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(compare_sequence)
	
	function new(string name="compare_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==8;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class add_multi_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(add_multi_sequence)
	
	function new(string name="add_multi_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==9;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass


class shift_multi_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(shift_multi_sequence )
	
	function new(string name="shift_multi_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 1;cmd==10;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass



class and_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(and_sequence )
	
	function new(string name="and_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==0;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass


class nand_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(nand_sequence )
	
	function new(string name="nand_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==1;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class or_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(or_sequence )
	
	function new(string name="or_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==2;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class nor_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(nor_sequence )
	
	function new(string name="nor_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==3;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass


class xor_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(xor_sequence )
	
	function new(string name="xor_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==4;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass


class xnor_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(xnor_sequence )
	
	function new(string name="xnor_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==5;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class not_a_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(not_a_sequence )
	
	function new(string name="not_a_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==6;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class not_b_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(not_b_sequence )
	
	function new(string name="not_b_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==7;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass


class rsh_a_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(rsh_a_sequence )
	
	function new(string name="rsh_a_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==8;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass


class lsh_a_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(lsh_a_sequence )
	
	function new(string name="lsh_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==9;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class rsh_b_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(rsh_b_sequence )
	
	function new(string name="rsh_b_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==10;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class lsh_b_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(lsh_b_sequence )
	
	function new(string name="lsh_b_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==11;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class rot_lft_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(rot_lft_sequence )
	
	function new(string name="rot_lft_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==12;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass

class rot_rght_sequence extends uvm_sequence #(alu_trans);
	`uvm_object_utils(rot_rght_sequence )
	
	function new(string name="rot_rght_sequence ");
		super.new(name);
	endfunction

	task body();
		repeat(10)begin
		req=alu_trans::type_id::create("req");
		begin
			start_item(req);
			assert(req.randomize() with {inp_valid == 3; mode == 0;cmd==13;ce==1;});
			finish_item(req);
		end
		end
	endtask
endclass


