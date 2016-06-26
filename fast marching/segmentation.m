clear;
clc;

%img = im2double(imread('overwatch.png')); % Read image
img = im2double(imread('lena.tiff')); % Read image
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel

channels_mean = (red + green + blue) / 3;
symetric_sum = (red .* green .* blue) ./ (1 - red - green - blue + (red .* green) + (red .* blue) + (green .* blue));

red = symetric_sum;
green = symetric_sum;
blue = symetric_sum;

new_img = cat(3,red,green,blue);

image(new_img)

%Fast Marching - http://www.mathworks.com/help/images/ref/imsegfmm.html

%Create mask and specify seed location. You can also use roipoly to create the mask interactively.
mask = false(size(red));
%Definir o local da semente
mask(250,250) = true;

%Compute the weight array based on grayscale intensity differences.
W = graydiffweight(red, mask, 'GrayDifferenceCutoff', 25);

%Segment the image using the weights.
thresh = 0.01;
[BW, D] = imsegfmm(W, mask, thresh);
figure
imshow(BW)
title('Segmented Image')
