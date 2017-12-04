import lc3b_types::*;

module btb
(
	input clk,

	/* BTB lookup */
	input lc3b_word pc,
	input logic branch_prediction,

	output lc3b_word updated_pc,
  output logic speculatively_taken,

	/* BTB update */
	input logic branch_taken,
	input logic unconditional_branch,
	input lc3b_word branch_taken_pc,
	input lc3b_word branch_taken_target,
  output logic incorrect_target
);

lc3b_word [15:0] btb_pc;
lc3b_word [15:0] btb_target;
logic [15:0] unconditional;
logic [15:0] valid;
//logic no_match;
logic [15:0] match;
logic exists;
logic [3:0] eviction_line;
logic [3:0] hit;
logic [3:0] update_index;
logic lru_update;

logic unconditional_buffer;
logic branch_taken_buffer;
lc3b_word branch_taken_pc_buffer;
lc3b_word branch_taken_target_buffer;

initial
begin
	valid = 16'b0;
	unconditional = 16'b0;
  for (int i = 0; i < $size(btb_pc); i++)
  begin
        btb_pc[i] = 16'b0;
        btb_target[i] = 16'b0;
  end
end

always_comb
begin
  match = 16'b0;
  exists = 0;
  speculatively_taken = 0;
  hit = 0;
  updated_pc = 16'b0;
  incorrect_target = 0;
  update_index = 0;
  
  for (int i = 0; i < $size(btb_pc); i++)
  begin
    if((btb_pc[i] == pc) && valid[i] && (branch_prediction || unconditional[i])) begin
      match[i] = 1'b1;
      hit = i[3:0];
    end

    if((btb_pc[i] == branch_taken_pc) && valid[i] && (btb_target[i] == branch_taken_target))
      exists = 1'b1;
    
    if((btb_pc[i] == branch_taken_pc) && valid[i] && (btb_target[i] != branch_taken_target)) begin
      incorrect_target = 1'b1;
      update_index = i[3:0];
    end
  end

  if (match == 0)
    hit = eviction_line;

  if(match[hit]) begin
    updated_pc = btb_target[hit];
    speculatively_taken = 1'b1;
  end

  lru_update = match[hit] || (branch_taken && (!exists || incorrect_target));

	unconditional_buffer = unconditional_branch;
  branch_taken_buffer = branch_taken;
  branch_taken_target_buffer = branch_taken_target;
  branch_taken_pc_buffer = branch_taken_pc;

end

always_ff @(negedge clk)
begin
	//no_match = match && 1'b1;
  if (branch_taken_buffer && !incorrect_target && !exists) begin
  	btb_pc[eviction_line] <= branch_taken_pc_buffer;
  	btb_target[eviction_line] <= branch_taken_target_buffer;
		unconditional[eviction_line] <= unconditional_buffer;
		valid[eviction_line] <= 1;
  end
  
  if (branch_taken_buffer && incorrect_target) begin
    btb_target[update_index] <= branch_taken_target_buffer;
  end
  
end

pseudo_lru_16_way lru
(
	.clk(clk),
	.load(lru_update),
	.hit(hit),
	.dataout(eviction_line)
);

endmodule : btb
