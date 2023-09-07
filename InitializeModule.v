module InitializeModule (
    input wire initialize_button,       // 输入的初始化按钮信号
    output wire [3:0] initialized_value // 输出初始化后的值
);

reg [3:0] initial_value = 4'b0000;     // 内部寄存器，用于存储初始化值，初始值为全零

always @(posedge initialize_button) begin
    initial_value <= 4'b0000;          // 当初始化按钮按下时，将初始化值设置为全零
end

assign initialized_value = initial_value; // 将初始化后的值赋给输出端口

endmodule
/*
模块的作用是在接收到初始化按钮信号后，将输出值设置为全零。它通过一个内部寄存器来存储初始化值，
当初始化按钮按下时，将寄存器的值设置为全零，并将这个值赋给输出端口 initialized_value。
*/