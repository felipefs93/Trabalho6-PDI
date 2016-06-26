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


%OTSU: http://www.mathworks.com/help/images/ref/graythresh.html
level = graythresh(new_img);
BW = im2bw(new_img,level);
imshow(BW)