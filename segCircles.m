rgb = imread('Imagens/coins.jpg');
%figure
%imshow(rgb)

%d = imdistline;
%delete(d);

gray_image = rgb2gray(rgb);

%Find Coins Lighter
[centers, radii] = imfindcircles(gray_image,[60 90],'Sensitivity',0.9);
%Find Coins Darker
[centers1, radii1] = imfindcircles(gray_image,[55 70],'ObjectPolarity','dark','Sensitivity',0.92);

A=[centers, radii];
B=[centers1, radii1];
C = vertcat(centers,centers1);
D=vertcat(radii,radii1);

figure
imshow(rgb);
h = viscircles(centers,radii);
figure
imshow(rgb);
h1 = viscircles(C,D);

%Number of Coins
n = numel(D);

figure
histogram(D)
title('Histogram of Coins By Radius');

