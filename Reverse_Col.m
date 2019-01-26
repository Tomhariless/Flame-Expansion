function Detect_Col_Reversed = Reverse_Col(Detect_Col)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    [x, y] = size(Detect_Col);
    Detect_Col_Reversed = zeros(x,y);
    counter = 1;
    for i= x:(-1):1
       Detect_Col_Reversed(counter) = Detect_Col(i);
       counter = counter + 1;
    end
end

