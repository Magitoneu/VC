function [ y ] = enhancement( x )

    hVert = [1 1 1 0 0 0 -1 -1 -1];
    hHort = hVert'; 
    y = hVert * x;
    y = hHort * y;

end

