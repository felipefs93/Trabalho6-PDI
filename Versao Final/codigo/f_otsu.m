function g = f_otsu(img)
level = graythresh(img);
g = im2bw(img, level);