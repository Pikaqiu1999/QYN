clc;
clear all;
close all;

addpath('C:\QYN1999code\photo');                   %    The test images

addpath('C:\QYN1999code\Wavelet');                 %    WaveletSoftware

addpath('C:\QYN1999code\my function');             %    functions

fprintf('start compression and encryption:\n');

filename='2CT512.bmp';

original_image = imread(filename);
% original_image11=original_image;
% original_image = original_image(:,:,3);
original_image = rgb2gray(original_image);
imwrite(uint8(original_image),'x1.bmp');
original_image =double(original_image);
[high, width] = size(original_image);
yp = randn(width, high);
Cpoi=original_image;
zy1=original_image;
zy2=zy1;  
zy3=zy2;
aaa = 0;  
bbb = 255;  
cpy0=original_image;  
cpy1=original_image;  
cpy2=original_image; 

imwrite(uint8(zy2),'zy2.bmp');

CR =0.25;
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

Y1=Phi *zy2;
T=width*M;



xx=zeros(1,T);
yy=zeros(1,T);
zz=zeros(1,T);

xx(1)=0.3+0.0000000000000001;
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
R13=R13*1000;



xxx=zeros(1,T);
yyy=zeros(1,T);
zzz=zeros(1,T);

xxx(1)=0.3;
yyy(1)=0.4;
zzz(1)=0.5;
a=10;
w=3;

for i=2:T
    xxx(i)=yyy(i-1)-zzz(i-1);
    yyy(i)=sin(pi*xxx(i-1)-a*yyy(i-1));
    zzz(i)=cos(w*acos(zzz(i-1))+yyy(i-1));
end
R3=reshape(zzz,M,width);
R3=R3*1825211;
tmpy=Y1;
Y1=Y1+R3;

% ENTROPY(Y1)
[m_high, m_width] = size(Y1);
Index = randperm (m_high * m_width);
imwrite(uint8(Y1),'5renc.bmp');

fprintf('end compression and encryption:\n');

param.width = width;
param.high = high;
param.num_levels = num_levels;
imwrite(uint8(Cpoi),'1or.bmp');

imwrite(uint8(Y1),'1mi.bmp');

imwrite(uint8(tmpy),'0mi.bmp');

fprintf('start description :\n');



recovered_image = UserASPL(Y1, Phi, param, num_levels,R3);

fprintf('end description :\n');

imshow(uint8(recovered_image));
errorx=sum(sum(abs(recovered_image - zy1).^2));   %MSE误差
psnr2=10*log10(255*255/(errorx/high/width))   %  PSNR
ssim = ssim(recovered_image,zy1)
imwrite(mod(uint8(recovered_image),256),'m3dec.bmp');

h_STP1=zeros(2,1);  %两行分别存储加密前后两个相关系数 ,水平，第一行是原图，第二行是加密图
v_STP1=zeros(2,1);  %垂直
d_STP1=zeros(2,1);  %对角


