figure('Position', [50, 50, 1200, 400]);
subplot(1,3,1);
set(gca,'FontName','Times New Roman');
imhist(mod(uint8(original_image),256));
title('原始图像直方图')

subplot(1,3,2);
set(gca,'FontName','Times New Roman');
imhist(uint8(mod(tmpy,256)));
title('2D CS加图直方图')

subplot(1,3,3);
set(gca,'FontName','Times New Roman');
imhist(uint8(mod(Y1,256)));
title('2D CS加密图直方图')
saveas(gcf, '2gram.png'); 

orig_pic = double(zy1);
pixel_number=10000;
[m,n]=size(orig_pic);
r=zeros(1,3);
N = 10000;
x1=mod(floor(rand(1,N)*10^10),m-1)+1;
x2=mod(floor(rand(1,N)*10^10),m)+1;
x3=mod(floor(rand(1,N)*10^10),m-1)+2;
y1=mod(floor(rand(1,N)*10^10),n-1)+1;
y2=mod(floor(rand(1,N)*10^10),n)+1;
u1=zeros(1,N);
u2=zeros(1,N);
u3=zeros(1,N);

v1=zeros(1,N);
v2=zeros(1,N);
v3=zeros(1,N);
for i=1:N
    u1(i)=orig_pic(x1(i),y2(i));
    v1(i)=orig_pic(x1(i)+1,y2(i));
    
    u2(i)=orig_pic(x2(i),y1(i));
    v2(i)=orig_pic(x2(i),y1(i)+1);
    
    u3(i)=orig_pic(x1(i),y1(i));
    v3(i)=orig_pic(x1(i)+1,y1(i)+1);
end

r(1)=mean((u1-mean(u1)).*(v1-mean(v1)))/(std(u1,1)*std(v1,1));
r(2)=mean((u2-mean(u2)).*(v2-mean(v2)))/(std(u2,1)*std(v2,1));
r(3)=mean((u3-mean(u3)).*(v3-mean(v3)))/(std(u3,1)*std(v3,1));

Y = mod(Y1,256);
y1_v=Y(1:pixel_number);
Y1_T=Y';
y1_h=Y1_T(1:pixel_number);

Y1_diag=[];
[r1,c1]=size(Y);
for i=-(r1-1):(c1-1)
    Y1_diag=[Y1_diag,(diag(Y,i)).'];
end
y1_d=Y1_diag(1:pixel_number);
y1_adjacent_v=y1_v(2:end);
y1_adjacent_v(end+1)=y1_v(1);
y1_adjacent_h=y1_h(2:end);
y1_adjacent_h(end+1)=y1_h(1);
y1_adjacent_d=y1_d(2:end);
y1_adjacent_d(end+1)=y1_d(1);

NN = pixel_number;
[mm,nn]=size(Y);
xx2=mod(floor(rand(1,NN)*10^10),mm)+1;
yy1=mod(floor(rand(1,NN)*10^10),nn-1)+1;


y1_v=zeros(1,NN);
y1_adjacent_v=zeros(1,NN);
for i=1:NN
    y1_v(i)=Y(xx2(i),yy1(i));
    y1_adjacent_v(i)=Y(xx2(i),yy1(i)+1); 
end


figure(3)  
subplot(1,3,1)   %原图 水平相关性
plot(u1,v1,'m.','linewidth',3,'markersize',3);
axis([0 255 0 255]);
set(gca,'XTick',0:100:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
set(gca,'XTickLabel',{'0','100','200','300'});
set(gca,'YTickLabel',{'0','50','100','150','200','250'});
title('Horizonal');
hold on

subplot(1,3,2)   %原图  垂直相关性
plot(u2,v2,'b.','linewidth',3,'markersize',3);
axis([0 255 0 255]);
set(gca,'XTick',0:100:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
set(gca,'XTickLabel',{'0','100','200','300'});
set(gca,'YTickLabel',{'0','50','100','150','200','250'});
title('Vertical');
hold on

subplot(1,3,3)   %原图 对角线相关性
plot(u3,v3,'r.','linewidth',3,'markersize',3);
axis([0 255 0 255]);
set(gca,'XTick',0:100:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
set(gca,'XTickLabel',{'0','100','200','300'});
set(gca,'YTickLabel',{'0','50','100','150','200','250'});
title('Diagonal');

saveas(gcf, 'adj1.png');

figure(2)   % 加密图像
subplot(1,3,1)   %Y  水平
plot(y1_h,y1_adjacent_h,'m.','linewidth',3,'markersize',3);
axis([0 255 0 255]);
set(gca,'XTick',0:100:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
set(gca,'XTickLabel',{'0','100','200','300'});
set(gca,'YTickLabel',{'0','50','100','150','200','250'});
title('Horizonal');
hold on;


subplot(1,3,2)   %Y 垂直
plot(y1_v,y1_adjacent_v,'b.','linewidth',3,'markersize',3);
axis([0 255 0 255]);
set(gca,'XTick',0:100:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
set(gca,'XTickLabel',{'0','100','200','300'});
set(gca,'YTickLabel',{'0','50','100','150','200','250'});
title('Vertical');
hold on

subplot(1,3,3)   %Y 对角线
plot(y1_d,y1_adjacent_d,'r.','linewidth',3,'markersize',3);
axis([0 255 0 255]);
set(gca,'XTick',0:100:250,'YTick',0:50:250,'fontsize',10,'fontname','times new roman');
set(gca,'XTickLabel',{'0','100','200','300'});
set(gca,'YTickLabel',{'0','50','100','150','200','250'});
title('Diagonal');

saveas(gcf, 'adj3.png');
