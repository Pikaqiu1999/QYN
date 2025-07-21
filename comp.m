%为简化灰度直方图主程序写的函数
% X-原图  p-半张量矩阵行数  q-半张量矩阵列数
%张量之后，行：a*p/q，列：b
function result=comp(X,p,q,zz)


%%  CS测量
%  读文件
X=double(X);
[a,b]=size(X);
%  小波变换矩阵生成
ww=DWT(a);
%  信号小波变换
X11=ww*X*ww';

%调用哈希密钥生成函数
[n1,aa,bb]=demo_hash(X);

%arnold置乱
%置乱与复原的共同参数
% n1=10;
% aa=3;bb=5;
N=a;
%置乱
X1=zeros(a,b);
for i=1:n1
    for y=1:a
        for x=1:b         
            xx=mod((x-1)+bb*(y-1),N)+1;
            yy=mod(aa*(x-1)+(aa*bb+1)*(y-1),N)+1;        
          X1(yy,xx)=X11(y,x);                
        end
    end
    X11=X1;
end



%半张量矩阵
%第一组
T_m=p;  %半张量矩阵的行列数
T_n=q;
%第一组end


%T=rand(T_m,T_n);

%混沌测量矩阵
% 生成一个m*n的混沌矩阵，不需要在循环里面，因为它都是确定的
c=4; %控制选取混沌序列的间隔
ch=zeros(1,T_n*T_m*c);
CHAOS=zeros(T_m,T_n);
ch(1)=0.2;
for i=1:T_m*T_n*c-1
    ch(i+1)=4*ch(i)*(1-ch(i));
end
ch_sample=downsample(ch,c);

for i=1:T_m*T_n
    v_sample(i)=1-2*ch_sample(i);
end
T=(sqrt(2/T_m))*reshape(v_sample,T_m,T_n);

%半张矩阵进行测量
I=eye(a/T_n);
T_STP=kron(T,I);
%Y_STP=0.001*T_STP*X1+253*kron(T,ones(a/T_n));

aaa=0.001;
bbb=254;
%% 生成掩膜矩阵
c1=4*2*zz*zz; %乘积得到矩阵大小 间隔4，乘以张的4，取16
c2=4; %采样间隔
ch1=zeros(1,T_n*T_m*c1);
ch11=zeros(1,T_n*T_m*c1/2);
ch1(1)=0.24;
% for i=1:T_m*T_n*c1-1
%     ch1(i+1)=4*ch1(i)*(1-ch1(i));
% end
k=0.3;    %chebyshv分形参数
for i=1:T_m*T_n*c1-1
   if( ch1(i)>0 & ch1(i)<k)
        ch1(i+1)= ch1(i)/k;
    else
         ch1(i+1)=(1- ch1(i))/(1-k);
    end   %tent的映射关系
end
for i=(T_m*T_n*c1)/2+1:T_m*T_n*c1
    ch11(i-(T_m*T_n*c1)/2)=ch1(i);
end
ch_sample1=downsample(ch11,c2);
%%
Y3=reshape(ch_sample1,zz*p,a);
Y_STP1=aaa*T_STP*X1+bbb*Y3;


%%生成混沌序列
%M=a/2;
%N=b;
u=4;     %logistic参数
distance=4; %采样间隔
n2=a*p*b*distance/q;
z=zeros(1,n2);
z(1)=0.3;

for i=1:n2-1
    z(i+1)=u*z(i)*(1-z(i));
end

z_sample=downsample(z,distance);%该向量经过重新排列即可得到所需的混沌矩阵

%R=reshape(z_sample,M,N); 

[z_sort,I1]=sort(z_sample);

%混沌置乱
Y_STP2=zeros(a*p/q,b);
for j=1:b
    for i=1:(a*p/q)
        n3=i+(j-1)*(a*p/q);
        if mod(I1(n3),(a*p/q))~=0
           i1=mod(I1(n3),(a*p/q));
        else
           i1=a*p/q;
        end
        j1=ceil(I1(n3)/(a*p/q));
        Y_STP2(i,j)=Y_STP1(i1,j1);
    end
end
result=Y_STP2;