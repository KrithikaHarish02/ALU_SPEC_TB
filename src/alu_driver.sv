class alu_driver extends uvm_driver#(alu_trans);
	`uvm_component_utils(alu_driver)
	
	virtual alu_if.INP_DRV vif;
	alu_config m_cfg;

	function new(string name="alu_driver",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(alu_config)::get(this," ","alu_config",m_cfg))
			`uvm_fatal(get_type_name(),"Input driver getting failed")
		
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction

	
	task run_phase(uvm_phase phase);
	begin
		@(vif.in_drv_cb);
			m_cfg.vif.rst<=1'b1;
		@(vif.in_drv_cb);
			m_cfg.vif.rst<=1'b0;

		forever
			begin
				seq_item_port.get_next_item(req);
				drive(req);
				seq_item_port.item_done();
			end
	end
	endtask

	task drive(alu_trans sig);
	begin
		@(vif.in_drv_cb);
			vif.in_drv_cb.opa<=sig.opa;
			vif.in_drv_cb.opb<=sig.opb;
			vif.in_drv_cb.ce<=sig.ce;
			vif.in_drv_cb.mode<=sig.mode;
			vif.in_drv_cb.inp_valid<=sig.inp_valid;
			vif.in_drv_cb.cmd<=sig.cmd;
			if(sig.mode==1 &&( (sig.cmd==4'b0010) || (sig.cmd==4'b0011)))
			begin
				vif.in_drv_cb.cin<=sig.cin;
			end
			else
				vif.in_drv_cb.cin<=1'b0;

		`uvm_info("DRIVER",$sformatf(" \nOPA=%d\n,OPB=%d\n,ce=%d\n,mode=%d\n,inp_valid=%d\n,cmd=%d\n,cin=%d\n",
sig.opa,sig.opb,sig.ce,sig.mode,sig.inp_valid,sig.cmd,sig.cin),UVM_NONE)
	end
	endtask
endclass
			
