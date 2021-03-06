
pathUni = 'I:\vc\Short Project\*.pgm';
%pathCasa = '/home/david/UPC/Images/Short Project/';
%imf = dir('/home/david/UPC/Images/Short Project/*.pgm'); % llista d'imatges amb extensio bmp

pathCasa = '/home/mt7/UPC/4rt/vc/Images/ShortProject/';
imf = dir('/home/mt7/UPC/4rt/vc/Images/ShortProject/*.pgm'); % llista d'imatges amb extensio bmp


n = 1521; % nombre d'imatges en el directori
images = zeros([n*2,286,384]); % array n imatges de mida 100 x 100
eyes = zeros([n*2 4]);
%eyesPath = '/home/david/UPC/Images/Eyes/';
%mkdir '/home/david/UPC/Images/Eyes';

eyesPath = '/home/mt7/UPC/4rt/vc/Images/Eyes/';
mkdir '/home/mt7/UPC/4rt/vc/Images/Eyes';

eyesDB = zeros([n*4,30,40]);

for i = 1 : n
     name = imf(i). name;
     im = imread(strcat(pathCasa, name));
     s = size(im);
     l = length(s);
     if l == 3 
         im = rgb2gray(im);
     end
     images((i*2)-1,:,:) = imresize(im,[286 384]);
     images((i*2),:,:) = imresize(flip(im,2),[286 384]);
     fileId = fopen(strcat(pathCasa, strcat(name(1:(end-3)),'eye')),'r');
     t = textscan(fileId,'%s',4);
     eyes((i*2)-1,:) = cell2mat(textscan(fileId, '%d %d %d %d'));
     eyes((i*2),:) = [384-eyes((i*2)-1,1) eyes((i*2)-1,2) 384-eyes((i*2)-1,3) eyes((i*2)-1,4)];
     
     I = uint8(squeeze(images((i*2)-1,:,:)));
     IF = uint8(squeeze(images((i*2),:,:)));

     [eyeL, eyeR] = getEyeImgs(I,eyes((i*2)-1,:));
     [eyefL, eyefR] = getEyeImgs(IF,eyes((i*2),:));
 
     
     filename = strcat(eyesPath, int2str(i), 'eyeL', '.pgm');
     imwrite(eyeL,filename);
     filename = strcat(eyesPath, int2str(i), 'eyeR', '.pgm');
     imwrite(eyeR,filename);
     filename = strcat(eyesPath, int2str(i), 'eyeFL', '.pgm');
     imwrite(eyefL,filename);
     filename = strcat(eyesPath, int2str(i), 'eyeFR','.pgm');
     imwrite(eyefR,filename);

     fclose(fileId);
     
     eyesDB((i*4)-3,:,:) = eyeL;
     eyesDB((i*4)-2,:,:) = eyeR;
     eyesDB((i*4)-1,:,:) = eyefL;
     eyesDB((i*4),:,:) = eyefR;
     
end

%classifiedEyes = xlsread('/home/david/UPC/Images/Eyes/Miram.xlsx');
classifiedEyes = xlsread('/home/mt7/UPC/4rt/vc/Images/Eyes/Miram.xlsx');
classifiedEyes = [classifiedEyes(:,5) classifiedEyes(:,5) classifiedEyes(:,5) classifiedEyes(:,5)];
classifiedEyes = reshape(classifiedEyes',[1,6084]);
