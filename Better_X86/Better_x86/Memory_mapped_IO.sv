import lc3b_types::*;

module Memory_Mapped_IO
(
	input clk,
	input [3:0] counter,
	input mem_read,
	input mem_write,
	input MMIO_read,
	input MMIO_write,

	input Icache_resp,
	input Dcache_resp,
	input L2cache_resp,
	input branch,
	input branch_not,
	input stall_IF_ID,
	input stall_ID_EX,
	input stall_EX_MEM,
	input stall_MEM_WB,
	output lc3b_word counter_out
);

lc3b_word Icache_hit;
lc3b_word Icache_miss;

lc3b_word Dcache_hit;
lc3b_word Dcache_miss;

lc3b_word L2cache_hit;
lc3b_word L2cache_miss;

lc3b_word total_branch;
lc3b_word branch_taken;
lc3b_word branch_not_taken;

lc3b_word _stall_IF_ID;
lc3b_word _stall_ID_EX;
lc3b_word _stall_EX_MEM;
lc3b_word _stall_MEM_WB;

logic Icache_access;
logic Dcache_access;
logic L2cache_access;

logic IF_ID;
logic ID_EX;
logic EX_MEM;
logic MEM_WB;

lc3b_word stall_all;
lc3b_word stall_PC_IFID;

logic all;
logic PC_IFID;


initial
begin

	Icache_access = 1'b0;
	Icache_hit = 4'h0000;
	Icache_miss = 4'h0000;

	Dcache_access = 1'b0;
	Dcache_hit = 4'h0000;
	Dcache_miss = 4'h0000;
	
	L2cache_access = 1'b0;
	L2cache_hit = 4'h0000;
	L2cache_miss = -1;
	
	total_branch = 4'h0000;
	branch_taken = 4'h0000;
	branch_not_taken = 4'h0000;
	
	_stall_IF_ID = 4'h0000;
	_stall_ID_EX = 4'h0000;
	_stall_EX_MEM = 4'h0000;
	_stall_MEM_WB = 4'h0000;
	
	IF_ID = 1'b0;
	ID_EX = 1'b0;
	EX_MEM = 1'b0;
	MEM_WB = 1'b0;
	
	stall_all = -1;
	stall_PC_IFID = 4'h0000;
	
	all = 1'b0;
	PC_IFID = 1'b0;
