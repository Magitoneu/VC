% script per llegir les imatges d'un carpeta

% TODO: Duplicar imatges d'ulls (girarles) 
pathUni = 'I:\vc\Short Project\*.pgm';
pathCasa = '../../Images/ShortProject/';

imf = dir('../../Images/ShortProject/*.pgm'); % llista d'imatges amb extensio bmp
n = 1521; % nombre d'imatges en el directori
images = zeros([n*2,286,384]); % array n imatges de mida 100 x 100
eyes = zeros([n*2 4]);

positiveInstances = table({'filename'}, [0 0 0 0],'VariableNames',{'imatge','LeftEye'});

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
     [IeyeL, IeyeR, Leye, Reye] = getEyeImgs(I,eyes((i*2)-1,:));
     positiveInstances = [positiveInstances; [{strcat(pathCasa,name)},Leye]];
     positiveInstances = [positiveInstances; [{strcat(pathCasa,name)},Reye]];
     
     name2 = strcat('Flipped', name);
     I = uint8(squeeze(images((i*2),:,:)));
     imwrite(I,strcat(pathCasa,name2));
     [IeyeL, IeyeR, Leye, Reye] = getEyeImgs(I,eyes((i*2),:));
     positiveInstances = [positiveInstances; [{strcat(pathCasa,name2)},Leye]];
     positiveInstances = [positiveInstances; [{strcat(pathCasa,name2)},Reye]];
     
     fclose(fileId);
     
end

positiveInstances = positiveInstances(2:end,:);
