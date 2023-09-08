module VendingMachine (
    input wire clk,                           // ����ʱ���ź�
    input wire reset_button,                  // ���븴λ��ť�ź�
    input wire coin_insert_button,            // ����Ӳ�Ҳ��밴ť�ź�
    input wire confirm_button,                // ����ȷ�ϰ�ť�ź�
    input wire [3:0] coin_code,               // ����Ӳ�Ҵ���
    input wire [3:0] product_code,            // �����Ʒ����
    input wire rst_n,
    input wire business,

    
    output wire alarm,                        // ��������ź�
    output wire product_dispensed,            // �����Ʒ�����ź�
    
    output wire [13:0] display_segments,       // ��������������ʾ�Ķ�
    output wire [13:0] display_segments_code,
    output wire [13:0] display_change,			
    output wire [13:0] display_sellingAmount,
    
    
    output wire [3:0] initialized_value,       // �����ʼ��ֵ
    output wire [7:0] dt_zero						
);

assign dt_zero = 8'hff;

wire [3:0] cleared_total;                     // ���ڼ�¼�����������ܶ�
wire clk_1Hz;

wire [7:0] product_price;
wire [7:0] coin_value;
wire [7:0] coin_total;
wire [7:0] change_amount;          // ������
wire [7:0] sales_total;            // ��������ܶ�

wire confirm_flag;
wire alarm_flag;
wire sales_flag;
wire bussines_flag;


clk_1hz clk1(clk,rst_n,clk_1Hz);

Product_codetoprice(.clk(clk),.product_code(product_code), .product_price(product_price));

CoinDetector coin_detector (.clk(clk),.coin_code(coin_code), .coin_value(coin_value)); // Ӳ�Ҽ����ģ��





TotalZero(
	.clk(clk),
	.zero_button(reset_button),
	.sales_total_flag(sales_flag)
);



SecondsDetector(.clk(clk_1Hz), .startflag(confirm_button), .secondsflag(confirm_flag));

SecondsDetector(.clk(clk_1Hz), .startflag(alarm), .secondsflag(alarm_flag));

VendingMachineController controller (          // �Զ��ۻ���������ģ��
    .clk(clk),
    .coin_insert_button(coin_insert_button),
    .confirm_button(confirm_button),
    .coin_value(coin_value),
	.coin_total(coin_total),
    .product_price(product_price),
    .alarm(alarm),
    .change(change_amount),
    .product_dispensed(product_dispensed),
    .total_sales(sales_total),
    .confirm_flag(confirm_flag),
    .alarm_flag(alarm_flag),
    .sales_flag(sales_flag),
    .bussines_flag(bussines_flag)
);

DisplayModule display (                        // ��ʾģ��
    .value_to_display(product_price),
    .display_segments(display_segments)
);

DisplayModule display_1 (                        // ��ʾģ��
    .value_to_display(coin_total),
    .display_segments(display_segments_code)
);

DisplayModule display_2 (                        // ��ʾģ��
    .value_to_display(change_amount),
    .display_segments(display_change)
);



DisplayModule display_3 (                        // ��ʾģ��
    .value_to_display(sales_total),
    .display_segments(display_sellingAmount)
);

InitializeModule initializer (                  // ��ʼ��ģ��
	.clk(clk),
    .initialize_button(business),
    .bussines_flag(bussines_flag)
);

endmodule
