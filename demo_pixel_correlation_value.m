%���������������������������,�ֱ������ԭͼ������ͼ�����������������µ������������������
%plot pixel intensity distribution
clear;clc;
%����ԭͼ�����ɼ��ܾ��󣬵õ�����ͼ
X=imread('lena512.bmp');  %�Ⱥ�ѡ��lena512��peppers512,house256�ŵ�512��cameraman256�ŵ�512
X=rgb2gray(X);
X=double(X);
%����
%X=kron(X,ones(2));
[a,b]=size(X);

%���ɼ��ܾ���
%����������
%��һ��
T_m1=a/2;  %�����������������
T_n1=b;
%��һ��end
%�ڶ���
T_m2=a/4;  %����������������� ����С��������ָ�Ч������  t=2,��СΪ1/4
T_n2=b/2;
%�ڶ���end
%������
T_m3=a/8;  %����������������� ����С��������ָ�Ч������t=4,��СΪ1/16,a/8,b/4
T_n3=b/4;
%������end

%���ú���comp��������
Y_STP1=comp(X,T_m1,T_n1,1);
Y_STP2=comp(X,T_m2,T_n2,2);
Y_STP3=comp(X,T_m3,T_n3,4);

%��һ�������
h_STP1=zeros(2,1);  %���зֱ�洢����ǰ���������ϵ�� ,ˮƽ����һ����ԭͼ���ڶ����Ǽ���ͼ
v_STP1=zeros(2,1);  %��ֱ
d_STP1=zeros(2,1);  %�Խ�
%logistic�����
h_STP2=zeros(2,1);
v_STP2=zeros(2,1);
d_STP2=zeros(2,1);
%Tent�����
h_STP3=zeros(2,1);
v_STP3=zeros(2,1);
d_STP3=zeros(2,1);

%�����������������


