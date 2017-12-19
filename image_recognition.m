clc    
addpath('Imagens/');
    S = '###### Seja bem vindo. Ecolha uma das seguintes imagens! ######';
    S2 = 'Imagens actuais da directoria  ==> Imagens <==';
    S4 = 'Até breve!';
    S5 = 'Nome inválido!';
addpath('Imagens/');

disp(S);
disp(S2);
dir 'Imagens'

sendImage = input('Exemplo:       coins.jpg -> ');
Image = imread(sendImage);

%In the script, you should create the grey-scale image before running the function “main_image_recognition.m”
Image_to_send = rgb2gray(Image);
b = sendImage(1:end-4);

%temos de guardar a imagem a preto e branco na pasta para depois a função
%ir la buscar
%path_image_to_send = fullfile(mfilename('class'),'Imagens');
path_image_to_send = fullfile(mfilename('class'),'output');
output_name = strcat(b,'_grayscale.jpg');
imwrite(Image_to_send,strcat(path_image_to_send,'/',output_name));

main_image_recognition(output_name);