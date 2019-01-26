function [Bimage,thresholdOtus]= otsu(ima)
[x,y] = size(ima);
Bimage = zeros(x,y);
totalPixels = x*y;
sumB = 0;
wB = 0;
maximum = 0.0;
threshold1 = 0.0;
threshold2 = 0.0;
%histogram generate

histogram = zeros(1,256);
for i = 1:x
    for j = 1:y
        gray_ID = ima(i,j);
        histogram(1,gray_ID+1) = histogram(1,gray_ID+1) + 1;
    end
end
histogram = histogram';
sum1 = sum((1:256).*histogram.');
for ii=1:256
    wB = wB + histogram(ii);
    
    wF = totalPixels - wB;
    if (wF == 0)
        break;
    end
    sumB = sumB +  ii * histogram(ii); 
    mB = (sumB / wB)-1;
    mF = (sum1 - sumB) / wF;
    between = wB * wF * (mB - mF) * (mB - mF);
    if ( between >= maximum )
        threshold1 = ii;
        if ( between > maximum )
            threshold2 = ii;
        end
        maximum = between;
    end
end
thresholdOtus = (threshold1 + threshold2 )/(2);
% thresholdOtus = 75;
for i=1:x
    for j = 1:y
      if (ima(i,j)<thresholdOtus)
          Bimage(i,j) = 0;
      else
          Bimage(i,j) = 1;
      end
    end
end
end 