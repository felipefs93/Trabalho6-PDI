function g = f_fast(img, thresh)
%Fast Marching - http://www.mathworks.com/help/images/ref/imsegfmm.html

%Create mask and specify seed location. You can also use roipoly to create the mask interactively.
mask = false(size(img));
%Definir o local da semente
[rows columns numberOfColorChannels] = size(img);
y_center = round(rows / 2); x_center = round(columns / 2);
mask(x_center,y_center) = true;
%Compute the weight array based on grayscale intensity differences.
W = graydiffweight(img, mask, 'GrayDifferenceCutoff', 25);
%Segment the image using the weights.
[g, D] = imsegfmm(W, mask, thresh);


