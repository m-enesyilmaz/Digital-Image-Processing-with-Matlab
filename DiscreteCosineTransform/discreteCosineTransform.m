%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Muhammed Enes Yılmaz                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear

% The Discrete Cosine Transform (DCT) expresses a finite set of data points 
% as a sum of cosine functions oscillating at different frequencies. DCT is a 
% conversion technique widely used in signal processing and data compression. 
% DCTs are important for many other applications in science and engineering, 
% such as digital signal processing, telecommunications equipment, reducing 
% network bandwidth usage, and spectral methods for the numerical solution 
% of partial differential equations. 

% Discrete Fourier Transform (DFT) and Discrete Cosine Transform (DCT) perform 
% similar functions; both split a finite-length discrete time vector into 
% the sum of scaled and shifted basis functions. The difference between 
% the two is the type of base function used by each conversion. DFT uses a 
% set of complex exponential functions that are harmonically related, while 
% DCT uses only (real-valued) cosine functions.

% Discrete Cosine Transform (DCT) is a lossy compression method.

% Since DCT is orthogonal, the inverse kernel is equal to the forward kernel. 
% It is more traceable than Fourier because the values move in a zig-zag pattern.

img1 = imread('buyuk_resim.png'); % We read an image in the folder where the code is located.
img2 = imread('kucuk_resim_50x50.png');
% we got the size of the image
% numberOfColorBands = 1
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
% We draw the image we read
subplot(2,2,1)
imshow(img1) 
title('First Image(300x300)')
subplot(2,2,2)
imshow(img2) 
title('Second Image(50x50)')
subplot(2,2,3)
imshow(img1Gray)
title('First Image Gray Level')
subplot(2,2,4)
imshow(img2Gray) 
title('Second Image Gray Level')

% Discrete Cosine Transformations of Images:
img1_DCT = dct2(img1Gray);
img2_DCT = dct2(img2Gray);

% DCT Inverse of Image:
img1_inv_DCT = idct2(img1_DCT);
img2_inv_DCT = idct2(img2_DCT);

figure
subplot(1,2,1)
imshow(log(abs(img1_DCT)),[])
title("2D DCT of the image")
subplot(1,2,2)
imshow(img1_inv_DCT,[])
title("2D Inverted DCT of the image")

figure
subplot(1,2,1)
imshow(log(abs(img2_DCT)),[])
title("2D DCT of the second Image")
subplot(1,2,2)
imshow(img2_inv_DCT,[])
title("2D Inverted DCT of the second Image")

% Removing the DC Term from DCT:
img1_DCT_no_DC = img1_DCT;
img1_DCT_no_DC(1,1) = 0; % We make the first element of the matrix (DC term) zero.

% Finding the Inverse of the DC Term Removed DCT Matrix:
img1_inv_DCT_no_DC = idct2(img1_DCT_no_DC);

figure
subplot(1,2,1)                              
imshow(log(abs(img1_DCT_no_DC)),[])
title('Removed DC Term from DCT Matrix')
subplot(1,2,2)                             
imshow(img1_inv_DCT_no_DC)
title('Inverse of Removed DC Term from DCT Matrix')

% Zero First 20% of Image:
img1_DCT_ilk20 = img1_DCT; % We assign the first image to the variable that we will process.
i=0;
j=0;
% sqrt(0.2)*300((number of pixels)) = 134
% We make this field zero:
for i=1:134
   for j=1:134
       img1_DCT_ilk20(i,j) = 0;
   end
end

% The inverse of the matrix with the first 20% zero:
img1_inv_DCT_ilk20 = idct2(img1_DCT_ilk20);

figure
subplot(1,2,1)                                 
imshow(log(abs(img1_DCT_ilk20)),[])
title("Zero First 20% of DCT Matrix")
subplot(1,2,2)                                
imshow(img1_inv_DCT_ilk20)
title("Inverse of matrix with zero first 20% in DCT Matrix")

