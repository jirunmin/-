module InitializeModule (
    input wire initialize_button,       // ����ĳ�ʼ����ť�ź�
    output wire [3:0] initialized_value // �����ʼ�����ֵ
);

reg [3:0] initial_value = 4'b0000;     // �ڲ��Ĵ��������ڴ洢��ʼ��ֵ����ʼֵΪȫ��

always @(posedge initialize_button) begin
    initial_value <= 4'b0000;          // ����ʼ����ť����ʱ������ʼ��ֵ����Ϊȫ��
end

assign initialized_value = initial_value; // ����ʼ�����ֵ��������˿�

endmodule
/*
ģ����������ڽ��յ���ʼ����ť�źź󣬽����ֵ����Ϊȫ�㡣��ͨ��һ���ڲ��Ĵ������洢��ʼ��ֵ��
����ʼ����ť����ʱ�����Ĵ�����ֵ����Ϊȫ�㣬�������ֵ��������˿� initialized_value��
*/