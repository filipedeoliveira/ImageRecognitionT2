function Otsu( image )
I= image;

n=imhist(I);
N=sum(n); 
max=0; 

for i=1:256
    P(i)=n(i)/N; 
end
%%================================================================================================
for T=2:255      
    w0=sum(P(1:T)); 
    w1=sum(P(T+1:256)); 
    u0=dot([0:T-1],P(1:T))/w0; 
    u1=dot([T:255],P(T+1:256))/w1; 
    sigma=w0*w1*((u1-u0)^2); 
    if sigma>max  
        max=sigma; 
        threshold=T-1; 
    end
end


bw=imbinarize(I,threshold/255); % Convert to Binary Image

figure;
subplot(2,2,1), imshow(I);
title('Otsu - Original Image');
subplot(2,2,2), imhist(I);
title('Otsu - Histogram');
subplot(2,2,3), imshow(bw);
title('Otsu - Binary Image');

end