% Zero 30% after the first 20% of the image
img1_DCT_from_20plus30 = img1_DCT; % We assign the first image to the variable that we will process.
i=0;
j=0;
% sqrt(0.2)*300((number of pixels)) = 134 ==> %20
% sqrt(0.5)*300((number of pixels)) = 212 ==> %50
for i=134:212
   for j=1:212
       img1_DCT_from_20plus30(i,j) = 0;
   end
end
for j=134:212
   for i=1:212
       img1_DCT_from_20plus30(i,j) = 0;
   end
end

% Inverse Matrix of Zeroes of 30% After First 20% of Image:
img1_inv_DCT_from_20plus30 = idct2(img1_DCT_from_20plus30);

figure
subplot(1,2,1)                               
imshow(log(abs(img1_DCT_from_20plus30)),[])
title("After the first 20%, the next 30% is zero")
subplot(1,2,2);                                 
imshow(img1_inv_DCT_from_20plus30)
title("Inverse of After the first 20%, the next 30% is zero")

% The last 30% of the image is zero
img1_DCT_from_70to100 = img1_DCT; % We assign the first image to the variable that we will process.
i=0;
j=0;
% sqrt(0.7)*300((number of pixels)) = 250 ==> %70
% sqrt(1)*300((number of pixels)) = 300 ==> %100
for i=250:300
   for j=250:300
       img1_DCT_from_70to100(i,j) = 0;
   end
end

% The inverse of the matrix with the last 30% zero:
img1_inv_DCT_from_70to100 = idct2(img1_DCT_from_70to100);

figure
subplot(1,2,1)                                 
imshow(log(abs(img1_DCT_from_70to100)),[])
title("The last 30% of the DCT matrix is zero")
subplot(1,2,2)                              
imshow(img1_inv_DCT_from_70to100)
title("Inverse of The last 30% of the DCT matrix is zero")


% Including the First 30% of the Second Image's DCT Matrix in the first 
% part of the first image's DCT matrix:
i=0;
j=0;
img1_DCT_added = img1_DCT;
% sqrt(0.3)*50((number of pixels)) = 27
for i=1:27
   for j=1:27
       img1_DCT_added(i,j) = img1_DCT(i,j) + img2_DCT(i,j);
   end
end

% Inverse of Added Matrix:
img1_inv_DCT_added = idct2(img1_DCT_added);

figure
subplot(1,2,1)                                
imshow(log(abs(img1_DCT_added)),[])
title("First 30% of Second Image's DCT Matrix + First Image's DCT Matrix");
subplot(1,2,2)
imshow(img1_inv_DCT_added,[])
title("First 30% of Second Image + Reverse of First Image Inserted")

% Inclusion of the last 30% of the DCT matrix of the second image in the 
% last 30% of the DCT matrix of the first image:
i=0;
j=0;
img1_DCT_added_2 = img1_DCT;
% sqrt(0.7)*50 = 41
% sqrt(1)*50 = 50
for i=41:50
   for j=41:50 
       img1_DCT_added_2(250+i,250+j) = img1_DCT(250+i,250+j) + img2_DCT(i,j);
   end
end

% Inverse of Added Matrix
img1_inv_DCT_added_2 = idct2(img1_DCT_added_2);

figure
subplot(1,2,1)                            
imshow(log(abs(img1_DCT_added_2)),[])
title("Last 30% of Second Image's DCT Matrix + Addition of First Image to last 30% of DCT Matrix");
subplot(1,2,2)
imshow(img1_inv_DCT_added_2,[])
title("Inverse of; Last 30% of Second Image + First Image Added to Last 30%")

% Discrete Cosine Transform (DCT) is one of the methods we use for better 
% image processing and fast computation. It is preferred for its speed, 
% ease of operation, traceability, energy compression and energy conservation 
% features. It is often used in applications such as image and audio compression, 
% as well as in areas such as digital signal processing and reducing network bandwidth usage.
