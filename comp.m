%Ϊ�򻯻Ҷ�ֱ��ͼ������д�ĺ���
% X-ԭͼ  p-��������������  q-��������������
%����֮���У�a*p/q���У�b
function result=comp(X,p,q,zz)


%%  CS����
%  ���ļ�
X=double(X);
[a,b]=size(X);
%  С���任��������
ww=DWT(a);
%  �ź�С���任
X11=ww*X*ww';

%���ù�ϣ��Կ���ɺ���
[n1,aa,bb]=demo_hash(X);

%arnold����
%�����븴ԭ�Ĺ�ͬ����
% n1=10;
% aa=3;bb=5;
N=a;
%����
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



%����������
%��һ��
T_m=p;  %�����������������
T_n=q;
%��һ��end


%T=rand(T_m,T_n);

%�����������
% ����һ��m*n�Ļ�����󣬲���Ҫ��ѭ�����棬��Ϊ������ȷ����
c=4; %����ѡȡ�������еļ��
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

%���ž�����в���
I=eye(a/T_n);
T_STP=kron(T,I);
%Y_STP=0.001*T_STP*X1+253*kron(T,ones(a/T_n));

aaa=0.001;
bbb=254;
%% ������Ĥ����
c1=4*2*zz*zz; %�˻��õ������С ���4�������ŵ�4��ȡ16
c2=4; %�������
ch1=zeros(1,T_n*T_m*c1);
ch11=zeros(1,T_n*T_m*c1/2);
ch1(1)=0.24;
% for i=1:T_m*T_n*c1-1
%     ch1(i+1)=4*ch1(i)*(1-ch1(i));
% end
k=0.3;    %chebyshv���β���
for i=1:T_m*T_n*c1-1
   if( ch1(i)>0 & ch1(i)<k)
        ch1(i+1)= ch1(i)/k;
    else
         ch1(i+1)=(1- ch1(i))/(1-k);
    end   %tent��ӳ���ϵ
end
for i=(T_m*T_n*c1)/2+1:T_m*T_n*c1
    ch11(i-(T_m*T_n*c1)/2)=ch1(i);
end
ch_sample1=downsample(ch11,c2);
%%
Y3=reshape(ch_sample1,zz*p,a);
Y_STP1=aaa*T_STP*X1+bbb*Y3;


%%���ɻ�������
%M=a/2;
%N=b;
u=4;     %logistic����
distance=4; %�������
n2=a*p*b*distance/q;
z=zeros(1,n2);
z(1)=0.3;

for i=1:n2-1
    z(i+1)=u*z(i)*(1-z(i));
end

z_sample=downsample(z,distance);%�����������������м��ɵõ�����Ļ������

%R=reshape(z_sample,M,N); 

[z_sort,I1]=sort(z_sample);

%��������
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