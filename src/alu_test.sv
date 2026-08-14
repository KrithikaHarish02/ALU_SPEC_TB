class alu_test extends uvm_test;
	`uvm_component_utils(alu_test)
	
	alu_env envh;
	
	alu_config m_cfg;
	
	function new(string name="alu_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		 m_cfg=alu_config::type_id::create("m_cfg");

		 if(!uvm_config_db#(virtual alu_if)::get(this,"","alu_if",m_cfg.vif))
			`uvm_fatal(get_type_name,"Can't get the interface")
  		m_cfg.alu_input_agent_is_active=UVM_ACTIVE;
  		m_cfg.alu_output_agent_is_active=UVM_PASSIVE;

  		uvm_config_db#(alu_config)::set(this,"*","alu_config",m_cfg);
 
  		envh=alu_env::type_id::create("envh",this);

 	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
  		super.end_of_elaboration_phase(phase);
   		uvm_top.print_topology();
	endfunction
endclass

class alu_test1 extends alu_test;
	`uvm_component_utils(alu_test1)

	alu_sequence s1;
	add_sequence ads;
	sub_sequence subs;
	add_c_sequence adcs;
	sub_c_sequence subcs;
	inc_a_sequence inca_s;
	dec_a_sequence deca_s;
	inc_b_sequence incb_s;
	dec_b_sequence decb_s;
	compare_sequence comp_s;	
	add_multi_sequence ad_mul_s;
	shift_multi_sequence sh_mul_s;
	and_sequence ands;
	nand_sequence nands;
	or_sequence ors;
	nor_sequence nors;
	xor_sequence xors;
	xnor_sequence xnors;
	not_a_sequence nota_s;
	not_b_sequence notb_s;
	rsh_a_sequence rsa_s;
	lsh_a_sequence lsa_s;
	rsh_b_sequence rsb_s;
	lsh_b_sequence lsb_s;
	rot_lft_sequence rl_s;
	rot_rght_sequence rr_s;

	function new(string name="alu_test1",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
			s1=alu_sequence::type_id::create("s1");
			s1.start(envh.in_agnt.seqr);
			ads=add_sequence::type_id::create("ads");
			ads.start(envh.in_agnt.seqr);
			subs=sub_sequence::type_id::create("subs");
			subs.start(envh.in_agnt.seqr);
			adcs=add_c_sequence::type_id::create("adcs");
			adcs.start(envh.in_agnt.seqr);
			subcs=sub_c_sequence::type_id::create("subcs");
			subcs.start(envh.in_agnt.seqr);
			inca_s=inc_a_sequence::type_id::create("inca_s");
			inca_s.start(envh.in_agnt.seqr);
			deca_s=dec_a_sequence::type_id::create("deca_s");
			deca_s.start(envh.in_agnt.seqr);
			incb_s=inc_b_sequence::type_id::create("incb_s");
			incb_s.start(envh.in_agnt.seqr);
			decb_s=dec_b_sequence::type_id::create("decb_s");
			decb_s.start(envh.in_agnt.seqr);
			comp_s=compare_sequence::type_id::create("comp_s");
			comp_s.start(envh.in_agnt.seqr);
			ad_mul_s=add_multi_sequence::type_id::create("ad_mul_s");
			ad_mul_s.start(envh.in_agnt.seqr);
			sh_mul_s=shift_multi_sequence::type_id::create("sh_mul_s");
			sh_mul_s.start(envh.in_agnt.seqr);
			ands=and_sequence::type_id::create("ands");
			ands.start(envh.in_agnt.seqr);
			nands=nand_sequence::type_id::create("nands");
			nands.start(envh.in_agnt.seqr);
			ors=or_sequence::type_id::create("ors");
			ors.start(envh.in_agnt.seqr);
			nors=nor_sequence::type_id::create("nors");
			nors.start(envh.in_agnt.seqr);
			xors=xor_sequence::type_id::create("xors");
			xors.start(envh.in_agnt.seqr);
			xnors=xnor_sequence::type_id::create("xnors");
			xnors.start(envh.in_agnt.seqr);
			nota_s=not_a_sequence::type_id::create("nota_s");
			nota_s.start(envh.in_agnt.seqr);
			notb_s=not_b_sequence::type_id::create("notb_s");
			notb_s.start(envh.in_agnt.seqr);
			rsa_s=rsh_a_sequence::type_id::create("rsa_s");
			rsa_s.start(envh.in_agnt.seqr);
			lsa_s=lsh_a_sequence::type_id::create("lsa_s");
			lsa_s.start(envh.in_agnt.seqr);
			rsb_s=rsh_b_sequence::type_id::create("rsb_s");
			rsb_s.start(envh.in_agnt.seqr);
			lsb_s=lsh_b_sequence::type_id::create("lsb_s");
			lsb_s.start(envh.in_agnt.seqr);
			rl_s=rot_lft_sequence::type_id::create("rl_s");
			rl_s.start(envh.in_agnt.seqr);
			rr_s=rot_rght_sequence::type_id::create("rr_s");
			rr_s.start(envh.in_agnt.seqr);

		phase.drop_objection(this);
	endtask
endclass
	
	

	
			



