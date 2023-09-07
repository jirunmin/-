module ClockDivider (
    input wire clk,          // 输入时钟信号
    output wire sec_pulse    // 输出秒脉冲信号
);

reg [24:0] counter = 0;     // 内部寄存器，用于计数时钟周期

always @(posedge clk) begin
    if (counter == 25000000) // 假设使用50 MHz时钟，计数到25000000表示1秒脉冲
        counter <= 0;       // 计数达到最大值后复位为0
    else
        counter <= counter + 1; // 在每个时钟周期增加计数值
end

assign sec_pulse = (counter == 25000000); // 当计数达到25000000时，产生1秒脉冲

endmodule
/*

作用是将高速输入时钟信号分频为1秒脉冲信号。
它通过一个内部寄存器 counter 来计数时钟周期，当计数达到特定值（假设50 MHz时钟下为25000000）时，
产生一个1秒脉冲信号 sec_pulse。这个模块可以用于同步操作，例如在某些应用中需要每秒触发一次操作时非常有用。
*/