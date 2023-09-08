module InitializeModule (
	input wire clk,
    input wire initialize_button,       // 输入的初始化按钮信号
    output reg bussines_flag
);

always @(posedge clk) begin
	if(initialize_button) bussines_flag <= 1'd1;
	else bussines_flag <= 1'd0;
end

endmodule
