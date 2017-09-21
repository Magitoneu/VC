%%1
clc, clear all
%a)
A = [1 2 3 4 5];
B = [1;1;1;1;1];
%C = A .* B
%b)
A1 = [1 1 1];
B1 = [-1; 0; -1 ;2];
%C1 = A1 .* B1
%%2
x = 0:2*pi/30:2*pi;
y = -cos(x);
z = y > 0;
w = y .* z;
plot(x,w)
%Posicio del valor maxim duna matriu
z = [1 2 3;4 5 6; 10 9 8];
[v p] = max(z); [v1 p1] = max(max(z)); [p1 p(p1)]
%%3
x = -15:1:15;
y = -15:1:15;
[X Y] = meshgrid(x);
f = -((X./7).^2 + (Y./7).^2) + 2;
z = f > 0;
w = f .* z;
%Ex4
W = [w w; w w];  C = [X-15 X+15; X-15 X+15]; B = [Y+15 Y-15; Y-15 Y+15];
surf(C, B, W)


%%5 contour(fun) per trobar mes o menys el minim

f2 = @(x,y) (x.^2+y-5).^2+(x+y.^2-9).^2
