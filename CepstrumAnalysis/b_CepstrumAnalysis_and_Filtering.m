%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

img = imread('einstein.jpg');

filter1 = fspecial('gaussian',[7 7],5);
blurNoiseImg = conv2(double(img),double(filter1));

blurNoiseImgSpectrum = fftshift(fft2(blurNoiseImg)); 

% Cepstrum analysis is a non-linear signal processing technique with various 
% applications in fields such as speech and image processing. The Cepstrum 
% of the complex x of a sequence is calculated by finding the complex natural 
% logarithm of the Fourier transform of x, then the inverse Fourier transform 
% of the resulting sequence.
% When we do a Cepstrum analysis, we get a different domain. There is neither 
% a frequency domain nor a spatial domain. The reason for this is that 
% the logarithm is taken when performing the Cepstrum analysis. It also 
% overcomes the instability in IIR as the Fourier transform is used. 
% We cannot see the signal as we see it in the spatial domain, it looks like it.

% As a disadvantage, the phase function should be in the range of ±2𝜋 due to taking 
% the logarithm, but in some regions the phase is cut off and may seem stuck. 
% Phase correction should be done (Phase unwrapping). Despite this disadvantage, 
% it is widely used in image restoration because it overcomes the instability 
% in IIR and is logarithmic addition.

% We will bring the blurred image to the cepstrum region and reduce the effect 
% of noise from the image in the cepstrum region with the filter we will design 
% in the cepstrum region, then we will observe it in the spatial region.
blurNoiseImgCepstrum = ifftshift(ifft2(log(blurNoiseImgSpectrum)));
figure
imshow(blurNoiseImgCepstrum,[])
title('Cepstrum of blur noise image')

figure
cepstrumToSpectrum = exp(fft2(fftshift(blurNoiseImgCepstrum)));
spectrumToSpatialINV = uint8(ifft2(ifftshift(cepstrumToSpectrum)));
imshow(spectrumToSpatialINV);
title('Cepstrum inverse of blur noise image')

% We design filters with the same values as the noises we applied at the beginning:
filter1Same = fspecial('gaussian',[7 7],5);
var = 0.01;
% imfilter(): N-D filtering of multidimensional images
% B = imfilter(A, h); filters the multidimensional array A with the multidimensional 
% filter h and returns the result as B.
% image with both blurry and additive noise;
BlurredNoisy = imnoise(imfilter(img,filter1Same),'gaussian',0,var);

figure
freqz2(filter1Same)
title('The frequency response of the filter we will apply')
% figure
% freqz2(BlurredNoisy) % it makes the system very tiring and takes time to finish
% title({'Frequency response of the blurred','and noise-added filter'})
figure
imshow(BlurredNoisy,[]);
title('Our blurred and noisy applied image');

% We continue our deblur process over "blurNoiseImage":
WT = zeros(size(img));
WT(256:end-256,256:end-256) = 1; % we designed a lowpass filter
% deconvlucy(); Deblur image using Lucy-Richardson method
J1 = deconvlucy(blurNoiseImg,filter1Same);
J2 = deconvlucy(blurNoiseImg,filter1Same,20,sqrt(var));

figure
imshow(blurNoiseImg,[]);
title('Our image with blur noise applied');
figure
imshow(J1,[]);
title({'deconvlucy(blurNoiseImg,filter1Same)','Sharpening image with blur noise applied'});
figure
imshow(J2,[]);
title({'deconvlucy(blurNoiseImg,filter1Same,DP)','Sharpening an image with blur noise applied'});

CepstrumImg = MakeCepstrum(img);
CepstrumImgBlurred = MakeCepstrum(blurNoiseImg);

figure
imshow(ifftshift(CepstrumImg));
title('Cepstrum of our original image');
figure
imshow(ifftshift(CepstrumImgBlurred));
title('Cepstrum of image with blur noise added');
