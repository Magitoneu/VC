clc, clear all
%%Exercici 1
%a)
A = [1 2 3 4 5];
B = [1; 1; 1; 1; 1];
C = B * A
%b)
A1 = [-1; 0; -1; 2];
B1 = [1 1 1];
C1 = A1 * B1
%%Exercici 2
x = 0:2*pi/30:2*pi;
y = -cos(x);
z = y > 0;
w = y .* z;
figure(1),plot(x,w);
%%Exercici 3
x = -15:1:15;
y = -15:1:15;
[X Y] = meshgrid(x);
f = -((X./7).^2 + (Y./7).^2) + 2;
z = f > 0;
w = f .* z;
figure(3), surf(X,Y,w);
%%Exercici 4
W = [w w; w w];  C = [X-15 X+15; X-15 X+15]; B = [Y+15 Y-15; Y-15 Y+15];
figure(4),surf(C, B, W);


%%Exercici 5
x = -5:0.05:5;
y = -5:0.05:5;
[X Y] = meshgrid(x,y);

f = @(x,y) (x.^2+y-5).^2+(x+y.^2-9).^2;
%f2 = (X.^2+Y-5).^2+(X+Y.^2-9).^2;
figure(5),fcontour(f);  

%[v p] = min(f2); [v1 p1] = min(min(f2)); [p1 p(p1)];
fminsearch(f,-2,-3);
MinimumValue = f2(p(p1),p1)
MinPoint = [(p1-100)*0.05 (p(p1)-100)*0.05]