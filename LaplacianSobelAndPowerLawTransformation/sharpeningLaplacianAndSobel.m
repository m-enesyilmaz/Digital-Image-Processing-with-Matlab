%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

img = imread('pcb.png');

% Here is our problem:
% The details of the image lost as a result of blurring; revealing the details 
% by passing through image enrichment filters and returning them to 
% the closest form to the original.

% we convert the color image to gray level;
[rows, columns, numberOfColorChannels] = size(img);
% if the image is in color change it to gray:
if numberOfColorChannels > 1
    imgGray = rgb2gray(img); 
end

figure
imshow(imgGray,[])
title('Original Image')

% blur:
blurredIMG = imgaussfilt(imgGray,0.7);
figure
imshow(blurredIMG,[])
title('Blurred Image')

% The Laplacian filter is used to sharpen and define boundaries in the image. 
% It is based on second-order derivatives. Laplacian filter application 
% is made by taking the 2nd degree derivative. The process of applying 
% the Laplacian filter is to take the convolutions of the input image and 
% the laplacian mask. The resulting image is called a filtered image.

laplacianKernel1 = [0,-1,0;-1,4,-1;0,-1,0];
% laplacianKernel2 = [-1,-1,-1;-1,8,-1;-1,-1,-1];
% laplacianKernel3 = [1,1,1;1,-8,1;1,1,1];
laplacianImage = imfilter(double(blurredIMG), laplacianKernel1);
figure
imshow(laplacianImage, []);
title('Laplacian Image of Blurred Image');

% Humans are extremely sensitive to the edges and fine details of an image. 
% This is because edges and fine details are created by high-frequency components. 
% If we attenuate or remove the high-frequency components in the image, 
% the visual quality of our image will decrease accordingly. But if we consider 
% the reverse process, that is, if we improve the high-frequency components 
% in the image, this will lead to an improvement in visual quality. 
% Image sharpening refers to any enhancement technique that emphasizes and 
% enhances edges and fine details in an image.

sharpenedImage = double(blurredIMG) + laplacianImage;
figure
imshow(sharpenedImage, []);
title('Sharpened Image obtained by adding blurred image');

% The Sobel operator is used for edge detection applications. Identifies 
% discontinuities on the image. It is done by taking the first-order derivative 
% in mathematics to identify discontinuities and sudden changes. Gradient 
% concept is also used instead of first-degree derivative.

[magnitudeImage, directionImage] = imgradient(blurredIMG, 'Sobel');
figure
imshow(magnitudeImage, []);
title('Sobel Image of Blurred Image');

averageFilter = fspecial('average',[5 5]);
averageSobelImage = imfilter(magnitudeImage, averageFilter);
figure
imshow(averageSobelImage, [])
title('Blurred Sobel Image smoothed with a 5x5 averaging filter');

imgProduct = immultiply(averageSobelImage, sharpenedImage);
figure
imshow(imgProduct, [])
title('Mask image formed by the product of averageSobelImage and sharpenedImage');

sharpenedImage2 = double(blurredIMG) + imgProduct;
figure
imshow(sharpenedImage2, []);
title('Sharpened Image obtained by the sum of blurredIMG and imgProduct');

% Power Law Transformed Image
r = double(sharpenedImage2)/255;  % normalise the image
c = 1;  % constant
gamma = 0.5; % to make image dark take value of gamma > 1, to make image bright take value of gamma < 1
s = c*(r).^gamma;
figure
imshow(s, []);
title('Power Law Transformed Image');
