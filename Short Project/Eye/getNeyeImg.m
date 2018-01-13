function [ Iout ] = getNeyeImg( Iin, Leye, Reye, Mode )

[rows, cols] = size(Iin);
superpos = true;

if Mode == 1
    while superpos
        x = randi([1 rows-90], 1);
        y = randi([1 cols-120], 1);
        superpos = (0 ~= rectint([y x 119 89],Leye)) || (0 ~= rectint([y x 119 89],Reye));
    end
    Iout = imcrop(Iin, [y x 119 89]);
else
   while superpos
        x = randi([1 rows-29], 1);
        y = randi([1 cols-39], 1);
        superpos = (0 ~= rectint([y x 39 29],Leye)) || (0 ~= rectint([y x 39 29],Reye));
   end 
   Iout = imcrop(Iin, [y x 39 29]);
end
end

