function [ value_snr ] = SNR( Ioriginal, Inoise, Value )


img=Inoise;
img=double(img(:));
ima=max(img(:));
imi=min(img(:));
ims=std(img(:));
snr=10*log((ima-imi)./ims);

value_snr = snr;
  
end

