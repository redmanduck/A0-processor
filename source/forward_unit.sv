/*
  forward unit for forwarding alu result
*/

`include "forward_unit_if.vh"

module forward_unit(forward_unit_if.fwu fw_if);


// forwardA choose right value to forward for operend A
//assign fw_if.forwardA = ((fw_if.regWr && fw_if.regRd) && ((fw_if.mem_rd == fw_if.ex_rs) ? (1 && fw_if.mem_rd && fw_if.ex_rs) : ((fw_if.wb_rd == fw_if.ex_rs) ? 2 : 0)));
//TODO: check that 2:
always_comb begin : forwardA
	fw_if.forwardA = 0;
	if(fw_if.regWr && fw_if.regRd)begin
		if(fw_if.mem_rd == fw_if.ex_rs)begin
			fw_if.forwardA = 1 && fw_if.mem_rd && fw_if.ex_rs;
		end else if(fw_if.ex_rs == fw_if.wb_rd)begin
			fw_if.forwardA = 2 && fw_if.ex_rs && fw_if.wb_rd;
		end else begin
			fw_if.forwardA  = 0;
		end
	end else begin
		fw_if.forwardA = 0;
	end
end
// forwardB choose right value to forward for operend B
//assign fw_if.forwardB =(!fw_if.memWr) && (fw_if.regWr && fw_if.regRd) && ((fw_if.ex_rs== fw_if.ex_rt) ? 0 : (fw_if.mem_rd == fw_if.ex_rt) ? 1 : ((fw_if.wb_rd == fw_if.ex_rt) ? 2 : 0));
//TODO: why I compare rs and rt? I may use it for avoiding forward when branch is taken

always_comb begin : forwardB
	fw_if.forwardB = 0;
	/*
			only forward B only if we choose rd over rt (RTYPE)
	*/

	if(!fw_if.memWr && fw_if.regWr && fw_if.regRd && (fw_if.ex_RegDst == 1)) begin
		if((fw_if.mem_rd == fw_if.ex_rt) && (fw_if.ex_rt != 0))begin
			fw_if.forwardB = 1;
		end else if((fw_if.wb_rd == fw_if.ex_rt) && (fw_if.wb_rd != 0))begin
			fw_if.forwardB = 2;
		end else begin
			fw_if.forwardB  = 0;
		end
	end else begin
		fw_if.forwardB = 0;
	end
end

//assign fw_if.forwardData = (fw_if.memWr) && ((fw_if.mem_rd == fw_if.ex_rt) ? 1 :((fw_if.wb_rd == fw_if.ex_rt) ? 1 : 0));
always_comb begin : proc_forwarddata
	fw_if.forwardData = 0;
	if(fw_if.memWr) begin
		if((fw_if.mem_rd == fw_if.ex_rt) && fw_if.memRegWr) begin
			fw_if.forwardData = 1;
		end else if ((fw_if.wb_rd == fw_if.ex_rt) && fw_if.wbRegWr) begin
			fw_if.forwardData = 1;
		end else begin
			fw_if.forwardData = 0;
		end
	end
end

assign fw_if.forwardR1 = fw_if.memRegWr ? (fw_if.id_rs == fw_if.mem_rd ? 1 : 0) : 0;
//assign fw_if.forwardR2 = (fw_if.memRegWr || fw_if.exMemWr) ? (fw_if.id_rt == fw_if.mem_rd ? 1 : 0) : 0;

always_comb begin : forwardR2
	fw_if.forwardR2 = 0;
	if(fw_if.memRegWr || fw_if.exMemWr) begin
 		if(fw_if.id_rt == fw_if.mem_rd) begin
 			fw_if.forwardR2 = 1;
 		end else if(fw_if.id_rt == fw_if.ex_rd && fw_if.ex_rd != 0) begin
 			fw_if.forwardR2 = 2;
 		end else if(fw_if.id_rt == fw_if.wb_rd && fw_if.wb_rd != 0) begin
 			fw_if.forwardR2 = 3;
 		end
	end else begin
		fwif.forwardR2 = 0;
	end
end
endmodule
