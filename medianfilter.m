%Sushant Kumar Singh
clc;
clear all;
close all;
%% read image and add noise
I=imread('lena256.tif');
I = im2double(I); % convert image to double precision
d=input('Enter d(proportion of pixel affected):');
Inoisy = imnoise(I,'salt & pepper',d);

%% define variables
window=input('Enter Window size:');
pad = floor(window/2);
[x,y]=size(I);
Ifilter = I;

%% padding
Itmp=[zeros(x,pad),Inoisy,zeros(x,pad)];
Itmp=[zeros(pad,pad+y+pad);Itmp;zeros(pad,pad+y+pad)];


%% filtering
for i = pad+1 : x+pad
    for j = pad+1 : y+pad
       temp = Itmp(i-pad:i+pad , j-pad:j+pad);
       temp = sort(temp(:));
       median = temp((window*window+1)/2);
       Ifilter(i-pad,j-pad) = median;
    end
end
%% display all images
figure(1),imshow(I);title('OrigImg');
figure(2),imshow(Inoisy);title('NoisyImg');
figure(3),imshow(Ifilter);title('MedianFilterImg');

%% calculate PSNR
[peaksnr, snr] = psnr(I,Ifilter);
display(peaksnr)