module VendingMachine (
    input wire clk,                           // 输入时钟信号
    input wire reset_button,                  // 输入复位按钮信号
    input wire coin_insert_button,            // 输入硬币插入按钮信号
    input wire confirm_button,                // 输入确认按钮信号
    input wire [3:0] coin_code,               // 输入硬币代码
    input wire [3:0] product_code,            // 输入产品代码
    input wire rst_n,
    output wire alarm,                        // 输出报警信号
    output wire [3:0] change_amount,          // 输出找零金额
    output wire product_dispensed,            // 输出产品发放信号
    output wire [3:0] sales_total,            // 输出销售总额
    output wire [3:0] cleared_sales_total,     // 输出已清零销售总额
    output wire [6:0] display_segments,       // 输出用于数码管显示的段
    output wire [3:0] initialized_value,       // 输出初始化值
    output wire dt_zero							// set dotpoint
);

assign dt_zero = 1'b1;
wire [3:0] coin_total;                        // 用于记录硬币总额
wire [3:0] cleared_total;                     // 用于记录已清零销售总额
wire clk_1Hz;

clk_1hz clk1(clk,rst_n,clk_1Hz);

ClockDivider clock_divider (.clk(clk), .sec_pulse()); // 时钟分频器模块

CoinDetector coin_detector (.coin_input(coin_code), .coin_code(coin_total)); // 硬币检测器模块

SalesTotalReset sales_total_reset (            // 销售总额重置模块
    .reset_button(reset_button),
    .clear_sales(confirm_button),
    .sales_total(sales_total),
    .cleared_total(cleared_total)
);

VendingMachineController controller (          // 自动售货机控制器模块
    .clk(clk),
    .coin_insert_button(coin_insert_button),
    .confirm_button(confirm_button),
    .coin_code(coin_code),
    .product_code(product_code),
    .alarm(alarm),
    .change(change_amount),
    .product_dispensed(product_dispensed)
);

DisplayModule display (                        // 显示模块
    .value_to_display(product_code),
    .display_segments(display_segments)
);

InitializeModule initializer (                  // 初始化模块
    .initialize_button(reset_button),
    .initialized_value(initialized_value)
);

/*
ChangeModule change_calculator (                // 找零计算模块 (已注释掉)
    .total_amount(coin_total),
    .product_price(product_code),
    .change_amount(change_amount)
);
*/

endmodule
