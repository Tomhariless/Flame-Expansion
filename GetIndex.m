function flame_index= GetIndex(Detect_Col)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    [x, y] = size(Detect_Col);
    for i = 1:x
       if (Detect_Col(i)>=150)
          flame_index = i; 
          break;
       end
    end
end

