module VendingMachine (
    input wire clk,                           // ����ʱ���ź�
    input wire reset_button,                  // ���븴λ��ť�ź�
    input wire coin_insert_button,            // ����Ӳ�Ҳ��밴ť�ź�
    input wire confirm_button,                // ����ȷ�ϰ�ť�ź�
    input wire [3:0] coin_code,               // ����Ӳ�Ҵ���
    input wire [3:0] product_code,            // �����Ʒ����
    input wire rst_n,
    
    output wire alarm,                        // ��������ź�
    output wire [3:0] change_amount,          // ���������
    output wire product_dispensed,            // �����Ʒ�����ź�
    output wire [3:0] sales_total,            // ��������ܶ�
    output wire [3:0] cleared_sales_total,     // ��������������ܶ�
    
    output wire [13:0] display_segments,       // ��������������ʾ�Ķ�
    output wire [13:0] display_segments_code,
    
    output wire [3:0] initialized_value,       // �����ʼ��ֵ
    output wire [7:0] dt_zero,							// set dotpoint
    output wire [1:0] state,
    output reg [6:0] seg,
    output reg [3:0] q,
    output wire [7:0] total_sales
);

assign dt_zero = 8'hff;
//assign state = 2'b00;

wire [3:0] coin_total;                        // ���ڼ�¼Ӳ���ܶ�
wire [3:0] cleared_total;                     // ���ڼ�¼�����������ܶ�
wire clk_1Hz;

wire [7:0] product_price;
wire [7:0] coin_value;

Product_codetoprice(.clk(clk),.product_code(product_code), .product_price(product_price));

CoinDetector coin_detector (.clk(clk),.coin_code(coin_code), .coin_value(coin_value)); // Ӳ�Ҽ����ģ��

clk_1hz clk1(clk,rst_n,clk_1Hz);

always @(posedge clk_1Hz or negedge rst_n)
begin
   if(~rst_n) q <= 4'h0;
   else
   begin
      if(4'h9 == q) q <= 4'h0;
      else q <= q + 4'h1;
   end
end

always @(q)
         case(q)
             4'h0: seg = ~7'h3F;
             4'h1: seg = ~7'h06;     // - a(0)--
             4'h2: seg = ~7'h5B;     // |      |
             4'h3: seg = ~7'h4F;     // f      b(1)
             4'h4: seg = ~7'h66;     // |      |
             4'h5: seg = ~7'h6D;     // ---g----
             4'h6: seg = ~7'h7D;     // |      |
             4'h7: seg = ~7'h07;     // e      c(2)
             4'h8: seg = ~7'h7F;     // |      |
             4'h9: seg = ~7'h67;     // ---d----
             4'ha: seg = ~7'h77;
             4'hb: seg = ~7'h7C;
             4'hc: seg = ~7'h39;
             4'hd: seg = ~7'h5E;
             4'he: seg = ~7'h79;
             4'hf: seg = ~7'h71;
         endcase





//ClockDivider clock_divider (.clk(clk), .sec_pulse()); // ʱ�ӷ�Ƶ��ģ��



SalesTotalReset sales_total_reset (            // �����ܶ�����ģ��
    .reset_button(reset_button),
    .clear_sales(confirm_button),
    .sales_total(sales_total),
    .cleared_total(cleared_total)
);

VendingMachineController controller (          // �Զ��ۻ���������ģ��
    .clk(clk),
    .coin_insert_button(coin_insert_button),
    .confirm_button(confirm_button),
    .coin_value(coin_value),
    .product_price(product_price),
    .alarm(alarm),
    .change(change_amount),
    .product_dispensed(product_dispensed),
    .state(state),
    .total_sales(total_sales)
);

DisplayModule display (                        // ��ʾģ��
    .value_to_display(product_price),
    .display_segments(display_segments)
);

DisplayModule display_1 (                        // ��ʾģ��
    .value_to_display(coin_value),
    .display_segments(display_segments_code)
);

InitializeModule initializer (                  // ��ʼ��ģ��
    .initialize_button(reset_button),
    .initialized_value(initialized_value)
);

/*
ChangeModule change_calculator (                // �������ģ�� (��ע�͵�)
    .total_amount(coin_total),
    .product_price(product_code),
    .change_amount(change_amount)
);
*/

endmodule
