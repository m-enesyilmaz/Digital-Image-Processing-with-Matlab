%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

img1 = imread('image1.jpg');
img2 = imread('image2.jpg'); 

% if we need gray level images:
% [rows1 columns1 numberOfColorChannels1] = size(img1);
% if numberOfColorChannels1 > 1
%     img1Gray = rgb2gray(img1); 
% end
% 
% [rows2 columns2 numberOfColorChannels2] = size(img2);
% if numberOfColorChannels2 > 1
%     img2Gray = rgb2gray(img2); 
% end

[Approx1,Horizon1,Vertical1,Diag1] = dwt2(im2double(img1),'haar'); 
[Approx2,Horizon1_2,Vertical1_2,Diag1_2] = dwt2(Approx1,'haar'); 
[Approx3,Horizon1_3,Vertical1_3,Diag1_3] = dwt2(Approx2,'haar'); 

% If we reset Approximation 3 (top left / Low Frequency)
zero_Approx3 = zeros(size(Approx3)); % We set the lowest frequency components to zero.
level2InvT = idwt2(zero_Approx3,Horizon1_3,Vertical1_3,Diag1_3,'haar'); 
% We've reached level 2 with the Inverted Wavelet
level1InvT = idwt2(level2InvT,Horizon1_2,Vertical1_2,Diag1_2,'haar'); 
% We've reached level 1 with the Inverted Wavelet
img1InvT = idwt2(level1InvT,Horizon1,Vertical1,Diag1,'haar'); 
% We obtained the picture again with the inverse wavelet transform.
figure
imshow(img1InvT,[])
title('First Picture with Lowest Frequency Components Removed')

% If we zero Diagonal1 (Right Down / High Frequency)
zero_Diag1 = zeros(size(Diag1)); % We set the highest frequency components zero.
level2InvT2 = idwt2(Approx3,Horizon1_3,Vertical1_3,Diag1_3,'haar'); 
% We've reached level 2 with the Inverse Wavelet transform
level1InvT2 = idwt2(level2InvT2,Horizon1_2,Vertical1_2,Diag1_2,'haar'); 
% We've reached level 1 with the Inverse Wavelet transform
img1InvT2 = idwt2(level1InvT2,Horizon1,Vertical1,zero_Diag1,'haar'); 
% We obtained the image again with the Inverted Wavelet.
figure
imshow(img1InvT2,[])
title('First Picture with Highest Frequency Components Removed')

% If we zero diagonal3 (high frequency component of level 3)
zero_Diag3 = zeros(size(Diag1_3));
level2InvT3 = idwt2(Approx3,Horizon1_3,Vertical1_3,zero_Diag3,'haar'); 
% We've reached level 2 with the Inverted Wavelet.
level1InvT3 = idwt2(level2InvT3,Horizon1_2,Vertical1_2,Diag1_2,'haar'); 
% We've reached level 1 with the Inverted Wavelet
img1InvT3 = idwt2(level1InvT3,Horizon1,Vertical1,Diag1,'haar'); 
% We obtained the image again with the Inverted Wavelet.
figure
imshow(img1InvT3,[])
title('First Picture 3rd Level High Frequency Component Removed')

% If Low Frequency Zone is Set to Zero at Level 1
zero_Approx1 = zeros(size(Approx1));
img1InvT4 = idwt2(zero_Approx1,Horizon1,Vertical1,Diag1,'haar'); 
% We obtained the image again with the Inverted Wavelet.
figure
imshow(img1InvT4,[])
title('1st Level of the First Picture with the Low Frequency Component Removed')

% If the Vertical Coefficient of Level 3 is set to Zero
zero_Vertical1_3 = zeros(size(Vertical1_3)); 
% The vertical component of the 3rd level has been set to zero.
level2InvT5 = idwt2(Approx3,Horizon1_3,zero_Vertical1_3,Diag1_3,'haar'); 
% Level 2 was reached by applying Reverse Wavelet.
level1InvT5 = idwt2(level2InvT5,Horizon1_2,Vertical1_2,Diag1_2,'haar');
% Level 1 was reached by applying Reverse Wavelet.
img1InvT5 = idwt2(level1InvT5,Horizon1,Vertical1,Diag1,'haar'); 
% The image was obtained again by applying the inverted wavelet.
figure
imshow(img1InvT5,[])
title('First Picture 3rd Level Vertical Frequency Component Removed')
