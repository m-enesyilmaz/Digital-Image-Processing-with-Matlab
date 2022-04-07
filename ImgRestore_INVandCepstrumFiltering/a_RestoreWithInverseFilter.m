%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

img = imread('bitcoin.jpg');

% Restoration Filters are types of filters used for processing noisy image 
% and predicting clean and original image. It can consist of operations used 
% for blurring or inverse operations used for blurring inverse. The filter used 
% in the restoration is different from the filter used in the image enhancement process.
% Reverse Filter:
% Reverse Filtering is the process of taking a system's input from its output. 
% Restoring the original image is the simplest approach once the degradation function is known.
% Pseudo Reverse Filter:
% The pseudo inverse filter is a modified version of the inverse filter and 
% the stabilized inverse filter. Pseudo-inverse filtering performs better than 
% inverse filtering, but is sensitive to both inverse and pseudo-inverse noise.

% we convert the color image to gray level;
[rows, columns, numberOfColorChannels] = size(img);
if numberOfColorChannels > 1
    imgGray = rgb2gray(img); 
end

figure
imshow(imgGray,[])
title('\fontsize{16} Original Image')

% for blurring:
% fspecial: Create predefined 2-D filter
PSF = fspecial('gaussian',[7 7],5);  % Kernel:[7 7], Sigma: 5
blurredIMG = conv2(double(imgGray),double(PSF));
figure
imshow(blurredIMG,[]);
title('\fontsize{16} Blurred Image')

% Converting to frequency domain
FFTtaken = fft2(blurredIMG);
% Create PSF of degradation
PSF = fspecial('gaussian',[7 7],5); % same parameter
% Convert psf to otf of desired size
% OTF is Optical Transfer Function
OTF = psf2otf(PSF, size(FFTtaken));
% To avoid the divide by zero error:
for i = 1:size(OTF, 1)
    for j = 1:size(OTF, 2)
        if OTF(i, j) == 0
            OTF(i, j) = 0.000001;
        end
    end
end
% Restoring an image using Invert Filter
fdebl = FFTtaken./OTF;
% Converting back to spatial domain using IFFT
inversedIMG = ifft2(fdebl);
figure
imshow(inversedIMG,[])
title('\fontsize{16} Recycled Image with Same Parameter')

% if we try with different parameters:
PSF2 = fspecial('gaussian',[7 7],1);
PSF3 = fspecial('gaussian',[7 7],10);
PSF4 = fspecial('gaussian',[10 10],2);
PSF5 = fspecial('gaussian',[10 10],9);
OTF2 = psf2otf(PSF2, size(FFTtaken));
OTF3 = psf2otf(PSF3, size(FFTtaken));
OTF4 = psf2otf(PSF4, size(FFTtaken));
OTF5 = psf2otf(PSF5, size(FFTtaken));
fdeb2 = FFTtaken./OTF2;
fdeb3 = FFTtaken./OTF3;
fdeb4 = FFTtaken./OTF4;
fdeb5 = FFTtaken./OTF5;
inversedIMG2 = ifft2(fdeb2);
inversedIMG3 = ifft2(fdeb3);
inversedIMG4 = ifft2(fdeb4);
inversedIMG5 = ifft2(fdeb5);
figure
subplot(2,2,1)
imshow(inversedIMG2,[]); title('\fontsize{16} Kernel:[7 7], Sigma: 1')
subplot(2,2,2)
imshow(inversedIMG3,[]); title('\fontsize{16} Kernel:[7 7], Sigma: 10')
subplot(2,2,3)
imshow(inversedIMG4,[]); title('\fontsize{16} Kernel:[10 10], Sigma: 2')
subplot(2,2,4)
imshow(inversedIMG5,[]); title('\fontsize{16} Kernel:[10 10], Sigma: 9')
