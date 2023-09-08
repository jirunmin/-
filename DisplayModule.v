module DisplayModule (
    input wire [7:0] value_to_display, // ����Ҫ��ʾ��ֵ
    output wire [13:0] display_segments // �������ܶ�ѡ�ź�
);

wire [3:0] ones;
wire [3:0] tens;

assign ones = value_to_display % 100 % 10;
assign tens = value_to_display % 100 / 10;

reg [6:0] seven_segment_map [0:9]; // �����߶�����ܱ���ӳ�����飬��0��9


assign display_segments = {seven_segment_map[tens], seven_segment_map[ones]}; // ������ֵӳ�䵽����ܱ��벢���

endmodule
/*
���ģ��������Ǹ��������ֵ����Ӧ���߶�����ܱ���ӳ�䵽����˿�,
�Ա������������ʾ�����ֵ���߶�����ܱ���洢�� seven_segment_map �����У�����������ֵ 
value_to_display ���в��ҡ��ҵ���Ӧ�ı���󣬽��丳ֵ�� display_segments ����źţ��Ա������������ʾ��
���ģ�������������ʾ�������������ֵת��Ϊ�߶�����ܵ���ʾ��

*/