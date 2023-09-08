module VendingMachine (
    input wire clk,                           // 输入时钟信号
    input wire reset_button,                  // 输入复位按钮信号
    input wire coin_insert_button,            // 输入硬币插入按钮信号
    input wire confirm_button,                // 输入确认按钮信号
    input wire [3:0] coin_code,               // 输入硬币代码
    input wire [3:0] product_code,            // 输入产品代码
    input wire rst_n,
    input wire business,

    
    output wire alarm,                        // 输出报警信号
    output wire product_dispensed,            // 输出产品发放信号
    
    output wire [13:0] display_segments,       // 输出用于数码管显示的段
    output wire [13:0] display_segments_code,
    output wire [13:0] display_change,			
    output wire [13:0] display_sellingAmount,
    
    
    output wire [3:0] initialized_value,       // 输出初始化值
    output wire [7:0] dt_zero						
);

assign dt_zero = 8'hff;

wire [3:0] cleared_total;                     // 用于记录已清零销售总额
wire clk_1Hz;

wire [7:0] product_price;
wire [7:0] coin_value;
wire [7:0] coin_total;
wire [7:0] change_amount;          // 找零金额
wire [7:0] sales_total;            // 输出销售总额

wire confirm_flag;
wire alarm_flag;
wire sales_flag;
wire bussines_flag;


clk_1hz clk1(clk,rst_n,clk_1Hz);

Product_codetoprice(.clk(clk),.product_code(product_code), .product_price(product_price));

CoinDetector coin_detector (.clk(clk),.coin_code(coin_code), .coin_value(coin_value)); // 硬币检测器模块





TotalZero(
	.clk(clk),
	.zero_button(reset_button),
	.sales_total_flag(sales_flag)
);



SecondsDetector(.clk(clk_1Hz), .startflag(confirm_button), .secondsflag(confirm_flag));

SecondsDetector(.clk(clk_1Hz), .startflag(alarm), .secondsflag(alarm_flag));

VendingMachineController controller (          // 自动售货机控制器模块
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

DisplayModule display (                        // 显示模块
    .value_to_display(product_price),
    .display_segments(display_segments)
);

DisplayModule display_1 (                        // 显示模块
    .value_to_display(coin_total),
    .display_segments(display_segments_code)
);

DisplayModule display_2 (                        // 显示模块
    .value_to_display(change_amount),
    .display_segments(display_change)
);



DisplayModule display_3 (                        // 显示模块
    .value_to_display(sales_total),
    .display_segments(display_sellingAmount)
);

InitializeModule initializer (                  // 初始化模块
	.clk(clk),
    .initialize_button(business),
    .bussines_flag(bussines_flag)
);

endmodule
