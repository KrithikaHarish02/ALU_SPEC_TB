class alu_in_monitor extends uvm_monitor;
	`uvm_component_utils(alu_in_monitor)
	
	virtual alu_if.INP_MON vif;
	alu_config m_cfg;
	uvm_analysis_port#(alu_trans)inp_monitor_port;
	alu_trans drv2mon;	

	function new(string name="alu_in_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(alu_config)::get(this," ","alu_config",m_cfg))
			`uvm_fatal(get_type_name(),"Input monitor getting failed")
			inp_monitor_port=new("inp_monitor_port",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
	begin
		drv2mon=alu_trans::type_id::create("drv2mon");
		repeat(2)@(vif.in_mon_cb);			
		forever begin
		
			collect_input_monitor();

			`uvm_info("INPUT_MONITOR",$sformatf("\n OPA=%d\n,OPB=%d\n,CE=%d\n,INP_VALID=%d\n,MODE=%d\n,CMD=%d\n,CIN=%d,\n",
drv2mon.opa,drv2mon.opb,drv2mon.ce,drv2mon.inp_valid,drv2mon.mode,drv2mon.cmd,drv2mon.cin),UVM_NONE)
		end
	end
	endtask

	virtual task collect_input_monitor();
	   begin
		
		@(vif.in_mon_cb);
		drv2mon=alu_trans::type_id::create("drv2mon");		
		drv2mon.ce=vif.in_mon_cb.ce;
		drv2mon.opa=vif.in_mon_cb.opa;
		drv2mon.opb=vif.in_mon_cb.opb;
		drv2mon.inp_valid=vif.in_mon_cb.inp_valid;
		drv2mon.mode=vif.in_mon_cb.mode;
		drv2mon.cmd=vif.in_mon_cb.cmd;
		if((drv2mon.mode==1) && ((drv2mon.cmd==4'b0010) || (drv2mon.cmd==4'b0011)))
	   	begin
			drv2mon.cin =vif.in_mon_cb.cin;
	     	end
		inp_monitor_port.write(drv2mon);
	    end
	//@(vif.in_mon_cb);
	endtask
endclass

