%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

img2 = imread('res1.jpg');

% we convert the color image to gray level;
[rows2, columns2, numberOfColorChannels2] = size(img2);
if numberOfColorChannels2 > 1
    imgGray2 = rgb2gray(img2); 
end

figure 
imshow(imgGray2,[])
title('Our Original Image Given in the Lesson')

% Restore with Inverse Filter:
FFTtaken2 = fft2(imgGray2);
PSFtry = fspecial('gaussian',[3 3],3.6);
OTFtry = psf2otf(PSFtry, size(FFTtaken2));
% divide by zero error check
for i = 1:size(OTFtry, 1)
    for j = 1:size(OTFtry, 2)
        if OTFtry(i, j) == 0
            OTFtry(i, j) = 0.000001;
        end
    end
end
fdebIMG2try = FFTtaken2./OTFtry;
inversedIMG2try = ifft2(fdebIMG2try);
figure
imshow(inversedIMG2try,[])
title('Inverse Filtre; Kernel:[3 3], Sigma: 3.6 (Try)')

% Restore with Cepstrum Filter:
img2FFT = fftshift(fft2(imgGray2));
img2Magnitude = abs(img2FFT);
img2MagLog = log(img2Magnitude+1);
img2Phase = angle(img2FFT);
img2MagCepstrum = ifft2(ifftshift(img2MagLog));
img2PhaseCepstrum = ifft2(ifftshift(img2Phase));
% We have passed to the Cepstrum Region
filter2 = fspecial('gaussian', [25 25], 3.6);
figure
freqz2(filter2)
filter2 = padarray(filter2,[size(imgGray2,1)-size(filter2,1),size(imgGray2,2)-size(filter2,2)],0,'post');
filtreFFT = fftshift(fft2(filter2));
filtreFFTMag = abs(filtreFFT);
filtreFFTMagLog = log(filtreFFTMag+1);
filtreFFTPhase = angle(filtreFFT);
filtreFFTMagCepstrum = ifft2(ifftshift(filtreFFTMagLog));
filtreFFTPhaseCepstrum = ifft2(ifftshift(filtreFFTPhase));

img2DeblurMagCepstrum = img2MagCepstrum - filtreFFTMagCepstrum; 
img2DeblurPhaseCepstrum = img2PhaseCepstrum + filtreFFTPhaseCepstrum; 
img2DeblurMagnitude = fftshift(fft2(img2DeblurMagCepstrum));
img2DeblurMagLogExp = exp(img2DeblurMagnitude);
img2DeblurMagLogExp = real(img2DeblurMagLogExp);
img2DeblurPhase = fftshift(fft2(img2DeblurPhaseCepstrum));
img2DeblurPhase = real(img2DeblurPhase);

img2DeblurFFTRegion = img2DeblurMagLogExp .* exp(1j * img2DeblurPhase);
img2Recovered = ifft2(ifftshift(img2DeblurFFTRegion));
img2Recovered = abs(img2Recovered);
figure 
imshow(img2Recovered,[]) 
title('Cepstrum Filtered Image');
