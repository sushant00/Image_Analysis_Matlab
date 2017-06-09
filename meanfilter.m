%Sushant Kumar Singh
clc;
clear all;
close all;
%% read image and add noise
I=imread('lena256.tif');
I = im2double(I); % convert image to double precision
v = 0.05;
Inoisy = imnoise(I,'gaussian',0,v);

%% define variables and filter mask
window=3;
pad = floor(window/2);

%for 3x3,v=0.05  use suitable mask,given mask is for e.g.
mask=[0.000161 0.012353 0.000161;0.012353 0.949948 0.012353;0.000161 0.012353 0.000161];

sum_mask = sum(mask(:));
[x,y]=size(I);
Ifilter = I;

%% padding
Itmp=[zeros(x,pad),Inoisy,zeros(x,pad)];
Itmp=[zeros(pad,pad+y+pad);Itmp;zeros(pad,pad+y+pad)];


%% filtering
for i = pad+1 : x+pad
    for j = pad+1 : y+pad
       temp = Itmp(i-pad:i+pad , j-pad:j+pad);
       temp = temp.*mask;
       Ifilter(i-pad,j-pad) = ((sum(temp(:)))/sum_mask);
    end
end
%% display all images
figure(1),imshow(I);title('OrigImg');
figure(2),imshow(Inoisy);title('NoisyImg');
figure(3),imshow(Ifilter);title('MeanFilterImg');

%% calculate PSNR
[peaksnr, snr] = psnr(I,Ifilter);
display(peaksnr)