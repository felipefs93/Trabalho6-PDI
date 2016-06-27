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



%Kmedias: http://stackoverflow.com/questions/17379882/image-segmentation-using-k-means
N = 2; %Número de clusters
[idx centroids]=kmeans(double(red(:)),N);
imseg = zeros(size(red,1),size(red,2));
for i=1:max(idx)
    imseg(idx==i)=i;
end
a = imagesc(0,0,imseg)

dice = 2*nnz(a&red)/(nnz(a) + nnz(red))
