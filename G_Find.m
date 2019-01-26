clear all;
clc;
A = imread('ImgA000000.tif');
A = im2double(A);
Detect_Col = A(:,1364)*255;
[x, y] = size(Detect_Col);
kernel = [-1;0;1];
G = zeros(x,1);
for i=2:x-1
    G(i,1) = Detect_Col(i-1) * kernel(1) + Detect_Col(i+1) * kernel(3);
end

figure(1)
G = smooth(G);
plot(G);
figure(2)
Detect_Col = smooth(Detect_Col);
plot(Detect_Col);
hold on;
G2 = Detect_Col(1:282,:);
% G2 = smooth(G2);

%G2 is the curve we need to fit into the K/x^2 or into the K/(x-b)^2
%generate x axis data
[x, y] = size(G2);
AXIS_X = 1:1:x;
%rotate G2 and make it fit into k/x^2
counter = 1;
for i=x:(-1):1
    G3(counter) = G2(i);
    counter = counter + 1;
end
G3 = G3';
for i=1:x
   reflection(i) = 367.9/(AXIS_X(i)^2); 
end
G_Non_reflection = G3 - reflection';
counter = 1;
for i = x: (-1) : 1
    G_Non_reflection_Real(counter,1) = G_Non_reflection(i);
    counter = counter + 1;
end

Detect_Col(1:260,:) = G_Non_reflection_Real(1:260,:);
plot(Detect_Col);
%re-calculate the grad
kernel = [-1;0;1];
[x,y] = size(Detect_Col);
G_New = zeros(x,1);
for i=2:x-1
    G_New(i,1) = Detect_Col(i-1) * kernel(1) + Detect_Col(i+1) * kernel(3);
end
G_New = smooth(G_New);
figure(3)
plot(G_New);
%get the sub of grad
G_Sub = G - G_New;
figure(4)
plot(G_Sub);
[Otsu_Output,threshold] = OtsuCluster(A);