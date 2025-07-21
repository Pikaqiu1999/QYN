clc;
clear all;
close all;

addpath('C:\QYN1999code\photo');                   %    The test images

addpath('C:\QYN1999code\Wavelet');                 %    WaveletSoftware

addpath('C:\QYN1999code\my function');             %    functions

fprintf('start compression and encryption:\n');

original_image = imread('merged_image.png'); % 读取红色通道图像
original_image =double(original_image);
[high, width] = size(original_image);
for kk=1:3
for i=1:high
    for j=1:width
        if i>10 &&i<30 && j>412&&j<511
           original_image(i,j,kk)=(rand()*100);
        end
        if i>35 &&i<70 && j>412&&j<511
            original_image(i,j,kk)=(rand()*100);
        end
    end
end
end
imwrite(uint8(original_image),'merged_image1.png');
