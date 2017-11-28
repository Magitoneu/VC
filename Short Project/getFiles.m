% script per llegir les imatges d'un carpeta
imf = dir('I:\vc\Short Project\*.pgm'); % llista d'imatges amb extensio bmp
n = length(imf); % nombre d'imatges en el directori
images = zeros([n,286,384]); % array n imatges de mida 100 x 100
asdasd = zeros([n 4]);
for i = 1 : n
     name = imf(i). name;
     im = imread(strcat('I:\vc\Short Project\', name));
     s = size(im);
     l = length(s);
     if l == 3 
         im = rgb2gray(im);
     end
     images(i,:,:) = imresize(im,[286 384]);
     
     fileId = fopen(strcat('I:\vc\Short Project\', strcat(name(1:(end-3)),'eye')),'r');
     t = textscan(fileId,'%s',4);
     asdasd(i,:) = cell2mat(textscan(fileId, '%d %d %d %d'));
     fclose(fileId);
     
end
% mostrem les imatges
%for index = 1 : n
%I =  uint8(squeeze(images(index,:,:))); % squeeze elimina les dimensions que tenen mida 1 (singletons)
%imshow(I,[]);
%end  