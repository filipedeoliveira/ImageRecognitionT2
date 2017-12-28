function  main_image_recognition( image )
path = fullfile(mfilename('class'),'output',image);
src_image =imread(path);
path_output = fullfile(mfilename('class'),'output');
image_name = image(1:end-4);

%------------------------------------FUN��O 1  ruido----------------------------------------
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
        gaussian_mean = input('Introduza a m�dia: ');
        image_gauss = imnoise(src_image,'gaussian',gaussian_mean,gaussian_variance);
        %figure,imshow(image_gauss);
        %title('Image with Gaussian Noise');
        
        output_name = strcat(image_name,'_gaussian_',num2str(gaussian_variance),num2str(gaussian_mean),'.jpg');
        imwrite(image_gauss,strcat(path_output,'/',output_name));
    end

%------------------------------------FUN��O 2 fazer pr� prossecamento ----------------------------------------
%1- filtering methods

%se foi introduzido ruido salt & papper usar median filter
if(n == 1)
    %SNR of the noisy image to verify the level of noise introduced;
    snr = SNR(src_image,image_salted);
    %fprintf('\n The SNR value is %0.4f \n', snr);
    
    image_median_filter = medfilt2(image_salted);
    figure
    subplot(1,2,1), imshow(image_salted), title('Image Salted');
    subplot(1,2,2), imshow(image_median_filter), title('Image Filtered using Median Filter');
    
%se foi intoduzido ruido gaussiano usar gaussian filter
elseif(n==2)
    %SNR of the noisy image to verify the level of noise introduced;
    snr = SNR(src_image,image_gauss);
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
Imagem_contraste = imadjust(image_to_use);

figure;
subplot(2,2,1), imshow(image_to_use);
title('Image Filtered');
subplot(2,2,2), imhist(image_to_use,64);
title('Image Filtered Histogram');
subplot(2,2,3), imshow(Imagem_contraste);
title('Image after adjust the contrast');
subplot(2,2,4), imhist(Imagem_contraste,64);
title('Histogram after adjust the contrast ');

% 3 - Normalizar 
Imagem_normalizada = mat2gray(Imagem_contraste);
output_name1 = strcat(image_name,'_Pre-processed','.jpg');
imwrite(Imagem_normalizada,strcat(path_output,'/',output_name1));

%------------------------------------FUN��O 3 segmenta��o ----------------------------------------
%use a sequence of functions that solves the task of segmenting all of the coins in the image

%-------HOUGH TRANSFORM----------------
%------------ Hough transform para imagem com ruido
%%Find Coins Lighter
[centers, radii] = imfindcircles(Imagem_normalizada,[60 90],'Sensitivity',0.9);
%Find Coins Darker
[centers1, radii1] = imfindcircles(Imagem_normalizada,[55 70],'ObjectPolarity','dark','Sensitivity',0.92);

A=[centers, radii];
B=[centers1, radii1];
C = vertcat(centers,centers1);
D=vertcat(radii,radii1);

% --------Hough transform para imagem sem ruido
%Find Coins Lighter
[centersO, radiiO] = imfindcircles(src_image,[60 90],'Sensitivity',0.9);
%Find Coins Darker
[centers1O, radii1O] = imfindcircles(src_image,[55 70],'ObjectPolarity','dark','Sensitivity',0.92);

E=[centersO, radiiO];
F=[centers1O, radii1O];
G = vertcat(centersO,centers1O);
H=vertcat(radiiO,radii1O);

%---- Imagem segmentada com e sem ruido
figure
subplot(1,2,1), imshow(src_image), h = viscircles(centers,radii), h1 = viscircles(G,H);
title('Segmented image without noise');
subplot(1,2,2), imshow(Imagem_normalizada),h2 = viscircles(centersO,radiiO) , h3 = viscircles(C,D);
title('Segmented image with noise');


%---------------Otsu's fazer----------



%------------------------------------FUN��O 4 total de moedas ----------------------------------------
%Number of Coins
n = numel(D);

%------------------------------------FUN��O 5 histogram  ----------------------------------------
%Show a histogram showing the distribution of object sizes. Either area or radius could be used as a size measure.
figure
histogram(D)
title('Histogram of Coins By Radius');

%------------------------------------FUN��O 6  ----------------------------------------
%Use a supervised approach (KNN or SVM) to classify the objects in the images,
%i.e., to identify the type of coins in the image. If necessary, use more images for the training phase.

%------------------------------------FUN��O 7 B�nus ----------------------------------------
%implement an algorithm that count the total amount of money.

end


