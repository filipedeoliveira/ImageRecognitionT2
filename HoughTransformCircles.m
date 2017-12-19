function HoughTransformCircles( image )

imshow(image);
title('Moedassss');


[centers, radii, metric] = imfindcircles(image,[15 30]);

ccentersStrong5 = centers(1:5,:); 
radiiStrong5 = radii(1:5);
metricStrong5 = metric(1:5);

viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');

end

