class alu_out_monitor extends uvm_monitor;
	`uvm_component_utils(alu_out_monitor)

	uvm_analysis_port#(alu_trans)out_monitor_port;
	virtual alu_if.OUT_MON vif;
	
	alu_trans duv2mon;
	alu_config m_cfg;
	
	function new(string  name="alu_out_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(alu_config)::get(this,"","alu_config",m_cfg))
			`uvm_fatal(get_type_name(),"Output_Monitor Getting Failed")
		out_monitor_port=new("out_monitor_port",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		duv2mon=alu_trans::type_id::create("duv2mon");
		repeat(2)@(vif.out_mon_cb);		
		forever
			begin
				
				collect_data();
				
				`uvm_info("OUTPUT_MONITOR",$sformatf("\n OPA=%d\n,OPB=%d\n,CE=%d\n,INP_VALID=%d\n,MODE=%d\n,CMD=%d\n,CIN=%d\n,res=%d\n,err=%d\n,cout=%d\n,oflow=%d\n,l=%d\n",
duv2mon.opa,duv2mon.opb,duv2mon.ce,duv2mon.inp_valid,duv2mon.mode,duv2mon.cmd,duv2mon.cin,
duv2mon.res,duv2mon.err,duv2mon.cout,duv2mon.oflow,duv2mon.l),UVM_NONE)
		end
	endtask

	virtual task collect_data();
	begin
		
			@(vif.out_mon_cb);
				begin
				
	  			duv2mon.res=vif.out_mon_cb.res;
	  			duv2mon.err=vif.out_mon_cb.err;
	  			duv2mon.cout=vif.out_mon_cb.cout;
	  			duv2mon.oflow=vif.out_mon_cb.oflow;
	  			duv2mon.l = vif.out_mon_cb.l;
	  			
	  	  		duv2mon.ce        =   vif.out_mon_cb.ce; 
	  			duv2mon.inp_valid =   vif.out_mon_cb.inp_valid;
	  	  		duv2mon.opa        =   vif.out_mon_cb.opa;
	  	  		duv2mon.opb       =   vif.out_mon_cb.opb;
          	  		duv2mon.mode      =   vif.out_mon_cb.mode;
	  	  		duv2mon.cmd       =   vif.out_mon_cb.cmd;
          
				if((duv2mon.mode==1) && ((duv2mon.cmd==4'b1001) || (duv2mon.cmd==4'b1010)))
	  			begin
	    				@(vif.out_mon_cb);
						duv2mon.res=vif.out_mon_cb.res;
	  			end

   				end
	out_monitor_port.write(duv2mon);
	
    end
	

 endtask


 endclass

				
	
	
