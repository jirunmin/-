module VendingMachineController (
    input wire clk,                   // 输入时钟信号
    input wire coin_insert_button,    // 输入硬币插入按钮信号
    input wire confirm_button,        // 输入确认按钮信号
    input wire [3:0] coin_code,       // 输入硬币代码
    input wire [7:0] product_price,    // 输入产品代码
    output reg alarm,                 // 输出报警信号
    output reg [3:0] change,          // 输出找零信号
    output reg product_dispensed,      // 输出产品发放信号
    output reg [1:0] state,
    output reg [7:0] total_sales
);

//reg [3:0] total_sales = 0;            // 记录总销售额
reg [3:0] coin_total = 0;             // 记录投币总额
//reg [1:0] state = 2'b00;              // 控制状态机状态的寄存器
//total_sales = 0;


always @(posedge clk) begin
    case (state)
        2'b00: begin // 初始状态
            if (coin_insert_button) begin
				product_dispensed <= 1'b0;
                state <= 2'b01; // 进入硬币插入状态
                coin_total <= coin_code; // 记录插入的硬币金额
            end
        end

                2'b01: begin // 硬币插入状态
            if (coin_insert_button) begin
                coin_total <= coin_total + coin_code; // 累加硬币金额
            end
            if (confirm_button) begin
                if (coin_total >= product_price) begin
                    total_sales <= total_sales + product_price; // 更新总销售额
                    change <= coin_total - product_price; // 计算找零
                    product_dispensed <= 1'b1; // 发放产品
                    state <= 2'b10; // 切换到成功状态
                end else begin
                    alarm <= 1'b1; // 启动报警
                    state <= 2'b11; // 切换到报警状态
                end
            end
        end
        2'b10: begin // 成功状态
            if (confirm_button) begin
                coin_total <= 0; // 清零投币总额
                state <= 2'b00; // 返回初始状态
            end
        end
        2'b11: begin // 报警状态
            if (!confirm_button) begin
                alarm <= 1'b0; // 关闭报警
                state <= 2'b00; // 返回初始状态
            end
        end
    endcase
end

endmodule
