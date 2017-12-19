function SNR( Ioriginal, Inoise, Value )


%Load single MRI image
I = Ioriginal;

% addition of graininess (i.e. noise)
I_noise = Inoise;

% the average of 3^2, or 9 values(filters the multidimensional array A with the multidimensional filter h)
 h = ones(3,3) / 3^2; 
 I2 = imfilter(I_noise,h); 
% Measure signal-to-noise ratio
img=I_noise;
img=double(img(:));
ima=max(img(:));
imi=min(img(:));
mse=std(img(:));
snr2=20*log10((ima-imi)./mse);
% Measure Peak SNR
[peaksnr, snr2] = psnr(I_noise, I);
%fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
fprintf('\n The SNR value is %0.4f \n', snr2);
%fprintf('\n The MSE value is %0.4f \n', mse);
   %Plot original & filtered figure
   subplot(1,2,2), imshow(I), title('Filtered image')
   subplot(1,2,1), imshow(I_noise), title('Noise image')   
    text(size(I,2),size(I,1)+15, ...
      'Gaussian = 0.09', ...
      'FontSize',10,'HorizontalAlignment','right');
  
end

