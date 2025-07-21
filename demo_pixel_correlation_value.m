%本程序用来计算相邻像素相关性,分别计算了原图，加密图在三个半张量矩阵下的三种相邻像素相关性
%plot pixel intensity distribution
clear;clc;
%读入原图，生成加密矩阵，得到加密图
X=imread('lena512.bmp');  %先后选用lena512和peppers512,house256张的512，cameraman256张的512
X=rgb2gray(X);
X=double(X);
%张量
%X=kron(X,ones(2));
[a,b]=size(X);

%生成加密矩阵
%半张量矩阵
%第一组
T_m1=a/2;  %半张量矩阵的行列数
T_n1=b;
%第一组end
%第二组
T_m2=a/4;  %半张量矩阵的行列数 ，在小波域测量恢复效果不错  t=2,大小为1/4
T_n2=b/2;
%第二组end
%第三组
T_m3=a/8;  %半张量矩阵的行列数 ，在小波域测量恢复效果不错，t=4,大小为1/16,a/8,b/4
T_n3=b/4;
%第三组end

%调用函数comp生成密文
Y_STP1=comp(X,T_m1,T_n1,1);
Y_STP2=comp(X,T_m2,T_n2,2);
Y_STP3=comp(X,T_m3,T_n3,4);

%第一组相关性
h_STP1=zeros(2,1);  %两行分别存储加密前后两个相关系数 ,水平，第一行是原图，第二行是加密图
v_STP1=zeros(2,1);  %垂直
d_STP1=zeros(2,1);  %对角
%logistic相关性
h_STP2=zeros(2,1);
v_STP2=zeros(2,1);
d_STP2=zeros(2,1);
%Tent相关性
h_STP3=zeros(2,1);
v_STP3=zeros(2,1);
d_STP3=zeros(2,1);

%计算相邻像素相关性


