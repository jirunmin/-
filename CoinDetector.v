module CoinDetector (
	input wire clk,
    input wire [3:0] coin_code, // 输入硬币信号，用于检测硬币类型
    output reg [7:0] coin_value  // 输出硬币编码，表示检测到的硬币类型
);

//assign coin_code = coin_input; // 直接将硬币输入信号复制到硬币编码输出信号


always @(posedge clk) begin
    case (coin_code)
        4'b0001: begin 
            coin_value = 8'd1;
        end

        4'b0010: begin 
            coin_value = 8'd2;
        end
        4'b0100: begin 
            coin_value = 8'd5;
        end
        4'b1000: begin 
            coin_value = 8'd10;
        end
        default: begin
			coin_value = 8'd0;
        end
    endcase
end

endmodule

/*

输入的硬币信号直接复制到硬币编码输出信号，用于将硬币类型信息传递给其他模块。
在这里，没有进行任何硬币类型的检测或编码转换，只是简单地将输入信号传递到输出端口，
以供其他模块使用。这个模块可以根据具体的硬币检测需求进行扩展。
*/