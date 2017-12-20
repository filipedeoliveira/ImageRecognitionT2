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

%--------------------FAZER--------------------------------
%SNR of the noisy image to verify the level of noise introduced;

    %linha 18  e 33
%------------------------------------FUN��O 2 fazer pr� prossecamento ----------------------------------------
%1- filtering methods

%se foi introduzido ruido salt & papper usar median filter
if(n == 1)
    snr = SNR(src_image,image_salted,0);
    fprintf('\n The SNR value is %0.4f \n', snr);
    
    image_median_filter = medfilt2(image_salted);
    figure
    subplot(1,2,1), imshow(image_salted), title('Image Salted');
    subplot(1,2,2), imshow(image_median_filter), title('Image Filtered using Median Filter');
%se foi intoduzido ruido gaussiano usar gaussian filter
elseif(n==2)
    snr = SNR(src_image,image_gauss,0);
    fprintf('\n The SNR value is %0.4f \n', snr);
    
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
%usando fun��o imadjust
image_contrast = imadjust(image_to_use);
figure
subplot(1,2,1), imshow(image_to_use), title('Image Filtered');
subplot(1,2,2), imshow(image_contrast), title('Contrast adjusted using function "imadjust"');
% usando Histogram Equalization
Hist = histeq(image_to_use);

figure;
subplot(2,2,1), imshow(image_to_use);
title('Image Filtered');
subplot(2,2,2), imhist(image_to_use,64);
title('Image Filtered Histogram');
subplot(2,2,3), imshow(Hist);
title('Image after histogram equalization');
subplot(2,2,4), imhist(Hist,64);
title('Image after histogram equalization Histogram');


%------------------------------------FUN��O 3 segmenta��o ----------------------------------------
%use a sequence of functions that solves the task of segmenting all of the coins in the image
image_to_use = Hist;
%Prewitt
BW1 = edge(image_to_use,'Prewitt');
%Sobel
BW2 = edge(image_to_use,'Sobel');
%canny 
BW3 = edge(image_to_use,'Canny');
figure;
subplot(2,2,1), imshow(BW1);
title('Prewitt');
subplot(2,2,2), imshow(BW2);
title('Sobel');
subplot(2,2,3), imshow(BW3);
title('Canny');
subplot(2,2,4), imshow(image_to_use);
title('Original');

Hough(image_to_use,10,7,5);


HoughTransformCircles(image_to_use);


%------------------------------------FUN��O 4 total de moedas ----------------------------------------
%Count the total number of coins in the image.

%------------------------------------FUN��O 5 histogram  ----------------------------------------
%Show a histogram showing the distribution of object sizes. Either area or radius could be used as a size measure.

%------------------------------------FUN��O 6  ----------------------------------------
%Use a supervised approach (KNN or SVM) to classify the objects in the images,
%i.e., to identify the type of coins in the image. If necessary, use more images for the training phase.

%------------------------------------FUN��O 7 B�nus ----------------------------------------
%implement an algorithm that count the total amount of money.

end

