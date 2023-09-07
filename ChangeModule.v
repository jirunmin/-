module ChangeModule (
    input wire [3:0] total_amount,    // �����ܽ��
    input wire [3:0] product_price,   // �����Ʒ�۸�
    output wire [3:0] change_amount   // ���������
);

assign change_amount = total_amount - product_price; // ����������

endmodule
/*

�����Ǽ�����������ͨ��������Ĳ�Ʒ�۸���ܽ���м�ȥ��ʵ�֡�
������ܽ��Ͳ�Ʒ�۸�ֱ�ͨ�� total_amount �� product_price �����źŴ��ݸ��
ģ��ִ�м������㣬�������ֵ�� change_amount ����ź�
*/