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
%    for j = 1:y
%       DistanceO(j) = sum(OtsuOut(:,j)); 
%    end
%    plot(DistanceO);
%    legendID = 'Image_';
%    legendID = [legendID, int2str(fileID)];
%    legend(legnedID);
   hold on
   DImage = imgaussfilt(DImage,2);
   for j = 1:y
      DistanceD(j) = sum(OtsuOut(:,j)); 
   end
   plot(DistanceD)
   hold on
end