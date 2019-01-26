function image_out= sobel(Image_in)
    
    [sizeX,sizeY] = size(Image_in);
    image_out = zeros(sizeX,sizeY);
    Sobel_Out = zeros(sizeX,sizeY);
    Sobel_Out(1,1:sizeY) = 0;
    Sobel_Out(sizeX,1:sizeY) = 0;
    Sobel_Out(1:sizeX,1) = 0;
    Sobel_Out(sizeX,1:sizeY) = 0;
    Kernel = [1,0,-1;2,0,-2;1,0,-1];

    for i=2:(sizeX-1)
		for j=2:(sizeY-1)
			resultX = Kernel(1,1)*Image_in((i-1),(j-1))+Kernel(1,2)*Image_in((i-1),(j))+Kernel(1,3)*Image_in((i-1),(j+1))+Kernel(2,1)*Image_in((i),(j-1))+Kernel(2,2)*Image_in((i),(j))+Kernel(2,3)*Image_in((i),(j+1))+Kernel(3,1)*Image_in((i+1),(j-1))+Kernel(3,2)*Image_in((i+1),(j))+Kernel(3,3)*Image_in((i+1),(j+1));
			resultX = abs(resultX);
			Kernel = Kernel';
			resultY = Kernel(1,1)*Image_in((i-1),(j-1))+Kernel(1,2)*Image_in((i-1),(j))+Kernel(1,3)*Image_in((i-1),(j+1))+Kernel(2,1)*Image_in((i),(j-1))+Kernel(2,2)*Image_in((i),(j))+Kernel(2,3)*Image_in((i),(j+1))+Kernel(3,1)*Image_in((i+1),(j-1))+Kernel(3,2)*Image_in((i+1),(j))+Kernel(3,3)*Image_in((i+1),(j+1));
			resultY = abs(resultY);
			Sobel_Out(i,j) = resultX+resultY;
			if (Sobel_Out(i,j)>=256)
			   Sobel_Out(i,j) = 255; 
			end
			if (Sobel_Out(i,j)<=0)
			   Sobel_Out(i,j) = 0; 
			end
		end
    end
    image_out = Sobel_Out;
end