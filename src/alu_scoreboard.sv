`include "defines.svh"
class alu_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(alu_scoreboard)
	uvm_tlm_analysis_fifo #(alu_trans)inp_mon_fifo;
	uvm_tlm_analysis_fifo #(alu_trans)out_mon_fifo;

	alu_trans inp_mon_xn;
	alu_trans out_mon_xn;
	alu_config m_cfg;

	 bit[7:0]oprd1,oprd2;
     	 bit[3:0]CMD_tmp;
     	 bit[7:0]AU_out_tmp1,AU_out_tmp2,OPA_1,OPB_1;
      	 bit[4:0]wait_count;
	 bit oprd1_valid;
	 bit oprd2_valid;

 function new(string name="scoreboard",uvm_component parent);
	super.new(name,parent);
	inp_mon_fifo=new("inp_mon_fifo",this);
	out_mon_fifo=new("out_mon_fifo",this);
 endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(alu_config)::get(this," ","alu_config",m_cfg))
		`uvm_fatal(get_type_name(),"Interface getting failed");
endfunction

 task run_phase(uvm_phase phase);
	forever
		begin
		inp_mon_fifo.get(inp_mon_xn);

		out_mon_fifo.get(out_mon_xn);

		ref_model(inp_mon_xn);
	   	check_Data(out_mon_xn);		
		
	   	`uvm_info("REFERENCE_MODEL",$sformatf("REFERENCE_MODEL\n%s",inp_mon_xn.sprint()),UVM_NONE)
		//validate_output();
		
		`uvm_info("CHECKING OUTPUT ",$sformatf("CHECKING OUTPUT\n%s",out_mon_xn.sprint()),UVM_NONE)
		 
		end
 endtask



 task check_Data(alu_trans ch);
