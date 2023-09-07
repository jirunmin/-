module DisplayModule (
    input wire [7:0] value_to_display, // ����Ҫ��ʾ��ֵ
    output wire [13:0] display_segments // �������ܶ�ѡ�ź�
);

wire [3:0] ones;
wire [3:0] tens;

assign ones = value_to_display % 100 % 10;
assign tens = value_to_display % 100 / 10;

reg [6:0] seven_segment_map [0:9]; // �����߶�����ܱ���ӳ�����飬��0��9

initial begin
    seven_segment_map[0] = ~7'h3F;  // �������ʾ0�ı���
    seven_segment_map[1] = ~7'h06;  // �������ʾ1�ı���
    seven_segment_map[2] = ~7'h5B;  // �������ʾ2�ı���
    seven_segment_map[3] = ~7'h4F;  // �������ʾ3�ı���
    seven_segment_map[4] = ~7'h66;  // �������ʾ4�ı���
    seven_segment_map[5] = ~7'h6D;  // �������ʾ5�ı���
    seven_segment_map[6] = ~7'h7D;  // �������ʾ6�ı���
    seven_segment_map[7] = ~7'h07;  // �������ʾ7�ı���
    seven_segment_map[8] = ~7'h7F;  // �������ʾ8�ı���
    seven_segment_map[9] = ~7'h67;  // �������ʾ9�ı���
end

assign display_segments = {seven_segment_map[tens], seven_segment_map[ones]}; // ������ֵӳ�䵽����ܱ��벢���

endmodule
/*
���ģ��������Ǹ��������ֵ����Ӧ���߶�����ܱ���ӳ�䵽����˿�,
�Ա������������ʾ�����ֵ���߶�����ܱ���洢�� seven_segment_map �����У�����������ֵ 
value_to_display ���в��ҡ��ҵ���Ӧ�ı���󣬽��丳ֵ�� display_segments ����źţ��Ա������������ʾ��
���ģ�������������ʾ�������������ֵת��Ϊ�߶�����ܵ���ʾ��

*/