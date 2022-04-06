%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Muhammed Enes Yılmaz                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear
clc

img1 = imread('res1.jpg'); % We read an image in the folder where the code is located.
img2 = imread('res2.jpg');
% We got the size of the image.
% numberOfColorBands = 1
[rows1 columns1 numberOfColorChannels1] = size(img1);
% if the image is in color change it to gray:
if numberOfColorChannels1 > 1
    imgGray = rgb2gray(img1); 
end
% if the image is in color change it to gray:
[rows2 columns2 numberOfColorChannels2] = size(img2);
if numberOfColorChannels2 > 1
    imgGray2 = rgb2gray(img2); 
end

FT1 = fft2(double(img1)); % We performed the Fourier transform of the image.
FT2 = fft2(double(imgGray2)); % We performed the Fourier transform of the second picture.

genlik1 = abs(FT1); % We find the magnitude information of the Fourier transformed image.
faz1 = angle(FT1); % We find the phase information of the Fourier transformed image.
figure
subplot(1,2,1)
imshow(fftshift(log(1 + genlik1)), [])
title('First Image Spectrum')
subplot(1,2,2)
imshow(faz1,[])
title('Phase of First Image')

genlik2 = abs(FT2); % We find the magnitude information of the Fourier transformed image.
faz2 = angle(FT2); % We find the phase information of the Fourier transformed image.
figure 
subplot(1,2,1)
imshow(fftshift(log(1 + genlik2)), [])
title('Second Image Spectrum')
subplot(1,2,2) 
imshow(faz2,[])
title('Phase of Second Image')
% In logarithm operation, large dynamic range of values gets compressed into a smaller 
% range especially when values get bigger and so naturally scaling this compressed 
% range to [0,1] will give us better visual results.
% The reason we add 1 to each component and then get the LOG is to avoid the log(0) 
% operation. If any magnitude component is zero, it will evaluate to log(1), 
% which will be 0. Once we've done that, we can rescale the screen using 
% the imshow(..., []) command so that the smallest magnitude component goes to 0 
% while the largest magnitude component goes to 1 of the LOG spectrum. 
% Note that the original spectrum has not been altered so we can do our operations on it.
