class alu_in_agent extends uvm_agent;
	`uvm_component_utils(alu_in_agent);
		
	alu_driver drv;
	alu_sequencer seqr;
	alu_in_monitor in_mon;
	
	alu_config m_cfg;

	function new(string name="alu_in_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(alu_config)::get(this,"","alu_config",m_cfg))
			`uvm_fatal(get_type_name(),"Input_agt Getting Failed")

		in_mon=alu_in_monitor::type_id::create("in_mon",this);

		if(m_cfg.alu_input_agent_is_active==UVM_ACTIVE)
		begin
			drv=alu_driver::type_id::create("drv",this);
			seqr=alu_sequencer::type_id::create("seqr",this);
		end
	endfunction

	function void connect_phase(uvm_phase phase);
		if(m_cfg.alu_input_agent_is_active==UVM_ACTIVE)
		begin
			drv.seq_item_port.connect(seqr.seq_item_export);
		end
	endfunction
endclass

