module DisplayModule (
    input wire [7:0] value_to_display, // 输入要显示的值
    output wire [13:0] display_segments // 输出数码管段选信号
);

wire [3:0] ones;
wire [3:0] tens;

assign ones = value_to_display % 100 % 10;
assign tens = value_to_display % 100 / 10;

reg [6:0] seven_segment_map [0:9]; // 定义七段数码管编码映射数组，从0到9


assign display_segments = {seven_segment_map[tens], seven_segment_map[ones]}; // 将输入值映射到数码管编码并输出

endmodule
/*
这个模块的作用是根据输入的值将相应的七段数码管编码映射到输出端口,
以便在数码管上显示输入的值。七段数码管编码存储在 seven_segment_map 数组中，并根据输入值 
value_to_display 进行查找。找到相应的编码后，将其赋值给 display_segments 输出信号，以便在数码管上显示。
这个模块用于数码管显示，将输入的数字值转化为七段数码管的显示。

*/