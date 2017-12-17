function  main_image_recognition( image )
path = fullfile(mfilename('class'),'Imagens',image);
src_image =imread(path);
path_output = fullfile(mfilename('class'),'output');
image_name = image(1:end-4);

%------------------------------------FUNÇÃO 1  ruido----------------------------------------
%Your program should ask to the user the type of noise to be added separately to the input
%image: salt-an-pepper or gaussian noise.

    n = input('Para indtroduzir ruido Salt & pepper carrege 1, para Gaussiano introduza 2-> ');
    if(n == 1)
        d = input('Introduza valor da densidade: ');
        image_salted = imnoise(src_image,'salt & pepper',d);
        figure, imshow(image_salted);
        title('Salt & pepper Noise');
        
    elseif(n == 2)
        gaussian_variance = input('Introduza valor da variancia : ');
        gaussian_mean = input('Introduza a média: ');
        image_gauss = imnoise(src_image,'gaussian',gaussian_mean,gaussian_variance);
        figure,imshow(image_gauss);
        title('Gaussian Noise');
    end

%--------------------FAZER--------------------------------
%SNR of the noisy image to verify the level of noise introduced;
    
    
%------------------------------------FUNÇÃO 2 fazer pré prossecamento ----------------------------------------
%Process the image, when necessary, using pre-processing techniques, such as filtering methods,
%contrast equalization, normalization, among other techniques.

%------------------------------------FUNÇÃO 3 segmentação ----------------------------------------
%use a sequence of functions that solves the task of segmenting all of the coins in the image

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

