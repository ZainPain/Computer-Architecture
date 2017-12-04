import lc3b_types::*;

module victim_array #(parameter width = 128)

(
    input clk,
    input write,
    input [3:0] index,
    input [width-1:0] datain,
    output logic [width-1:0] dataout [15:0]
);

logic [width-1:0] data [15:0];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data[index] = datain;
    end

end

assign dataout = data;

endmodule : victim_array
/*
import lc3b_types::*;

module victim_array #(parameter width = 128)

(
    input clk,
    input write,
    input [width-1:0] datain,
    output logic [width-1:0] dataout
);

// onel ine for victim
logic [width-1:0] data;

initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data = datain;
    end

end

assign dataout = data;

endmodule : victim_array
*/
