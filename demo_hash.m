%本程序用来计算图像的哈希值
function [n1,aa,bb]=demo_hash(X)

%调用哈希函数
h = hash(X,'SHA-256');

%将哈希函数转换为32个double的数
k=zeros(1,32);
for i=1:2:64
tmp=[h(i),h(i+1)];
k((i+1)/2)=hex2dec(tmp);
end

%异或操作
s=k(1);
for i=1:10
  s=bitxor(s,k(i+1));
end

p=k(12);
for i=12:21
  p=bitxor(p,k(i+1));
end

q=k(23);
for i=23:31
  q=bitxor(q,k(i+1));
end

n0=10;
a0=3;
b0=5;

n1=n0+s
aa=a0+p
bb=b0+q


