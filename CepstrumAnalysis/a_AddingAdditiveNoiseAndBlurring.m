%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

% Spatial Filtering:
% For spatial filtering, the image to be filtered is processed with a subimage. 
% The sub-image is placed over the original image and is hovered over the image 
% step by step. The associated pixels of the original image and sub-image 
% (filter or mask) are processed.
% Convolution Matrix
% Convolution is the process of scanning the whole picture on a square picture, 
% starting from the upper left corner of a square mask and passing the center of 
% the mask over each pixel.

img = imread('einstein.jpg');

figure
imshow(img,[])
title('Original Image 1024x1024')

% We choose random noise and apply it in a way that makes additive noise and blurring.

% If we create the noise ourselves:
% If we want to create white noise; 
additiveNoise = uint8(floor(0.01 + sqrt(625)*randn(1024,1024)));
figure
subplot(1,2,1)
plot(additiveNoise)
title('Our self-created additive noise')
subplot(1,2,2)
ourAdditiveNoise = img + additiveNoise;
imshow(ourAdditiveNoise);
title('When We Generate and Add the Additive Noise Ourselves')

% If we create and add the image with the Matlab command;
% J = imnoise(I,'gaussian',m,var_gauss); with m mean, var_gauss variance
% We add noise with a gaussian distribution.
additiveNoiseImg = imnoise(img,'gaussian',0,0.01); % variance: 0.01 default
figure
imshow(additiveNoiseImg,[]);
title('Our Additive Noise Added Image')

% For blur:
% fspecial: Create predefined 2-D filter
filter1 = fspecial('gaussian',[7 7],5);
blurNoiseImg = conv2(double(img),double(filter1));
figure
imshow(blurNoiseImg,[]);
title('Blurred Image')

% Examination of the spectra of images to which additive and blurring noises are added:
additiveNoiseImgSpectrum = fftshift(fft2(additiveNoiseImg));
blurNoiseImgSpectrum = fftshift(fft2(blurNoiseImg)); 

additiveNoiseImgSpectrumMagnitude = log(1+abs(additiveNoiseImgSpectrum));
additiveNoiseImgSpectrumPhase = angle(additiveNoiseImgSpectrum);

blurNoiseImgSpectrumMagnitude = log(1+abs(blurNoiseImgSpectrum));
blurNoiseImgSpectrumPhase = angle(blurNoiseImgSpectrum);

figure
subplot(1,2,1);
imshow(additiveNoiseImgSpectrumMagnitude,[]);
title({'Magnitude image of the spectrum of the image','with additive noise added'})
subplot(1,2,2);
imshow(additiveNoiseImgSpectrumPhase,[]);
title({'Phase image of the spectrum of the image','with additive noise added'})

figure
subplot(1,2,1);
imshow(blurNoiseImgSpectrumMagnitude,[]);
title('Magnitude image of the spectrum of the blurred image')
subplot(1,2,2);
imshow(blurNoiseImgSpectrumPhase,[]);
title('Phase image of the spectrum of the blurred image')

% The closeness of the image that we distorted with additive noise to the image 
% we blurred by softening it in the spatial region:

% B = imgaussfilt (A, sigma), The A image is the standard specified with sigma 
% Filters with 2-D Gaussian smoothing kernel using bias
additiveNoiseImgSmoothing = imgaussfilt(additiveNoiseImg,3); % sigma default 0.5
figure
imshow(additiveNoiseImgSmoothing,[]);
title({'The image obtained by smoothing the image','with additive noise added (\sigma=3)'})

% blurring and smoothing similarities;
figure
subplot(1,2,1)
imshow(blurNoiseImg,[]);
title('Blurred Image')
subplot(1,2,2)
imshow(additiveNoiseImgSmoothing,[]);
title('Smoothing image that has added additive noise')
