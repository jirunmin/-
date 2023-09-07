module DisplayModule (
    input wire [7:0] value_to_display, // 输入要显示的值
    output wire [13:0] display_segments // 输出数码管段选信号
);

wire [3:0] ones;
wire [3:0] tens;

assign ones = value_to_display % 100 % 10;
assign tens = value_to_display % 100 / 10;

reg [6:0] seven_segment_map [0:9]; // 定义七段数码管编码映射数组，从0到9

initial begin
    seven_segment_map[0] = ~7'h3F;  // 数码管显示0的编码
    seven_segment_map[1] = ~7'h06;  // 数码管显示1的编码
    seven_segment_map[2] = ~7'h5B;  // 数码管显示2的编码
    seven_segment_map[3] = ~7'h4F;  // 数码管显示3的编码
    seven_segment_map[4] = ~7'h66;  // 数码管显示4的编码
    seven_segment_map[5] = ~7'h6D;  // 数码管显示5的编码
    seven_segment_map[6] = ~7'h7D;  // 数码管显示6的编码
    seven_segment_map[7] = ~7'h07;  // 数码管显示7的编码
    seven_segment_map[8] = ~7'h7F;  // 数码管显示8的编码
    seven_segment_map[9] = ~7'h67;  // 数码管显示9的编码
end

assign display_segments = {seven_segment_map[tens], seven_segment_map[ones]}; // 将输入值映射到数码管编码并输出

endmodule
/*
这个模块的作用是根据输入的值将相应的七段数码管编码映射到输出端口,
以便在数码管上显示输入的值。七段数码管编码存储在 seven_segment_map 数组中，并根据输入值 
value_to_display 进行查找。找到相应的编码后，将其赋值给 display_segments 输出信号，以便在数码管上显示。
这个模块用于数码管显示，将输入的数字值转化为七段数码管的显示。

*/