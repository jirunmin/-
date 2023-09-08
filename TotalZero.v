module TotalZero (
	input wire clk,
    input wire zero_button,       
    output reg sales_total_flag 
);


always @(posedge clk) begin
	if(zero_button)	sales_total_flag <= 1'd1;   
	else sales_total_flag <= 1'd0;        
end


endmodule
