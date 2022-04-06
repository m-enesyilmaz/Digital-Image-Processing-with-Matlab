%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

img = imread('einstein.jpg');

% If we design a filter with the same model with different parameters:
filter2 = fspecial('gaussian',[3 3],2);
figure
freqz2(filter2)
title({'Frequency response of the second filter','in the same model with different parameters - filter2'})
FFTimg = fft2(img);
filtered2 = imfilter(img,filter2);

C1 = MakeCepstrum(img);   % cepstrum of the image
C2 = MakeCepstrum(filtered2);  % cepstrum of filtered image

differenceInTheCepstrums = C1 - C2;  % error in between
% Revert from error
Err = sqrt(fft2(differenceInTheCepstrums));
Err = exp(1).^(abs(Err));      
Err = Err.*(cos(angle(FFTimg)) + i*sin(sin(angle(FFTimg))));
filtered2 = ifft2(Err);
filtered2 = abs(filtered2)./max(max(abs(filtered2))).*1023; %1024(img)

figure
subplot(1,2,1)
imshow(ifftshift(differenceInTheCepstrums),[]);
title('Difference between our original image and our second filter')
subplot(1,2,2)
imshow(uint8(filtered2),[]);
title('Cepstrum returned from filter2 error');
