function  main_image_recognition( image )
path = fullfile(mfilename('class'),'output',image);
src_image =imread(path);
path_output = fullfile(mfilename('class'),'output');
image_name = image(1:end-4);
warning('off', 'Images:initSize:adjustingMag');
captionFontSize = 14;


%------------------------------------FUNÇÃO 1  ruido----------------------------------------
%Your program should ask to the user the type of noise to be added separately to the input
%image: salt-an-pepper or gaussian noise.

    n = input('Para indtroduzir ruido Salt & pepper carrege 1, para Gaussiano introduza 2-> ');
    if(n == 1)
        d = input('Introduza valor da densidade: ');
        image_salted = imnoise(src_image,'salt & pepper',d); 
        %figure, imshow(image_salted);
        %title('Image with Salt & pepper Noise');
        
        output_name = strcat(image_name,'_salt&pepper_',num2str(d),'.jpg');
        imwrite(image_salted,strcat(path_output,'/',output_name));

        
        
    elseif(n == 2)
        gaussian_variance = input('Introduza valor da variancia : ');
        gaussian_mean = input('Introduza a média: ');
        image_gauss = imnoise(src_image,'gaussian',gaussian_mean,gaussian_variance);
        %figure,imshow(image_gauss);
        %title('Image with Gaussian Noise');
        
        
        
        output_name = strcat(image_name,'_gaussian_',num2str(gaussian_variance),num2str(gaussian_mean),'.jpg');
        imwrite(image_gauss,strcat(path_output,'/',output_name));
        
        
    end

%--------------------FAZER--------------------------------
%SNR of the noisy image to verify the level of noise introduced;

    %feito mais abaixo
%------------------------------------FUNÇÃO 2 fazer pré prossecamento ----------------------------------------
%1- filtering methods

%se foi introduzido ruido salt & papper usar median filter
if(n == 1)
    snr = SNR(src_image,image_salted,0);
    %fprintf('\n The SNR value is %0.4f \n', snr);
    
    image_median_filter = medfilt2(image_salted);
    figure
    subplot(1,2,1), imshow(image_salted), title('Image Salted');
    subplot(1,2,2), imshow(image_median_filter), title('Image Filtered using Median Filter');
%se foi intoduzido ruido gaussiano usar gaussian filter
elseif(n==2)
    snr = SNR(src_image,image_gauss,0);
    %fprintf('\n The SNR value is %0.4f \n', snr);
    
    sigma=1; %mexer no valor se sigma ex. 2,3 para ver qual tem melhor resultado
    image_gaussian_filter = imgaussfilt(image_gauss,sigma);
    figure
    subplot(1,2,1), imshow(image_gauss), title('Image Gaussian noise');
    subplot(1,2,2), imshow(image_gaussian_filter), title('Image Filtered using Gaussian Filter');
end

%Contrast equalization
if(n==1) image_to_use = image_median_filter;
elseif(n==2) image_to_use = image_gaussian_filter;
end
% 2 Histogram Equalization
Imagem_contraste = histeq(image_to_use);

figure;
subplot(2,2,1), imshow(image_to_use);
title('Image Filtered');
subplot(2,2,2), imhist(image_to_use,64);
title('Image Filtered Histogram');
subplot(2,2,3), imshow(Imagem_contraste);
title('Image after histogram equalization');
subplot(2,2,4), imhist(Imagem_contraste,64);
title('Histogram equalization ');

% 3 - Normalizar 
Imagem_normalizada = mat2gray(Imagem_contraste);
figure;
imshow(Imagem_normalizada);
title('Imagem normalizda');

%4 threshold the image to get a binary image (only 0's and 1's)using im2bw()
     normalizedThresholdValue = 0.45; % In range 0 to 1.
      thresholdValue = normalizedThresholdValue * max(max(Imagem_normalizada)); 
      binaryImage = im2bw(Imagem_normalizada, normalizedThresholdValue);       
      binaryImage = Imagem_normalizada < thresholdValue; 
      binaryImage = imfill(binaryImage, 'holes');
      figure;
      imshow(binaryImage);
      title('binary');

      labeledImage = bwlabel(binaryImage, 8);  
      tamanhoMoeadas = regionprops(labeledImage, Imagem_normalizada, 'all');
      numberOfBlobs = size(tamanhoMoeadas, 1);

figure;
imshow(Imagem_normalizada);
title('Outlines, from bwboundaries()', 'FontSize', captionFontSize); 
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
hold on;
boundaries = bwboundaries(binaryImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
	plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;


  
%------------------------------------FUNÇÃO 3 segmentação ----------------------------------------
%use a sequence of functions that solves the task of segmenting all of the coins in the image

%Otsu's fazer

%K-MEANS - não esta a funcionar
%img_as_col = double(Imagem_normalizada(:));
%cluster_menbs = kmeans(img_as_col, 2,'distance', 'sqeuclidean');
%labelim = zeros(size(img_as_col));
%for i=1:3
%    inds = find(cluster_menbs==i);
%    meanval = mean(img_as_col(inds));
%    labelim(inds) = meanval;
%end
%figure
%imshow(labelim, []);

%Hough(image_to_use,10,7,5);
%HoughTransformCircles(src_image);


%------------------------------------FUNÇÃO 4 total de moedas ----------------------------------------
%Count the total number of coins in the image.

%------------------------------------FUNÇÃO 5 histogram  ----------------------------------------
%Show a histogram showing the distribution of object sizes. Either area or radius could be used as a size measure.

%------------------------------------FUNÇÃO 6  ----------------------------------------
%Use a supervised approach (KNN or SVM) to classify the objects in the images,
%i.e., to identify the type of coins in the image. If necessary, use more images for the training phase.

%------------------------------------FUNÇÃO 7 Bónus ----------------------------------------
%implement an algorithm that count the total amount of money.

end


