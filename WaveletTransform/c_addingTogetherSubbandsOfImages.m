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

% Taking one of the subbands of image 2 and adding it to image 1
% Let's find the 3rd level subbands of Image 2:
[img2Approx1,img2Horizon1,img2Vertical1,img2Diag1] = dwt2(im2double(img2),'haar');
% We applied level 1 haar transform to Image 2
[img2Approx2,img2Horizon1_2,img2Vertical1_2,img2Diag1_2] = dwt2(img2Approx1,'haar'); 
% We applied level 2 haar transform to Image 2
[img2Approx3,img2Horizon1_3,img2Vertical1_3,img2Diag1_3] = dwt2(img2Approx2,'haar'); 
% We applied level 3 haar transform to image 2

% When we add the LL3(low frequency) band of the second image to the LL3 of image 1
addApprox1_3Level3 = idwt2(img2Approx3,Horizon1_3,Vertical1_3,Diag1_3,'haar'); 
addApprox1_3Level2 = idwt2(addApprox1_3Level3,Horizon1_2,Vertical1_2,Diag1_2,'haar'); 
% Image change to occur
addApprox1_3 = idwt2(addApprox1_3Level2,Horizon1,Vertical1,Diag1,'haar');
figure
imshow(addApprox1_3,[])
title("When we add the LL3(low frequency) band of the second image to the LL3 of image 1")

% When we add the HH3 band of the second image to the HH3 of image 1
addDiag1_3Level3 = idwt2(Approx3,Horizon1_3,Vertical1_3,img2Diag1_3,'haar'); 
addDiag1_3Level2 = idwt2(addDiag1_3Level3,Horizon1_2,Vertical1_2,Diag1_2,'haar'); 
addDiag1_3 = idwt2(addDiag1_3Level2,Horizon1,Vertical1,Diag1,'haar'); 
figure
imshow(addDiag1_3,[])
title("When we add the HH3 band of the second image to the HH3 of image 1")

% When we add the LH1 band of the second image to the LH1 of image 1
addVertical1 = idwt2(Approx1,Horizon1,img2Vertical1,Diag1,'haar'); 
figure
imshow(addVertical1,[])
title("When we add the LH1 band of the second image to the LH1 of image 1")

% When we add the LH3 band of the second image to the LH3 of image 1
addVertical1_3Level3 = idwt2(Approx3,Horizon1_3,img2Vertical1_3,Diag1_3,'haar'); 
addVertical1_3Level2 = idwt2(addVertical1_3Level3,Horizon1_2,Vertical1_2,Diag1_2,'haar'); 
addVertical1_3 = idwt2(addVertical1_3Level2,Horizon1,Vertical1,Diag1,'haar'); 
figure
imshow(addVertical1_3,[])
title("When we add the LH3 band of the second image to the LH3 of image 1")
