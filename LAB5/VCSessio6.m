I = imread('money.tif');
BW = im2bw(I, 95/255);
C = bwconncomp(BW);
%%Agrupacio
%%Pixels connectats
J= I;
J(C.PixelIdxList{1}) = 0;

n = numel(C.PixelIdxList);
npixels = cellfun(@numel, C.PixelIdxList); %Numero de pixels de cada part 

S = regionprops(C, 'centroid', 'BoundingBox'); %Centre de masses

[v pos] = max(npixels);
J(C.PixelIdxList{pos}) = J(C.PixelIdxList{pos}).* 0.64;
imshow(J);

%%Pixels de colors similars

clear all
I = imread('Street.jpg');
HSV = rgb2hsv(I);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);
O = [H(:), S(:), V(:)];
c = kmeans(O,8); %O -> vector observacions (1 D), 2 -> nº de classes

IC = reshape(c,size(H));
imshow(IC,[]);

%Split and merge

%S = qtdecomp(I,  @myfunction) 
 %@ y = myfunction( x ), y boolean(true -> dividir, false -> no dividir), x image.

BW = im2bw(imresize(I,[512 512]), 95/255);
S = qtdecomp(BW,  0.7);

blocks = repmat(uint8(0),size(S));
for dim = [512 256 128 64 32 16 8 4 2 1];    
  numblocks = length(find(S==dim));    
  if (numblocks > 0)        
    values = repmat(uint8(1),[dim dim numblocks]);
    values(2:dim,2:dim,:) = 0;
    blocks = qtsetblk(blocks,S,dim,values);
  end
end
blocks(end,1:end) =1;
blocks(1:end,end) = 1;
imshow(I),figure,imshow(blocks,[])



