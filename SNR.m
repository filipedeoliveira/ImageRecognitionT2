function [ value_snr ] = SNR( Ioriginal, Inoise, Value )


img=Inoise;
img=double(img(:));
ima=max(img(:));
imi=min(img(:));
ims=std(img(:));
snr=20*log10((ima-imi)./ims);

value_snr = snr;

peaksnr = psnr(Inoise,Ioriginal);

imshow(Inoise);
title([' Noise Image -> ','Value SNR: ',num2str(value_snr),'       Value PSNR: ',num2str(peaksnr)]);
  
end