`uvm_info("Scoreboard",  $sformatf("\nExp RES: %d, actual RES: %d\nExp ERR: %d, actual ERR: %d\nExp COUT: %d, actual COUT: %d\nExp OFLOW: %d, actual OFLOW: %d\nExp G: %d, actual G: %d\nExp L: %d, actual L: %d\nExp E: %d, actual E: %d\n", inp_mon_xn.res, ch.res, inp_mon_xn.err, ch.err, inp_mon_xn.cout, ch.cout, inp_mon_xn.oflow, ch.oflow, inp_mon_xn.g, ch.g, inp_mon_xn.l, ch.l, inp_mon_xn.e, ch.e), UVM_NONE)
	
	   if(inp_mon_xn.res == ch.res)
		$display("\n RES IS  MATCHING");
	   else
		$display("\n RES IS NOT MATCHING");

           if(inp_mon_xn.err == ch.err)
		$display("\n ERR IS MATCHING");
	   else
		$display("\n ERR IS NOT MATCHING");

 	   if(inp_mon_xn.cout == ch.cout)
		$display("\n COUT IS MATCHING");
	   else
		$display("\n COUT IS NOT MATCHING");

	    if(inp_mon_xn.oflow == ch.oflow)
		$display("\n OFLOW IS MATCHING");
	   else
		$display("\n OFLOW IS NOT MATCHING");

            if(inp_mon_xn.g== ch.g)
		$display("\n Greater IS MATCHING");
	   else
		$display("\n Greater IS NOT MATCHING");

	   if(inp_mon_xn.l == ch.l)
		$display("\n Lesser IS MATCHING");
	   else
		$display("\n Lesser IS NOT MATCHING");

            if(inp_mon_xn.e == ch.e)
		$display("\n Equal IS MATCHING");
	   else
		$display("\n Equal IS NOT MATCHING");
	
 endtask
	

 virtual task ref_model(alu_trans t);
	
       if(m_cfg.vif.rst) begin
        oprd1=0;
        oprd2=0;
        CMD_tmp=0;
	wait_count=0;
	oprd1_valid=0;
	oprd2_valid=0;

      end
      else if (t.inp_valid==2'b01)  begin    
        oprd1=t.opa;
        CMD_tmp=t.cmd;
	oprd1_valid=1;
	wait_count=0;
	if(oprd1_valid && wait_count>=16)
	begin
		t.err=1'b1;
	end
	
      end
     else if (t.inp_valid==2'b10)  begin    
        oprd2=t.opb;
        CMD_tmp=t.cmd;
	oprd2_valid=1;
	wait_count=0;
	if(oprd1_valid && wait_count>=16)
	begin
		t.err=1'b1;
	end
	
      end
      else if (t.inp_valid==2'b11)  begin    
        oprd1=t.opa;
	oprd2=t.opb;
        CMD_tmp=t.cmd;
	oprd1_valid=1;
	oprd2_valid=1;
	wait_count=0;
      end
      else begin    
	if((oprd1_valid && !oprd2_valid ) || (!oprd1_valid && oprd2_valid))
	begin
		if(wait_count<16)
			wait_count=wait_count+1;
		else
			wait_count=16;
      	end 
     end

     if(t.ce)                   
        begin
         if(m_cfg.vif.rst)                
          begin
            t.res=9'bzzzzzzzzz;
            t.cout=1'bz;
            t.oflow=1'bz;
            t.g=1'bz;
            t.e=1'bz;
            t.l=1'bz;
            t.err=1'bz;
	    AU_out_tmp1=0;
            AU_out_tmp2=0;
	  end
 
         else if(t.mode)          
         begin
            t.res=9'bzzzzzzzzz;
            t.cout=1'bz;
            t.oflow=1'bz;
            t.g=1'bz;
            t.e=1'bz;
            t.l=1'bz;
            t.err=1'bz;
	case(CMD_tmp)             
    4'b0000: 
	if(oprd1_valid && oprd2_valid)
	begin             
              t.res=oprd1+oprd2;
	      t.cout=t.res[8]?1:0;
        end
     4'b0001 :
	if(oprd1_valid && oprd2_valid)
	begin
             t.oflow=(oprd1<oprd2)?1:0;
             t.res=oprd1-oprd2;
        end
     4'b0010:
	if(oprd1_valid && oprd2_valid)            
            begin
             t.res=oprd1+oprd2+t.cin;
             t.cout=t.res[8]?1:0;
            end
     4'b0011: 
	if(oprd1_valid && oprd2_valid)            
           begin
            t.oflow=(oprd1<oprd2)?1:0;
            t.res=oprd1-oprd2-t.cin;
           end
     4'b0100:
	if(oprd1_valid)
	begin
		t.res=oprd1+1; 
	end    
     4'b0101:
	if(oprd1_valid)
	begin
		t.res=oprd1-1; 
	end   
     4'b0110:
	if(oprd2_valid)
	begin
		t.res=oprd2+1;
	end     
     4'b0111:
	if(oprd2_valid)
	begin
		t.res=oprd2-1; 
	end
     4'b1000:
	if(oprd1_valid && oprd2_valid)             
           begin
            t.res=9'bzzzzzzzzz;
            if(oprd1==oprd2)
             begin
               t.e=1'b1;
               t.g=1'bz;
               t.l=1'bz;
             end
            else if(oprd1>oprd2)
             begin
               t.e=1'bz;
               t.g=1'b1;
               t.l=1'bz;
             end
            else 
             begin
               t.e=1'bz;
               t.g=1'bz;
               t.l=1'b1;
             end
           end

	4'b1001:
		if(oprd1_valid && oprd2_valid)
		 begin   
                    AU_out_tmp1 = oprd1 + 1;
                    AU_out_tmp2 = oprd2 + 1;
                    t.res =AU_out_tmp1 * AU_out_tmp2;
                  end
	4'b1010:
		if(oprd1_valid && oprd2_valid)
		 begin   
                    AU_out_tmp1 = oprd1 << 1;
                    AU_out_tmp2 = oprd2;
                    t.res =AU_out_tmp1 * AU_out_tmp2; 
                  end

	default:   
            begin
            t.res=9'bzzzzzzzzz;
            t.cout=1'bz;
            t.oflow=1'bz;
            t.g=1'bz;
            t.e=1'bz;
            t.l=1'bz;
            t.err=1'bz;
           end
          endcase
         end

	else          
        begin 
            t.res=9'bzzzzzzzzz;
            t.cout=1'bz;
            t.oflow=1'bz;
            t.g=1'bz;
            t.e=1'bz;
            t.l=1'bz;
            t.err=1'bz;
	case(CMD_tmp)    
             4'b0000:t.res={1'b0,oprd1&oprd2};     
             4'b0001:t.res={1'b0,~(oprd1&oprd2)};
	     4'b0010:t.res={1'b0,oprd1|oprd2};  
 	     4'b0011:t.res={1'b0,~(oprd1|oprd2)};
	     4'b0100:t.res={1'b0,oprd1^oprd2};     
             4'b0101:t.res={1'b0,~(oprd1^oprd2)};  
 	     4'b0110:t.res={1'b0,~oprd1};       
             4'b0111:t.res={1'b0,~oprd2};        
	     4'b1000:t.res={1'b0,oprd1>>1};       
             4'b1001:t.res={1'b0,oprd1<<1};
	     4'b1010:t.res={1'b0,oprd2>>1};      
             4'b1011:t.res={1'b0,oprd2<<1};      
	     4'b1100:                        
             begin 
               if(oprd2[0])
                 OPA_1 = {oprd1[6:0], oprd1[7]};
               else
                 OPA_1 = oprd1;
 
               if(oprd2[1])
                 OPB_1 =  {OPA_1[5:0], OPA_1[7:6]}; 
               else
                 OPB_1= OPA_1;
 
               if(oprd2[2])
                 t.res =  {OPB_1[3:0], OPB_1[7:4]} ;
               else
                 t.res = OPB_1;
 
               if(oprd2[4] | oprd2[5] | oprd2[6] | oprd2[7])
                 t.err=1'b1;
             end

	4'b1101:                       
             begin
               if(oprd2[0])
                 OPA_1 = {oprd1[0], oprd1[7:1]};
               else
                 OPA_1 = oprd1;
               if(oprd2[1])
                 OPB_1 =  {OPA_1[1:0], OPA_1[7:2]}; 
               else
                 OPB_1= OPA_1;
               if(oprd2[2])
                 t.res =  {OPB_1[3:0], OPB_1[7:4]} ;
               else
                 t.res = OPB_1;
               if(oprd2[4] | oprd2[5] | oprd2[6] | oprd2[7])
                 t.err=1'b1;
             end
             default:    
               begin
               t.res=9'bzzzzzzzzz;
               t.cout=1'bz;
               t.oflow=1'bz;
               t.g=1'bz;
               t.e=1'bz;
               t.l=1'bz;
               t.err=1'bz;
               end
          endcase
     end
    end
endtask 



endclass

