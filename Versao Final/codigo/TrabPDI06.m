%Trabalho PDI 6 - Segmenta��o de Imagens

%--Inicializa��o--%
clear; clc;


%--Combina��o de Bandas--%

%Decomposi��o da imagem em suas tr�s componentes RGB
img = im2double(imread('celula.jpg'));

red = img(:,:,1); % Matriz de tons vermelhos
green = img(:,:,2); % Matriz de tons verdes
blue = img(:,:,3); % Matriz de tons azuis

%M�dia dos tons RGB
imgmedia = (red + green + blue) / 3;
subplot(2,6,1);  imshow(imgmedia); title('Media de tons'); 

%Soma Sim�trica dos tons RGB
imgsoma = (red .* green .* blue) ./ (1 - red - green - blue + (red .* green) + (red .* blue) + (green .* blue));
subplot(2,6,7);  imshow(imgsoma); title('Soma de tons');


%--Segmenta��o--%

%T�cnica: Otsu
otsuimage = f_otsu(imgmedia);
subplot(2,6,2); imshow(otsuimage); title('Otsu');

otsuimage = f_otsu(imgsoma);
subplot(2,6,8); imshow(otsuimage); title('Otsu');

%T�cnica: Renyi
renyiimg = f_renyi(imgmedia, 0.1);
subplot(2,6,3); imshow(renyiimg); title('Renyi');

renyiimg = f_renyi(imgsoma, 0.1);
subplot(2,6,9); imshow(renyiimg); title('Renyi');

%T�cnica: Crescimento de regi�o
[rows columns numberOfColorChannels] = size(imgmedia);
y_center = round(rows / 2); x_center = round(columns / 2);
rgrowimg = f_regiongrowing(imgmedia, x_center, y_center, 0.2);
subplot(2,6,4); imshow(rgrowimg + imgmedia); title('Crescimento de Regi�o');

[rows columns numberOfColorChannels] = size(imgsoma);
y_center = round(rows / 2); x_center = round(columns / 2);
rgrowimg = f_regiongrowing(imgsoma, x_center, y_center, 0.2);
subplot(2,6,10); imshow(rgrowimg + imgsoma); title('Crescimento de Regi�o');

%T�cnica: K-m�dias
kmedimg = f_kmedias(imgmedia, 2);
subplot(2,6,5); imagesc(kmedimg); title('K-m�dias');

kmedimg = f_kmedias(imgsoma, 2);
subplot(2,6,11); imagesc(kmedimg); title('K-m�dias');

%T�cnica: Fast Marching
fastimg = f_fast(imgmedia, 0.01);
subplot(2,6,6); imshow(fastimg); title('Fast Marching');

fastimg = f_fast(imgsoma, 0.01);
subplot(2,6,12); imshow(fastimg); title('Fast Marching');

