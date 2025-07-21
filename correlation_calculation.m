function [h,v,d] = correlation_calculation(im,enim)
%本函数用于计算相邻像素相关性. 
%
% im----input original image
% enim--the encrypted image
% num---the total number o pixels to be compared
%
% h-----the correlation coefficients of two neighboring pixels in the horizontal direction
% v-----the correlation coefficients of two neighboring pixels in the vertical direction
% d-----the correlation coefficients of two neighboring pixels in the diagonal direction


if ~isa(im,'double')
    im = double(im);
end

if ~isa(enim,'double')
    enim = double(enim);
end

% calculate vertical correlation coefficient
v(1) = Fshift_corr(im(:),1);
v(2) = Fshift_corr(enim(:),1);

% calculate horizontal correlation coefficient
h(1) = Fshift_corr(reshape(im',1,[]),1);
h(2) = Fshift_corr(reshape(enim',1,[]),1);


% calcluate adjacent pixels
[r,c] = size(im);
[r1,c1]=size(enim);
im_diag=[];   %用于存放按对角线方式存储的数据，进行对角像素的比较
enim_diag=[];
for i=-(r-1):(c-1)
    im_diag=[im_diag,(diag(im,i)).'];
end

for j=-(r1-1):(c1-1)
    enim_diag=[enim_diag,(diag(enim,j)).'];
end

d(1) = Fshift_corr(im_diag.',1);
d(2) = Fshift_corr(enim_diag.',1);



function c = Fshift_corr(x,shift)
%计算两个列之间的相关性

x = x(:);
if shift>=1
    x2 = x(shift+1:end);
    x2(end+1:end+shift) = x(1:shift);
else
    x2 = x;
end

c = corr(x,x2);
end
end
