clear all
clc
for i=1:10
   fileID = i -1;
   string = 'ImgA00000';
   string = [string, int2str(fileID), '.tif'];
   orig = imread(string);
   orig = imfilter(orig, fspecial('gaussian'));
   [OtsuOut, Threshold] = OtsuCluter(orig);
   DImage = imdilate(OtsuOut, strel('disk',12));
   OtsuOut = imgaussfilt(OtsuOut,2);
   OtsuOut = imerode(OtsuOut,strel('disk', 5));
   [x,y] = size(OtsuOut);
   hold on
   DImage = imgaussfilt(DImage,2);
   for j = 1:y
      DistanceD(j) = sum(OtsuOut(:,j)); 
   end   
    [x,y] = size(DistanceD); %y is the dimention
    counter = 0;
    for m = 1:(y-500)
        if (DistanceD(m) >= 202)
            counter = counter + 1;
            Distance_Record(i, counter) = DistanceD(m); 
        end
    end
end


Axis_X = 1:1:922;
Distance_Record = Distance_Record(:,1:922);
%Distance_Record is the data need to be fitting into the curve
%get the mean of each colonm
Axis_Y = mean(Distance_Record(:,1:922));
Axis_Y = smooth(Axis_Y);
PM = polyfit(Axis_X/200, Axis_Y'/200, 7);
yp = polyval(PM, Axis_X/200);
yp = yp;
figure(1)
plot(Axis_X/200, yp,'LineWidth', 3);
hold on;
for i=1:1:10
   plot(Axis_X/200,(Distance_Record(i,:)/200))
   hold on;
end
yp = yp + 0.1;
yp2 = yp - 0.2;

plot(Axis_X/200,yp,'LineWidth', 3);
hold on;
plot(Axis_X/200, yp2,'LineWidth',3);

