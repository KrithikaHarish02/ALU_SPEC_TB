class alu_out_agent extends uvm_agent;

	`uvm_component_utils(alu_out_agent)

	alu_out_monitor out_mon;
	
	alu_config m_cfg;
	
	function new(string name="alu_out_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(alu_config)::get(this,"","alu_config",m_cfg))
			`uvm_fatal(get_type_name(),"Output_agt Getting Failed")
    		if(m_cfg.alu_output_agent_is_active==UVM_PASSIVE)
    		begin
    			out_mon=alu_out_monitor::type_id::create("out_mon",this); 
    		end

  	endfunction


 endclass

