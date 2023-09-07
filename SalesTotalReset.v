module SalesTotalReset (
    input wire reset_button,       // ����ĸ�λ��ť�ź�
    input wire clear_sales,       // ������������۶��ź�
    input wire [3:0] sales_total, // ����������ܶ�
    output wire [3:0] cleared_total // ��������������ܶ�
);

reg [3:0] total = 0; // �ڲ��Ĵ��������ڴ洢�����ܶ��ֵ����ʼֵΪ��

always @(posedge reset_button or posedge clear_sales) begin
    if (reset_button)
        total <= 0; // ����λ��ť����ʱ���������ܶ�����
    if (clear_sales)
        total <= sales_total; // ���������۶��ź���Чʱ���������ܶ�����Ϊ����������ܶ�
end

assign cleared_total = total; // ��������������ܶ������˿�

endmodule
/*
ģ��������Ǹ��ݸ�λ��ť�źź��������۶��ź������������ܶ�ĸ�λ�����������
��ͨ��һ���ڲ��Ĵ��� total ���洢�����ܶ��ֵ������������ź�״̬������ total ��ֵ��
����λ��ť����ʱ��total �����㣬���������۶��ź���Чʱ��total ������Ϊ����������ܶ���
������������ܶ��������˿� cleared_total�����ģ�������ڹ��������ܶ�ĸ�λ�����������
*/