end
always_ff @ (negedge clk)
begin

	if(!Dcache_resp && (mem_read || mem_write) && !Dcache_access)
	begin
		Dcache_miss = Dcache_miss + 1'b1;
		Dcache_access = 1'b1;
	end
	if(Dcache_resp && (mem_read || mem_write))
	begin
		Dcache_access = 1'b0;
		Dcache_hit = Dcache_hit + 1'b1;
	end

	if( !Icache_resp && !Icache_access)
	begin
		Icache_miss = Icache_miss + 1'b1;
		Icache_access = 1'b1;
	end
	if(Icache_resp )
	begin
		Icache_access = 1'b0;
		Icache_hit = Icache_hit + 1'b1;
	end
	
	if(!L2cache_resp && !L2cache_access)
	begin	
		L2cache_access = 1'b1;
		L2cache_miss = L2cache_miss + 1'b1;
	end
	
	if(L2cache_resp)
	begin
		L2cache_access = 1'b0;
		L2cache_hit = L2cache_hit + 1'b1;
	end

	if(branch)
	begin
		total_branch = total_branch + 1'b1;
		branch_taken = branch_taken + 1'b1;
	end
	if(branch_not)
		branch_not_taken = branch_not_taken + 1'b1;
		
		
		
	if(stall_IF_ID && !IF_ID)
	begin
		_stall_IF_ID = _stall_IF_ID + 1'b1;
		IF_ID = 1'b1;
		
	end
	
	else if(!stall_IF_ID)
	begin
		IF_ID = 1'b0;
		PC_IFID = 1'b0;

	end
	
	if(stall_ID_EX && !ID_EX)
	begin
		_stall_ID_EX = _stall_ID_EX + 1'b1;
		ID_EX = 1'b1;

	end
	
	else if(!stall_ID_EX)
	begin
		ID_EX = 1'b0;
		all = 1'b0;

	end
	
	if(stall_EX_MEM && !EX_MEM)
	begin
		_stall_EX_MEM = _stall_EX_MEM + 1'b1;
		EX_MEM = 1'b1;
	end
	
	else if(!stall_EX_MEM)
	begin
		EX_MEM = 1'b0;
		all = 1'b0;
	end
	
	if(stall_MEM_WB && !MEM_WB)
	begin
		_stall_MEM_WB = _stall_MEM_WB + 1'b1;
		MEM_WB = 1'b1;
	end
	else if(!stall_MEM_WB)
	begin
		MEM_WB = 1'b1;
		all = 1'b0;
	end
	
	if(IF_ID && ID_EX && EX_MEM && MEM_WB & !all)
	begin
		stall_all = stall_all + 1'b1;
		all = 1'b1;
	end
	
	if(IF_ID && !ID_EX && !EX_MEM && !MEM_WB && !PC_IFID)
	begin
		stall_PC_IFID = stall_PC_IFID + 1'b1;
		PC_IFID = 1'b1;
	end
	/* READ/WRITE */
	
	if(counter == 4'b0000)
	begin
		if(MMIO_write)
			Icache_miss = 4'h0000;
	end
	/* ICACHE HIT */
	else if(counter == 4'b0001)
	begin
		if(MMIO_write)
			Icache_hit = 4'h0000;
	end
	/* DCACHE MISS */
	else if(counter == 4'b0010)
	begin
		if(MMIO_write)
			Dcache_miss = 4'h0000;
	end
	
	/* DCACHE HIT */
	else if(counter == 4'b0011)
	begin
		if(MMIO_write)
			Dcache_hit = 4'h0000;
	end
	
	/* L2CACHE MISS */
	else if(counter == 4'b0100)
	begin
		if(MMIO_write)
			L2cache_miss = 4'h0000;

	end
	/* L2CACHE HIT */
	else if(counter == 4'b0101)
	begin
		if(MMIO_write)
			L2cache_hit = 4'h0000;
	end
	
	/* TOTAL BRANCH */
	else if(counter == 4'b0110)
	begin
		if(MMIO_write)
			total_branch = 4'h0000;
	end
	
	/*BRANCH TAKEN */
	else if(counter == 4'b0111)
	begin
		if(MMIO_write)
			branch_taken = 4'h0000;
	end
	/*BRANCH NOT TAKEN */
	else if(counter == 4'b1000)
	begin
		if(MMIO_write)
			branch_not_taken = 4'h0000;
	end
	
	/* STALL ALL */
	else if(counter == 4'b1001)
	begin
		if(MMIO_write)
			stall_all = 4'h0000;
	end
	
	/* STALL PCIFID */
	else if(counter == 4'b1010)
	begin
		if(MMIO_write)
			stall_PC_IFID = 4'h0000;
		
	end
	
end

always_comb
begin
	counter_out = 4'h0000;
	
	/* ICACHE MISS */
	if(counter == 4'b0000)
			counter_out = Icache_miss;

	/* ICACHE HIT */
	else if(counter == 4'b0001)
			counter_out = Icache_hit;
	/* DCACHE MISS */
	else if(counter == 4'b0010)
			counter_out = Dcache_miss;
	/* DCACHE HIT */
	else if(counter == 4'b0011)
			counter_out = Dcache_hit;

	/* L2CACHE MISS */
	else if(counter == 4'b0100)
			counter_out = L2cache_miss;

	/* L2CACHE HIT */
	else if(counter == 4'b0101)
			counter_out = L2cache_hit;

	/* TOTAL BRANCH */
	else if(counter == 4'b0110)
			counter_out = total_branch;

	/*BRANCH TAKEN */
	else if(counter == 4'b0111)
			counter_out = branch_taken;

	/*BRANCH NOT TAKEN */
	else if(counter == 4'b1000)
			counter_out = branch_not_taken;

	/* STALL ALL */
	else if(counter == 4'b1001)
			counter_out = stall_all;

	/* STALL PCIFID */
	else if(counter == 4'b1010)
			counter_out = stall_PC_IFID;

end

endmodule : Memory_Mapped_IO