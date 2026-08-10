class alu_env extends uvm_env;
	`uvm_component_utils(alu_env)

	alu_config m_cfg;
	alu_scoreboard sc;
	alu_in_agent in_agnt;
	alu_out_agent out_agnt;

	function new(string name="alu_env",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(alu_config)::get(this,"","alu_config",m_cfg))
			`uvm_fatal(get_type_name(),"input agnt and output agent getting failed")
		sc=alu_scoreboard::type_id::create("sc",this);
		in_agnt=alu_in_agent::type_id::create("in_agnt",this);
		out_agnt=alu_out_agent::type_id::create("out_agent",this);

	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		in_agnt.in_mon.inp_monitor_port.connect(sc.inp_mon_fifo.analysis_export);
		out_agnt.out_mon.out_monitor_port.connect(sc.out_mon_fifo.analysis_export);
	endfunction

endclass
