clear all
clc
orig = imread('ImgA000009.tif');
orig = imfilter(orig, fspecial('gaussian'));
[OtsuOut, Threshold] = OtsuCluter(orig);
DImage = imdilate(OtsuOut, strel('disk',12));
OtsuOut = imgaussfilt(OtsuOut,2);
OtsuOut = imerode(OtsuOut,strel('disk', 5));
[x,y] = size(OtsuOut);
for j = 1:y
  DistanceO(j) = sum(OtsuOut(:,j)); 
end
hold on
DImage = imgaussfilt(DImage,2);
for j = 1:y
  DistanceD(j) = sum(OtsuOut(:,j)); 
end
%get the non zero (above 220) value and then do the following things
[x,y] = size(DistanceO); %y is the dimention
counter = 0;
for i = 1:(y-500)
 if (DistanceD(i) >= 202)
     counter = counter + 1;
    Distance_Record(counter) = DistanceD(i); 
 end
end
%smooth the plot and then use polyfit
SmoothPlot = smooth(Distance_Record);
%generate x dimention axis
axis_X = 1:1:counter;
P = polyfit(axis_X, Distance_Record,4);
yi = polyval(P,axis_X);
plot(Distance_Record);
hold on
plot(axis_X, yi);



orig2 = imread('ImgA000008.tif');
orig2 = imfilter(orig2, fspecial('gaussian'));
[OtsuOut, Threshold] = OtsuCluter(orig2);
DImage = imdilate(OtsuOut, strel('disk',12));
OtsuOut = imgaussfilt(OtsuOut,2);
OtsuOut = imerode(OtsuOut,strel('disk', 5));
[x,y] = size(OtsuOut);
for j = 1:y
  DistanceO2(j) = sum(OtsuOut(:,j)); 
end
hold on
DImage = imgaussfilt(DImage,2);
for j = 1:y
  DistanceD2(j) = sum(OtsuOut(:,j)); 
end
%get the non zero (above 220) value and then do the following things
[x,y] = size(DistanceO2); %y is the dimention
counter = 0;
for i = 1:(y-500)
 if (DistanceD2(i) >= 202)
     counter = counter + 1;
    Distance_Record2(counter) = DistanceD2(i); 
 end
end
%smooth the plot and then use polyfit
SmoothPlot = smooth(Distance_Record2);
%generate x dimention axis
axis_X = 1:1:counter;
%P2 = polyfit(axis_X, Distance_Record2,15);
yi = polyval(P,axis_X);
figure(2)
plot(Distance_Record2);
hold on
plot(axis_X, yi);