[h_STP1(:,1),v_STP1(:,1),d_STP1(:,1)] = correlation_calculation(original_image,Y1)
% 
% 
% figure('Position', [150, 150, 1000, 400]);
% subplot(1,2,1);
% set(gca,'FontName','Times New Roman');
% [counts,~] =imhist(mod(uint8(original_image),256));
% title('原始图像直方图')
% bar(counts, 'FaceColor', [0 0 1]); 
% 
% 
% subplot(1,2,2);
% set(gca,'FontName','Times New Roman');
% [counts,~] =imhist(uint8(mod(Y1,256)));
% title('2D CS加密图直方图')
% bar(counts, 'FaceColor', [0 0 1]); % 橙色
% saveas(gcf, 'b2gram.png'); 
% 
% 
% 
% orig_pic = double(original_image);
% pixel_number=1000;
% [m,n]=size(orig_pic);
% r=zeros(1,3);
% N = 1000;
% x1=mod(floor(rand(1,N)*10^10),m-1)+1;
% x2=mod(floor(rand(1,N)*10^10),m)+1;
% x3=mod(floor(rand(1,N)*10^10),m-1)+2;
% y1=mod(floor(rand(1,N)*10^10),n-1)+1;
% y2=mod(floor(rand(1,N)*10^10),n)+1;
% u1=zeros(1,N);
% u2=zeros(1,N);
% u3=zeros(1,N);
% 
% v1=zeros(1,N);
% v2=zeros(1,N);
% v3=zeros(1,N);
% for i=1:N
%     u1(i)=orig_pic(x1(i),y2(i));
%     v1(i)=orig_pic(x1(i)+1,y2(i));
%     
%     u2(i)=orig_pic(x2(i),y1(i));
%     v2(i)=orig_pic(x2(i),y1(i)+1);
%     
%     u3(i)=orig_pic(x1(i),y1(i));
%     v3(i)=orig_pic(x1(i)+1,y1(i)+1);
% end
% 
% r(1)=mean((u1-mean(u1)).*(v1-mean(v1)))/(std(u1,1)*std(v1,1));
% r(2)=mean((u2-mean(u2)).*(v2-mean(v2)))/(std(u2,1)*std(v2,1));
% r(3)=mean((u3-mean(u3)).*(v3-mean(v3)))/(std(u3,1)*std(v3,1));
% 
% Y = mod(Y1,256);
% y1_v=Y(1:pixel_number);
% Y1_T=Y';
% y1_h=Y1_T(1:pixel_number);
% 
% Y1_diag=[];
% [r1,c1]=size(Y);
% for i=-(r1-1):(c1-1)
%     Y1_diag=[Y1_diag,(diag(Y,i)).'];
% end
% y1_d=Y1_diag(1:pixel_number);
% y1_adjacent_v=y1_v(2:end);
% y1_adjacent_v(end+1)=y1_v(1);
% y1_adjacent_h=y1_h(2:end);
% y1_adjacent_h(end+1)=y1_h(1);
% y1_adjacent_d=y1_d(2:end);
% y1_adjacent_d(end+1)=y1_d(1);
% 
% NN = pixel_number;
% [mm,nn]=size(Y);
% xx2=mod(floor(rand(1,NN)*10^10),mm)+1;
% yy1=mod(floor(rand(1,NN)*10^10),nn-1)+1;
% 
% 
% y1_v=zeros(1,NN);
% y1_adjacent_v=zeros(1,NN);
% for i=1:NN
%     y1_v(i)=Y(xx2(i),yy1(i));
%     y1_adjacent_v(i)=Y(xx2(i),yy1(i)+1); 
% end
% 
% 
% figure(3)  
% subplot(1,3,1)   %原图 水平相关性
% plot(u1,v1,'Color',[142/255, 182/255, 156/255],'linewidth',3,'markersize',3);
% axis([0 255 0 255]);
% set(gca,'XTick',0:50:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
% title('Horizonal');
% hold on
% 
% subplot(1,3,2)   %原图  垂直相关性
% plot(u2,v2,'Color',[238/255, 191/255, 109/255],'linewidth',3,'markersize',3);
% axis([0 255 0 255]);
% set(gca,'XTick',0:50:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
% title('Vertical');
% hold on
% 
% subplot(1,3,3)   %原图 对角线相关性
% plot(u3,v3,'Color',[131/255, 064/255, 038/255],'linewidth',3,'markersize',3);
% axis([0 255 0 255]);
% set(gca,'XTick',0:50:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
% title('Diagonal');
% 
% hFig = gcf;
% hFig = gcf;
% set(hFig, 'Position', [100, 100, 1200, 300]);
% saveas(gcf, 'badj1.png');
% 
% figure(2)   % 加密图像
% subplot(1,3,1)   %Y  水平
% plot(y1_h,y1_adjacent_h,'Color',[142/255, 182/255, 156/255],'linewidth',3,'markersize',3);
% axis([0 255 0 255]);
% set(gca,'XTick',0:50:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
% title('Horizonal');
% hold on;
% 
% 
% subplot(1,3,2)   %Y 垂直
% plot(y1_v,y1_adjacent_v,'Color',[238/255, 191/255, 109/255],'linewidth',3,'markersize',3);
% axis([0 255 0 255]);
% set(gca,'XTick',0:50:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
% title('Vertical');
% hold on
% 
% subplot(1,3,3)   %Y 对角线
% plot(y1_d,y1_adjacent_d,'Color',[131/255, 064/255, 038/255],'linewidth',3,'markersize',3);
% axis([0 255 0 255]);
% set(gca,'XTick',0:50:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
% title('Diagonal');
% 
% hFig = gcf;
% set(hFig, 'Position', [100, 100, 1200, 300]);
% 
% saveas(gcf, 'badj3.png');
