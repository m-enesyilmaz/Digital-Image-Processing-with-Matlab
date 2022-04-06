%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

% In mathematics, a wavelet series is a representation of a square-integrable 
% (real or complex-valued) function by a given orthonormal series generated 
% by a wavelet. Wavelet transform is a type of transform used for time-frequency 
% analysis of a signal. Wavelet Transform shows us which frequency component 
% the signal contains at which time. An important advantage over Fourier 
% transforms is temporal resolution: it captures both frequency and position 
% information (position in time). If we want to see both time and frequency 
% component information in a signal, Wavelet Transform is ideal for this.

% Discrete Wavelet Transform (DWT) divides the image into low and high frequency 
% parts. High frequency represents the edge components of the image. The low 
% frequency represents the DC coefficients of the image.

img1 = imread('image1.jpg');
img2 = imread('image2.jpg'); 

% we convert the color image to gray level;
[rows1 columns1 numberOfColorChannels1] = size(img1);
% if the image is in color change it to gray:
if numberOfColorChannels1 > 1
    img1Gray = rgb2gray(img1); 
end
% if the image is in color change it to gray:
[rows2 columns2 numberOfColorChannels2] = size(img2);
if numberOfColorChannels2 > 1
    img2Gray = rgb2gray(img2); 
end

figure
subplot(2,2,1)
imshow(img1) 
title('First Image')
subplot(2,2,2)
imshow(img2) 
title('Second Image')
subplot(2,2,3)
imshow(img1Gray)
title('First Image Gray Level')
subplot(2,2,4)
imshow(img2Gray) 
title('Second Image Gray Level')

% dwt2: single level discrete 2D wavelet transform
% [cA,cH,cV,cD] = dwt2(X,wname)
% cA: approximation coefficient
% cH: horizontal detail coefficient
% cV: vertical detail coefficient
% cD: diagonal detail coefficient
% wname: analysis method
% As a requirement of Wavelet Transformation, we perform level transitions via approximation.
[Approx1,Horizon1,Vertical1,Diag1] = dwt2(im2double(img1),'haar'); 
% We're applying a level 1 haar transformation to the first image.
% Next, we apply the 2nd and 3rd level transformations, respectively.
[Approx2,Horizon1_2,Vertical1_2,Diag1_2] = dwt2(Approx1,'haar'); 
% Approximation coefficient of the image, and in order; We obtain the coefficients 
% at the horizontal, vertical and diagonal levels.
[Approx3,Horizon1_3,Vertical1_3,Diag1_3] = dwt2(Approx2,'haar'); 

% In two-dimensional applications, DWT (Discrete Wavelet Transform) is applied 
% first vertically and then horizontally. Then, these steps continue in the order 
% at which level (scale) is desired. This process is called Multiresolution Processing. 
% Multiresolution theory is concerned with the representation and analysis of 
% multiple resolution images.

level1 = [Approx1,Horizon1;Vertical1,Diag1]; % 1st level of wavelet transform
figure
imshow(level1,[])
title('1st level Wavelet Image of First Image')

level2 = [Approx2,Horizon1_2;Vertical1_2,Diag1_2]; 
% Applying the wavelet transform to approximation, the 2nd level is only in the upper left
figure
imshow(level2,[])
title('Only the upper left (low frequency) Wavelet Image of the First Picture at level 2')

figure
imshow([level2,Horizon1;Vertical1,Diag1],[])
title('2nd level Wavelet Image of First Image')

level3=[Approx3,Horizon1_3;Vertical1_3,Diag1_3]; 
% Applying the wavelet transform to approximation, the 3rd level is only in the upper left
figure
imshow(level3,[])
title('Only the upper left (low frequency) Wavelet Image of the First Picture at level 3')

figure
imshow([[[level3,Horizon1_2;Vertical1_2,Diag1_2],Horizon1];Vertical1,Diag1],[])
title('3rd level Wavelet Image of First Image')
