module Product_codetoprice (
	input wire clk,
    input wire [3:0] product_code,    // 输入产品代码
    output reg [7:0] product_price
);


always @(posedge clk) begin
    case (product_code)
        4'b0001: begin 
            product_price = 8'd1;
        end

        4'b0010: begin 
            product_price = 8'd2;
        end
        4'b0100: begin 
            product_price = 8'd5;
        end
        4'b1000: begin 
            product_price = 8'd10;
        end
        default: begin
			product_price = 8'd0;
        end
    endcase
end

endmodule
