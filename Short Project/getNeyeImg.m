function [ Iout ] = getNeyeImg( Iin, Leye, Reye )

[rows, cols] = size(Iin);
superpos = true;

while superpos
    x = randi([16 rows-16], 1);
    y = randi([21 cols-21], 1);
    superpos = superposed(x-15,y-20, Leye) & superposed(x-15,y-20, Reye); 
end

Iout = imcrop(Iin, [y-20 x-15 39 29]);
end

