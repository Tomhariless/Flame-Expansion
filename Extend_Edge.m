clear all;
clc;
%%
%normal way of getting the edge of the flame
orig = imread('ImgA000000.tif');
orig = imfilter(orig, fspecial('gaussian'));
figure(3)
imshow(orig);
%dilate image
DImage = imdilate(orig, strel('disk',5));
figure(4)
imshow(DImage);
GImage = sobel(DImage);
figure(5)
imshow(GImage,[0 255]);
%erode the Gimage
EImage = imerode(GImage,strel('disk', 3));
EImage = imdilate(EImage, strel('disk',3));
%threshold
[OtsuOut Threshold] = OtsuCluter(EImage);

%get the final edge
FImage = imerode(OtsuOut, strel('disk',5));
figure(6)
imshow(FImage);
%%
%remove the reflection and then get the flame
orig = imread('ImgA000000.tif');
orig = im2double(orig);
[x, y] = size(orig);
counter_Upper = 0;
counter_Lower = 0;
Detected_Flame = zeros(x,y);
for i = 500:y
   %get the detecting colunm
   Detect_Col = orig(:,i)*255;
%    %get the bright 255 part index
   Upper_flame_index= GetIndex(Detect_Col);
   Lower_flame_index= GetLowerIndex(Detect_Col);
%    Upper_flame_index= 330;
%    Lower_flame_index= 440;
   %get the upper bound and lower bound of the detect_Col
   Upper_Detect_Col = Detect_Col(1:Upper_flame_index, :);
   Lower_Detect_Col = Detect_Col(Lower_flame_index:x, :);
   %reverse the upper detect col
   Upper_Detect_Col_Reverse = Reverse_Col(Upper_Detect_Col);
   Lower_Detect_Col_Reverse = Reverse_Col(Lower_Detect_Col);
   %get the reflective means of the col within the first several pixels
   %and remove the noise effect
   Upper_Reflect_mean = min(Upper_Detect_Col(1:80,:));
   Lower_Reflect_mean = min(Lower_Detect_Col_Reverse(1:80,:));
   %get the value of the co-efficient of the Upper and Lower reflect layer
   [Ux, Uy] = size(Upper_Detect_Col);
   Upper_Co_Efficient = 250;
   [Lx, Ly] = size(Lower_Detect_Col);
   Lower_Co_Efficient = 250;
   %generate the axis for x
   U_AXIS_X = 1:1:Ux;
   L_AXIS_X = 1:1:Lx;
   %use the co-efficient to remove the reflection in the edge of the flame
   Upper_Reflect_Layer = Upper_Co_Efficient./(U_AXIS_X.^2);
   Lower_Reflect_Layer = Lower_Co_Efficient./(L_AXIS_X.^2);
   %remove the upper reflection and get the pure flame
   Upper_Pure_Flame_Reverse = Upper_Detect_Col_Reverse-Upper_Reflect_Layer';
   Upper_Pure_Flame = Reverse_Col(Upper_Pure_Flame_Reverse);
   Upper_Pure_Flame(1:80,1) = 0;
   Upper_Pure_Flame(end,1) = Upper_Detect_Col(end,1);
   %remove the lower reflection and get the pure flame
   Lower_Pure_Flame = Lower_Detect_Col - Lower_Reflect_Layer';
   Lower_Pure_Flame(end:(Lx-80),1) = 0;
   Lower_Pure_Flame(1,1) = Lower_Detect_Col(1,1);
   %reconstruct the col
   [Ux, Uy] = size(Upper_Pure_Flame);
   [Lx, Ly] = size(Lower_Pure_Flame);
   Detected_Flame(1:Ux,i) = Upper_Pure_Flame;
   Detected_Flame((x-Lx+1):end,i) = Lower_Pure_Flame;
   %put the flame in the middle into the detected_flame
   Detected_Flame(Ux:(x-Lx),i) = Detect_Col(Ux:(x-Lx));
end
Detected_Flame(:,1:500) = orig(:,1:500);
%%
figure(7)
Detected_Flame = imdilate(Detected_Flame, strel('disk',40));
imshow(Detected_Flame,[0 255]);
Detected_Flame_Edge = sobel(Detected_Flame);
figure(8)
imshow(Detected_Flame_Edge,[0 255]);
%ground choose!!