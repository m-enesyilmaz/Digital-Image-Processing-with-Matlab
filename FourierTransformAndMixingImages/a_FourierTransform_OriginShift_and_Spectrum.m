%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Muhammed Enes Yılmaz                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
close all
clear

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

figure
subplot(1,2,1)
imshow(img1) % We show the picture
title('First Image')
subplot(1,2,2)
imshow(img2) 
title('Second Image')

FT1 = fft2(double(img1)); % We performed the Fourier transform of the image.
FT2 = fft2(double(imgGray2)); % We performed the Fourier transform of the second picture.

shiftedFFT1 = fftshift(FT1); % we shift the origin to the middle point
shiftedFFT2 = fftshift(FT2); % we shift the origin to the middle point

figure
subplot(1,2,1)
imshow(abs(shiftedFFT1),[24 100000]), colormap gray
title('FFT2 Magnitude of Image 1')
subplot(1,2,2)
imshow(angle(fftshift(FT1)),[-pi pi]), colormap gray
title('FFT2 Phase of Image 1')

figure
subplot(1,2,1)
imshow(abs(shiftedFFT2),[24 100000]), colormap gray
title('FFT2 Magnitude of Image 2')
subplot(1,2,2)
imshow(angle(fftshift(FT2)),[-pi pi]), colormap gray
title('FFT2 Phase of Image 2')

figure
subplot(1,2,1)
imshow(real(shiftedFFT1));
title('The Real Part of the First Image Spectrum')
subplot(1,2,2)
imshow(imag(shiftedFFT1));
title('The Imaginary Part of the First Image Spectrum')
%If we show the phase and amplitudes of 2D FFTs
figure
imshow(log(abs(shiftedFFT1)),[]), colormap gray
title('Spectrum Logarithmic Magnitude of the First Image')

figure
subplot(1,2,1)
imshow(real(shiftedFFT2));
title('The Real Part of the Second Image Spectrum')
subplot(1,2,2)
imshow(imag(shiftedFFT2));
title('The Imaginary Part of the Second Image Spectrum')
%If we show the phase and amplitudes of 2D FFTs
figure
imshow(log(abs(shiftedFFT2)),[]), colormap gray
title('Spectrum Logarithmic Magnitude of the Second Image')
