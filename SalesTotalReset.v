module SalesTotalReset (
    input wire reset_button,       // 输入的复位按钮信号
    input wire clear_sales,       // 输入的清零销售额信号
    input wire [3:0] sales_total, // 输入的销售总额
    output wire [3:0] cleared_total // 输出已清零销售总额
);

reg [3:0] total = 0; // 内部寄存器，用于存储销售总额的值，初始值为零

always @(posedge reset_button or posedge clear_sales) begin
    if (reset_button)
        total <= 0; // 当复位按钮按下时，将销售总额清零
    if (clear_sales)
        total <= sales_total; // 当清零销售额信号有效时，将销售总额设置为输入的销售总额
end

assign cleared_total = total; // 将已清零的销售总额赋给输出端口

endmodule
/*
模块的作用是根据复位按钮信号和清零销售额信号来控制销售总额的复位和清零操作。
它通过一个内部寄存器 total 来存储销售总额的值，根据输入的信号状态来更新 total 的值。
当复位按钮按下时，total 被清零，当清零销售额信号有效时，total 被设置为输入的销售总额。最后，
已清零的销售总额被赋给输出端口 cleared_total。这个模块有助于管理销售总额的复位和清零操作。
*/