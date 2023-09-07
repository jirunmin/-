module CoinDetector (
	input wire clk,
    input wire [3:0] coin_code, // ����Ӳ���źţ����ڼ��Ӳ������
    output reg [7:0] coin_value  // ���Ӳ�ұ��룬��ʾ��⵽��Ӳ������
);

//assign coin_code = coin_input; // ֱ�ӽ�Ӳ�������źŸ��Ƶ�Ӳ�ұ�������ź�


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

�����Ӳ���ź�ֱ�Ӹ��Ƶ�Ӳ�ұ�������źţ����ڽ�Ӳ��������Ϣ���ݸ�����ģ�顣
�����û�н����κ�Ӳ�����͵ļ������ת����ֻ�Ǽ򵥵ؽ������źŴ��ݵ�����˿ڣ�
�Թ�����ģ��ʹ�á����ģ����Ը��ݾ����Ӳ�Ҽ�����������չ��
*/