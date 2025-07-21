clc;
clear all;
close all;

addpath('C:\QYN1999code\photo');                   %    The test images

addpath('C:\QYN1999code\Wavelet');                 %    WaveletSoftware

addpath('C:\QYN1999code\my function');             %    functions

fprintf('start compression and encryption:\n');

filename='2CT512.bmp';

original_image = imread(filename);
original_image11=original_image;
% original_image = original_image(:,:,3);
original_image = rgb2gray(original_image);
imwrite(uint8(original_image),'car256mi.bmp');
original_image =double(original_image);
[high, width] = size(original_image);
yp = randn(width, high);
Cpoi=original_image;
zy1=original_image;
imwrite(uint8(original_image11),'Cpoi.bmp');
CR =0.5;
quantizer_bitdepth = 13;
num_levels = 10;
T=width*high;
x=zeros(1,T);
y=zeros(1,T);
z=zeros(1,T);
x(1)=0.3;
y(1)=0.4;
z(1)=0.5;
a=10;
w=3;
tic;
for i=2:T
    x(i)=y(i-1)-z(i-1);
    y(i)=sin(pi*x(i-1)-a*y(i-1));
    z(i)=cos(w*acos(z(i-1))+y(i-1));
end

z_matrix = reshape(z,high,width);

Phi=orth(z_matrix)';
n = 5;
M = round(CR*high);
Phi = Phi(1:M, :);

Y1=Phi *zy1;
T=width*M;

xx=zeros(1,T);
yy=zeros(1,T);
zz=zeros(1,T);

xx(1)=0.3;
yy(1)=0.4;
zz(1)=0.5;
a=10;
w=3;

for i=2:T
    xx(i)=yy(i-1)-zz(i-1);
    yy(i)=sin(pi*xx(i-1)-a*yy(i-1));
    zz(i)=cos(w*acos(zz(i-1))+yy(i-1));
end
R13=reshape(zz,M,width);

Y1=Y1+R13;
toc
R13=R13*11001;



xxx=zeros(1,T);
yyy=zeros(1,T);
zzz=zeros(1,T);

xxx(1)=yy(T)-zz(T);
yyy(1)=sin(pi*xx(T)-a*yy(T));
zzz(1)=cos(w*acos(zz(T))+yy(T));
a=10;
w=3;

for i=2:T
    xxx(i)=yyy(i-1)-zzz(i-1);
    yyy(i)=sin(pi*xxx(i-1)-a*yyy(i-1));
    zzz(i)=cos(w*acos(zzz(i-1))+yyy(i-1));
end
R3=reshape(zzz,M,width);
R3=R3*15001;

R3=uint8(mod(R3,256));
R13=uint8(mod(R13,256));
D = zeros(M, width);
for i = 1:M
        for j = 1:width
            if R13(i, j) ~= R3(i, j)
                D(i, j) = 1; % 如果像素值不同，则D(i,j)为1
            else
                D(i, j) = 0; % 否则为0
            end
        end
end
 
    % 计算NPCR（像素改变率）
    NPCR = sum(D(:)) / (M * width) * 100
 
    % 计算UACI（统一平均改变强度）
    % 注意：这里使用abs函数来计算像素值之差的绝对值，并除以255进行归一化
UACI_numerator = sum(sum(abs(double(R13) - double(R3)))) / (255 * M * width);
    UACI = UACI_numerator * 100






% 
% tmpy=Y1;
% Y1=Y1+R3;
% [m_high, m_width] = size(Y1);
% Index = randperm (m_high * m_width);
% 
% fprintf('end compression and encryption:\n');
% 
% param.width = width;
% param.high = high;
% param.num_levels = num_levels;
% imwrite(uint8(Cpoi),'1or.bmp');
% 
% imwrite(uint8(Y1),'1mi.bmp');
% 
% imwrite(uint8(tmpy),'0mi.bmp');
% 
% fprintf('start description :\n');
% 
% recovered_image = UserASPL(Y1, Phi, param, num_levels,R13);
% 
% fprintf('end description :\n');
% 
% imshow(uint8(recovered_image));
% errorx=sum(sum(abs(recovered_image - zy1).^2));   %MSE误差
% psnr2=10*log10(255*255/(errorx/high/width))   %  PSNR
% ssim = ssim(recovered_image,zy1)
% imwrite(uint8(recovered_image),'3re.bmp');