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
    output wire [6:0] display_segments,       // ��������������ʾ�Ķ�
    output wire [3:0] initialized_value,       // �����ʼ��ֵ
    output wire dt_zero							// set dotpoint
);

assign dt_zero = 1'b1;
wire [3:0] coin_total;                        // ���ڼ�¼Ӳ���ܶ�
wire [3:0] cleared_total;                     // ���ڼ�¼�����������ܶ�
wire clk_1Hz;

clk_1hz clk1(clk,rst_n,clk_1Hz);

ClockDivider clock_divider (.clk(clk), .sec_pulse()); // ʱ�ӷ�Ƶ��ģ��

CoinDetector coin_detector (.coin_input(coin_code), .coin_code(coin_total)); // Ӳ�Ҽ����ģ��

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
    .coin_code(coin_code),
    .product_code(product_code),
    .alarm(alarm),
    .change(change_amount),
    .product_dispensed(product_dispensed)
);

DisplayModule display (                        // ��ʾģ��
    .value_to_display(product_code),
    .display_segments(display_segments)
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
