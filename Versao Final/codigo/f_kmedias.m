function g = f_kmedias(img, N)
%Kmedias: http://stackoverflow.com/questions/17379882/image-segmentation-using-k-means

[idx centroids] = kmeans(double(img(:)),N);
imseg = zeros(size(img,1),size(img,2));
for i=1:max(idx)
    imseg(idx==i)=i;
end
g = imseg
