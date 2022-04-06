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

magnitude1 = abs(FT1); % We find the magnitude information of the Fourier transformed image.
phase1 = angle(FT1); % We find the phase information of the Fourier transformed image.
magnitude2 = abs(FT2); % We find the magnitude information of the Fourier transformed image.
phase2 = angle(FT2); % We find the phase information of the Fourier transformed image.

E = complex(0,phase1); % z = complex(a,b); It creates a complex output, z, from two real inputs like z = a + bi.
singlePhase1 = real(ifft2(exp(E))); % we apply the inverse fourier transform
singleSpec1 = real(ifft2(magnitude1)); % we apply the inverse fourier transform
figure
subplot(1,2,1)
imshow(singlePhase1, [])
title('Image 1 Inversed Using Phase Only')
subplot(1,2,2)
imshow(log(1 + abs(singleSpec1)), [])
title('Image 1 Inversed Using Spectrum Only')

C = complex(0,phase2); % z = complex(a,b); It creates a complex output, z, from two real inputs like z = a + bi.
singlePhase2 = real(ifft2(exp(C))); % we apply the inverse fourier transform
singleSpec2 = real(ifft2(magnitude2)); % we apply the inverse fourier transform
figure
subplot(1,2,1)
imshow(singlePhase2, [])
title('Image 2 Inversed Using Phase Only')
subplot(1,2,2)
imshow(log(1 + abs(singleSpec2)), [])
title('Image 2 Inversed Using Spectrum Only')

% Multiplying the magnitude and phase information of images:
% We multiply the magnitude information of the first image with the phase information of the second image.
fftNewImage1 = magnitude1.*exp(i*phase2);
% We multiply the magnitude information of the second image with the phase information of the first image.
fftNewImage2 = magnitude2.*exp(i*phase1);

newImage1 = ifft2(fftNewImage1); % we apply the inverse Fourier transform to our new result.
newImage2 = ifft2(fftNewImage2); % we apply the inverse Fourier transform to our new result.

% We calculate the borders to plot the image:
cmin = min(min(abs(newImage1)));
cmax = max(max(abs(newImage1)));
dmin = min(min(abs(newImage2)));
dmax = max(max(abs(newImage2)));

figure
subplot(1,2,1)
imshow(abs(newImage1), [cmin cmax]), colormap gray % magnitudes of complex outputs
title('Mixed New Image 1 Magnitude')
subplot(1,2,2)
imshow(abs(newImage2), [dmin dmax]), colormap gray % magnitudes of complex outputs
title('Mixed New Image 2 Magnitude')
