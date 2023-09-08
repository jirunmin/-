module VendingMachineController (
    input wire clk,                   // 输入时钟信号
    input wire coin_insert_button,    // 输入硬币插入按钮信号
    input wire confirm_button,        // 输入确认按钮信号
    input wire [7:0] coin_value,       
    output reg [7:0] coin_total,
    input wire [7:0] product_price,  
    input wire confirm_flag,  
    input wire alarm_flag,
    input wire sales_flag,
    input wire [3:0] bussines_flag,
    output reg alarm,                 // 输出报警信号
    output reg [7:0] change,          // 输出找零信号
    output reg [3:0] product_dispensed,      // 输出产品发放信号
    output reg [7:0] total_sales
    
    
);

reg [1:0] state = 2'b00;              // 控制状态机状态的寄存器
reg [7:0] coin_temp = 8'd0;


always @(posedge clk) begin
	if(sales_flag) begin
		total_sales <= 8'd0;
	end
	
	if(!bussines_flag) begin
    case (state)
        2'b00: begin // 初始状态
			product_dispensed <= 4'b0000;
			change <= 8'd0;
            if (coin_insert_button) begin
				
                state <= 2'b01; // 进入硬币插入状态
                //coin_total <= coin_value; // 记录插入的硬币金额
            end
        end

        2'b01: begin // 硬币插入状态
            if (coin_insert_button) begin
				if(coin_temp != coin_value) begin
					coin_temp <= coin_value;
					coin_total <= coin_total + coin_value; // 累加硬币金额
				end
            end
            if (confirm_button) begin
                if (coin_total >= product_price) begin
                    total_sales <= total_sales + product_price; // 更新总销售额
                    change <= coin_total - product_price; // 计算找零
                    case(product_price)
						8'd1: product_dispensed <= 4'b0001; 
						8'd2: product_dispensed <= 4'b0010;
						8'd5: product_dispensed <= 4'b0100;  
						8'd10: product_dispensed <= 4'b1000;
					endcase 
                    state <= 2'b10; // 切换到成功状态
                end else begin
					change <= coin_total;
                    alarm <= 1'b1; // 启动报警
                    state <= 2'b11; // 切换到报警状态
                end
            end
        end
        2'b10: begin // 成功状态
			coin_total <= 0; // 清零投币总额
            if ((!confirm_button) | confirm_flag) begin
                
                state <= 2'b00; // 返回初始状态
            end
        end
        2'b11: begin // 报警状态
			coin_total <= 0;
            if ((!confirm_button) | alarm_flag) begin
				
                alarm <= 1'b0; // 关闭报警
                state <= 2'b00; // 返回初始状态
            end
        end
    endcase
    end
    else begin
		coin_total <= 8'd0;
		change <= 8'd0;
		total_sales <= 8'd0;
	end
end

endmodule
