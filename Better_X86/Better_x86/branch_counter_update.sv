import lc3b_types::*;

module branch_counter_update
(
	input [1:0] prediction,		// prediction from pht
	input actual_decision,		// actual decision from branch instruction
	input [9:0]index,			// index to modify corresponding counter in pht
	input lc3b_opcode opcode,
  input lc3b_reg nzp,
	output logic [1:0] counter,		// updated value to store back into instruction
	output logic update,					// signal tells pht entry to update counter
	output logic [9:0]index_out

);

always_comb
begin
	index_out = index;
	
	update = 1'b0;	//only update counter if the counter does not violate boundary conditions of 00 or 11
	counter = prediction;

  if(opcode == op_br && (nzp[2] || nzp[1] || nzp[0]))
    begin
    if(actual_decision)	//if branch taken
    begin
    

      if(prediction != 2'b11)
      begin
        counter = prediction + 2'b01;
        update = 1'b1;
      end
    end

    else if(!actual_decision) 	// if branch not taken
    begin

      if(prediction != 2'b00)	
      begin
        counter = prediction - 2'b01;
        update = 1'b1;
      end
    end
	
  end
end

endmodule : branch_counter_update