InputImage1=imread('./input/input30.jpg');
subplot(431);
imshow(uint8(InputImage1));
title('Input frame left');

InputImage2=imread('./input/input48.jpg');
subplot(432);
imshow(uint8(InputImage2));
title('Input frame middle');

InputImage3=imread('./input/input72.jpg');
subplot(433);
imshow(uint8(InputImage3));
title('Input frame right');
% % % % % frames output display %%%%%%%
InputImage4=imread('./hist_eq/his_eq1157.jpg');
subplot(434);
imshow(uint8(InputImage4));
title('Hist Equalized frame left');

InputImage5=imread('./hist_eq/his_eq112.jpg');
subplot(435);
imshow(uint8(InputImage5));
title('Hist Equalized frame middle');

InputImage6=imread('./hist_eq/his_eq157.jpg');
subplot(436);
imshow(uint8(InputImage6));
title('Hist Equalized frame right');

% % % % % % % % % % % % 
InputImage7=imread('./double_thresh/his_th2.jpg');
subplot(437);
imshow(uint8(InputImage7));
title('Hysteresis Threshold frame left');

InputImage8=imread('./double_thresh/his_th120.jpg');
subplot(438);
imshow(uint8(InputImage8));
title('Hysteresis Threshold frame middle');

InputImage9=imread('./double_thresh/his_th172.jpg');
subplot(439);
imshow(uint8(InputImage9));
title('Hysteresis Threshold frame right');
% % % % % % % % % % % % 
InputImage10=imread('./cog/cog212.jpg');
subplot(4,3,10);
imshow(uint8(InputImage10));
title('Pupil detected frame left');

InputImage11=imread('./cog/cog264.jpg');
subplot(4,3,11);
imshow(uint8(InputImage11));
title('Pupil detected frame middle');

InputImage12=imread('./cog/cog97.jpg');
subplot(4,3,12);
imshow(uint8(InputImage12));
title('Pupil detected frame right');

% % % % % % % % % % 

