function Lower_flame_index= GetLowerIndex(Detect_Col)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    [x, y] = size(Detect_Col);
    for i = x:(-1):1
       if (Detect_Col(i)>=150)
          Lower_flame_index = i;
          break;
       end
    end
end

