module InitializeModule (
	input wire clk,
    input wire initialize_button,       // ����ĳ�ʼ����ť�ź�
    output reg bussines_flag
);

always @(posedge clk) begin
	if(initialize_button) bussines_flag <= 1'd1;
	else bussines_flag <= 1'd0;
end

endmodule
