fid = fopen('iris_thousand.hex','r');
% Scann the txt file 
img = fscanf(fid, '%x',[1 inf]); 
% Close the txt file
fclose(fid) 
% restore the image
outImg = reshape(img,[640 480]);
outImg = outImg';

 fid = fopen('iris_thousand_threshold.hex','r');
% fid = fopen('iris_lamp_threshold.hex','r');
% Scann the txt file 
img1 = fscanf(fid, '%x',[1 inf]); 
% Close the txt file
fclose(fid) 
% restore the image
outImg1 = reshape(img1,[640 480]);
outImg1 = outImg1';
figure,
imshowpair(uint8(outImg),uint8(outImg1),'montage')
% imshow(outImg1)
% subplot(1,3,1);
% imshow(I);% subplot(1,3,2);
% figure, imshow(uint8(outImg));
% subplot(1,3,3);
% imshow(outImg1);
% imshow(outImg,[])
 