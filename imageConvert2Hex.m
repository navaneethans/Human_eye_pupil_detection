% Image to text conversion


% Read the image from the file
% [filename, pathname] = uigetfile('NCT_ModelEye_1.png');
img = imread('Databa23.bmp');
img = imresize((img),[320 240]);
%   imshow(img);
 [ row col p ] =size(img);
% 
 if p == 3
     img = rgb2gray(img);
 end
%   BW2 = edge(img,'canny');
% rectImg = img(16:80,16:80);
%  imshow(BW2);
% % noise add
% rectImg = imnoise(rectImg,'salt & pepper', 0.02);
% 
% img(16:80,16:80) = rectImg;
% [counts,x] = imhist(imggray);
% stem(x,counts);
% figure
% imshow(imggray);

% Image Transpose
imgTrans = img';
% iD conversion
img1D = imgTrans(:);
% Decimal to Hex value conversion
imgHex = dec2hex(img1D);
% New txt file creation
fid = fopen('Databa23_320x240.hex', 'wt');
% Hex value write to the txt file
fprintf(fid, '%x\n', img1D);
% Close the txt file
fclose(fid)