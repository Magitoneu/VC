I = imread('lenna.tif');
Isp = imnoise(I,'salt & pepper', 0.05);
Iga = imnoise(I,'gaussian', 0, 0.01);
subplot(2,3,1),imshow(Iga),title('Gaussian Noise');

%%Suavitzat


ConvulceMatrix = ones(3)/9;

IgaF = imfilter(Iga,ConvulceMatrix);
subplot(2,3,2),imshow(IgaF),title('First filter');

ConvulceMatrix2 = ones(1,30);
ConvulceMatrix2(1,1:15) = 0;
ConvulceMatrix2 = ConvulceMatrix2/15;

IgaF2 = imfilter(Iga,ConvulceMatrix2);
subplot(2,3,3),imshow(IgaF2),title('Second filter (Movement)');

ConvulceMatrix3 = imrotate(ConvulceMatrix2,45);
IgaF3 = imfilter(Iga, ConvulceMatrix3);
subplot(2,3,4),imshow(IgaF3),title('Third filter (Rotation)');

ConvulceMatrix4 = fspecial('disk',10);
IgaF3 = imfilter(Iga, ConvulceMatrix4);
subplot(2,3,5),imshow(IgaF3),title('Fourth filter (Fspecial)');

ConvulceMatrix5 = fspecial('gaussian',6,1);
IgaF3 = imfilter(Iga, ConvulceMatrix5);
subplot(2,3,6),imshow(IgaF3),title('Five filter (Fspecial)');

%%Ressaltat
Isp = double(imnoise(I,'salt & pepper', 0.05));
Iga = double(imnoise(I,'gaussian', 0, 0.01));

%%Operadors per ressaltar: 
%Laplacià 
h = [-1 -1 -1;-1 8 -1; -1 -1 -1];

Ilp = imfilter(Isp,h);
figure(2), subplot(2,3,1),imshow(Ilp, []),title('Laplacia');

%Sobel
h_Vert = [1 2 1; 0 0 0; -1 -2 -1];

ISo1 = imfilter(Isp,h_Vert);
subplot(2,3,2),imshow(ISo1, []),title('Sobel VERT');

h_Hori = [1 0 -1; 2 0 -2; 1 0 -1];

ISo2 = imfilter(Isp,h_Hori);
subplot(2,3,3),imshow(ISo2, []),title('Sobel HORI');

I_Together = hypot(ISo1,ISo2);
subplot(2,3,4),imshow(I_Together, []),title('Sobel Together');

a = atan2(ISo1,ISo2);
subplot(2,3,5),imshow(a, []),title('Angles');


%%Filtre no lineal
Ik = medfilt2(Isp);
figure(3), subplot(2,1,1), imshow(Isp,[]);
subplot(2,1,2), imshow(Ik, []);


%%Aplicar funcio propia a una imatge
%If = colfilt(I,[f c], 'sliding', @funcio); f = files, c = columnes dels blocs. 
k = 2;
If = colfilt(Isp,[3 3], 'sliding', @(x) colFunc(x,k));
figure(4), imshow(If, []);



