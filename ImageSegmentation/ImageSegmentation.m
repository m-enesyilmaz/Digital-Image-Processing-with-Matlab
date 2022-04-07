%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

img1 = imread('manzara.jpeg');
img2 = imread('at.jpeg'); 
img3 = imread('baykus.jpeg');
img4 = imread('kurt.jpeg');

% The purpose of segmentation is to simplify and/or transform the representation of 
% an image into something more meaningful and easier to analyze. Image segmentation 
% is often used to find objects and boundaries (lines, curves, etc.) in images. 
% In general, segmentation algorithms for grayscale images are designed based on 
% one of two basic properties of gray level values. These features are related to 
% discontinuity and similarity in gray level values in the image. 

% we plot the images, we read
figure 
imshow(img1,[])
title('\fontsize{16} Background Image')
figure 
imshow(img2,[])
title('\fontsize{16} Image With The Horse In It')
figure 
imshow(img3,[])
title('\fontsize{16} Image With an Owl Inside')
figure 
imshow(img4,[])
title('\fontsize{16} Image With The Wolf In It')

% Edge detection is one of the fundamental issues in image processing. 
% The edge in an image corresponds to a significant change in the physical 
% appearance of an image, such as illumination or surface reflections, which 
% manifests itself in brightness, color, and texture.

% Active contour is one of the segmentation techniques that uses energy 
% constraints and forces in the image to separate the region of interest from 
% the image. This method defines a separate boundary or curvature for 
% the regions of the target object to be used in segmentation. Contours are 
% boundaries designed for desired relevant areas in an image and are the sum of 
% the points that have undergone the interpolation process. The interpolation 
% operation can be linear, curved, and polynomial, which defines the curve 
% in the image. Different active contour models are applied in image processing. 
% These define the smooth shape for the image and create a closed border for 
% the region. The curvature of the contour models is determined using various 
% algorithms using external and internal forces applied. External energy is 
% defined as the combination of internal energy used to control the formal 
% changes of the borders surrounding the image and image-induced forces 
% used to control the position of the borders on the image. The desired 
% contour is achieved by using the minimum of functional energy.

% We create a mask in the frame we have determined;
mask1 = zeros(size(img2,1), size(img2,2));
mask1(120:end-150,75:end-85) = 1; % we give the values according to our image
% BW = activecontour(A,mask,n) segments the image, enhancing the contour for a maximum of n iterations.
snake1 = activecontour(img2, mask1, 200);
% We apply the segmented image to its own image;
bn1 = uint8(snake1.*double(img2));

% We create a mask in the frame we have determined;
mask2 = zeros(size(img3,1), size(img3,2));
mask2(110:end-110,85:end-85) = 1; % we give the values according to our image
% BW = activecontour(A,mask,n) segments the image, enhancing the contour for a maximum of n iterations.
snake2 = activecontour(img3, mask2, 250); 
% We apply the segmented image to its own image;
bn2 = uint8(snake2.*double(img3));

% We create a mask in the frame we have determined;
mask3 = zeros(size(img4,1), size(img4,2));
mask3(25:end-75,65:end-90) = 1; % we give the values according to our image
% BW = activecontour(A,mask,n) segments the image, enhancing the contour for a maximum of n iterations.
snake3 = activecontour(img4, mask3, 150);
% We apply the segmented image to its own image;
bn3 = uint8(snake3.*double(img4));

m(1024,1638) = 0; % we created zero matrix in background image dimensions
m1 = bn1;
m2 = logical(m);
% We select the pixels on which we want to place our image;
m2(601:1000,1001:1400) = snake1;
m1(1:400,1:400,1:3) = 0;
m1 = imresize(m1,[1024 1638]);
m1(601:1000,1001:1400,1:3) = bn1;

snake2 = imresize(snake2,[280 484]);
bn2 = imresize(bn2,[280 484]);
m3 = bn2;
m4 = logical(m);
% We select the pixels on which we want to place our image;
m4(1:280,1:484) = snake2; 
m3(1:1024,1:1638,1:3) = 0;
m3(1:280,1:484,1:3) = bn2; 

snake3 = imresize(snake3,[250 250]);
bn3 = imresize(bn3,[250 250]);
m5 = bn3;
m6 = logical(m);
% We select the pixels on which we want to place our image;
m6(651:900,401:650) = snake3;
m5(1:1024,1:1638,1:3) = 0;
m5(651:900,401:650,1:3) = bn3; 

% Merge all images
backgroundNew = imresize(img1,[size(m,1) size(m,2)]);
whiteImg = uint8(ones(size(m)));
m7 = m1+m3+m5; % we collect segmented versions of pictures (combine them in a common frame)
m8 = m2+m4+m6; % combining segmented binaries of images
seg1 = imcomplement(m8);
seg1 = im2uint8(seg1);
finalImg = uint8(seg1&backgroundNew);
finalImg = (backgroundNew.*finalImg)+m7;

% Advantages of contours;
% In search of minimum energy; autonomous and self-adaptive.
% Ability to follow moving objects in both temporal (timewise) and spatial directions.
% Specific energies can be identified to enhance contour development.
% Limitations of contours;
% It can get stuck at local minimum points.
% In the process of minimizing the entire contour energy, the smallest features can be overlooked.
% May require higher computation time.

figure
subplot(2,2,1) 
imshow(img2)
title('\fontsize{14} Original image with mask'); 
hold on
visboundaries(mask1,'Color','g','LineStyle','-', 'LineWidth',4);
hold off

subplot(2,2,2)
imshow(img2)
title('\fontsize{14} Original image with segmented mask'); 
hold on
visboundaries(snake1,'Color','g','LineStyle','-','LineWidth',4);
hold off

subplot(2,2,3);
imshow(snake1) 
title('\fontsize{14} Segmented binary image');

subplot(2,2,4);
imshow(uint8(bn1)) 
title('\fontsize{14} Segmented image');

figure
subplot(2,2,1) 
imshow(img3)
title('\fontsize{14} Original image with mask'); 
hold on
visboundaries(mask2,'Color','g','LineStyle','-', 'LineWidth',4);
hold off

subplot(2,2,2)
imshow(img3)
title('\fontsize{14} Original image with segmented mask'); 
hold on
visboundaries(snake2,'Color','g','LineStyle','-','LineWidth',4);
hold off

subplot(2,2,3);
imshow(snake2) 
title('\fontsize{14} Segmented binary image');

subplot(2,2,4);
imshow(uint8(bn2)) 
title('\fontsize{14} Segmented image');

figure
subplot(2,2,1)
imshow(img4)
title('\fontsize{14} Original image with mask'); 
hold on
visboundaries(mask3,'Color','g','LineStyle','-', 'LineWidth',4);
hold off

subplot(2,2,2)
imshow(img4)
title('\fontsize{14} Original image with segmented mask'); 
hold on
visboundaries(snake3,'Color','g','LineStyle','-','LineWidth',4);
hold off

subplot(2,2,3);
imshow(snake3) 
title('\fontsize{14} Segmented binary image');

subplot(2,2,4);
imshow(uint8(bn3)) 
title('\fontsize{14} Segmented image');

figure
imshow(finalImg);
title('\fontsize{16} Merged All Images')
