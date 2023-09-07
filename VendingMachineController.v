module VendingMachineController (
    input wire clk,                   // ����ʱ���ź�
    input wire coin_insert_button,    // ����Ӳ�Ҳ��밴ť�ź�
    input wire confirm_button,        // ����ȷ�ϰ�ť�ź�
    input wire [7:0] coin_value,       
    output reg [7:0] coin_total,
    input wire [7:0] product_price,  
    input wire confirm_flag,  
    input wire alarm_flag,
    output reg alarm,                 // ��������ź�
    output reg [7:0] change,          // ��������ź�
    output reg product_dispensed,      // �����Ʒ�����ź�
    output reg [7:0] total_sales
    
);

reg [1:0] state = 2'b00;              // ����״̬��״̬�ļĴ���
reg [7:0] coin_temp = 8'd0;


always @(posedge clk) begin
    case (state)
        2'b00: begin // ��ʼ״̬
            if (coin_insert_button) begin
				product_dispensed <= 1'b0;
                state <= 2'b01; // ����Ӳ�Ҳ���״̬
                //coin_total <= coin_value; // ��¼�����Ӳ�ҽ��
            end
        end

        2'b01: begin // Ӳ�Ҳ���״̬
            if (coin_insert_button) begin
				if(coin_temp != coin_value) begin
					coin_temp <= coin_value;
					coin_total <= coin_total + coin_value; // �ۼ�Ӳ�ҽ��
				end
            end
            if (confirm_button) begin
                if (coin_total >= product_price) begin
                    total_sales <= total_sales + product_price; // ���������۶�
                    change <= coin_total - product_price; // ��������
                    product_dispensed <= 1'b1; // ���Ų�Ʒ
                    state <= 2'b10; // �л����ɹ�״̬
                end else begin
                    alarm <= 1'b1; // ��������
                    state <= 2'b11; // �л�������״̬
                end
            end
        end
        2'b10: begin // �ɹ�״̬
            if (confirm_flag) begin
                coin_total <= 0; // ����Ͷ���ܶ�
                state <= 2'b00; // ���س�ʼ״̬
            end
        end
        2'b11: begin // ����״̬
            if (!confirm_button | alarm_flag) begin
                alarm <= 1'b0; // �رձ���
                state <= 2'b00; // ���س�ʼ״̬
            end
        end
    endcase
end

endmodule
