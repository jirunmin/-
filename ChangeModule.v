module ChangeModule (
    input wire [3:0] total_amount,    // 输入总金额
    input wire [3:0] product_price,   // 输入产品价格
    output wire [3:0] change_amount   // 输出找零金额
);

assign change_amount = total_amount - product_price; // 计算找零金额

endmodule
/*

作用是计算出找零金额，它通过将输入的产品价格从总金额中减去来实现。
输入的总金额和产品价格分别通过 total_amount 和 product_price 输入信号传递给�
模块执行减法运算，将结果赋值给 change_amount 输出信号
*/