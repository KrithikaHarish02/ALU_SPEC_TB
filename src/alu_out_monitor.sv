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
		
			
		forever
			begin
			@(vif.out_mon_cb);
				duv2mon=alu_trans::type_id::create("duv2mon");
				collect_data();
				
				`uvm_info("OUTPUT_MONITOR",$sformatf("\n ,res=%d\n,err=%d\n,cout=%d\n,oflow=%d\n,l=%d\n,g=%d\n,e=%d\n",

duv2mon.res,duv2mon.err,duv2mon.cout,duv2mon.oflow,duv2mon.l,duv2mon.g,duv2mon.e),UVM_NONE)
		end
	endtask

	virtual task collect_data();
	begin
		
			
				begin
				
	  			duv2mon.res=vif.out_mon_cb.res;
	  			duv2mon.err=vif.out_mon_cb.err;
	  			duv2mon.cout=vif.out_mon_cb.cout;
	  			duv2mon.oflow=vif.out_mon_cb.oflow;
	  			duv2mon.l = vif.out_mon_cb.l;
	  			duv2mon.g = vif.out_mon_cb.g;
				duv2mon.e = vif.out_mon_cb.e;
	  	  		
          
				if((duv2mon.mode==1) && ((duv2mon.cmd==4'b1001) || (duv2mon.cmd==4'b1010)))
				repeat(3)
	  			begin
	    				@(vif.out_mon_cb);
						duv2mon.res=vif.out_mon_cb.res;
	  			end

   				end
	out_monitor_port.write(duv2mon);
	
    end
	

 endtask


 endclass

				
	
	
