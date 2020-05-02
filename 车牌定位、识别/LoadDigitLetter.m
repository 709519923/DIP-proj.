function DigitLetter = LoadDigitLetter()

digit(:,:,1)=imresize(im2bw(imread('License_plate_recognition/Number character/0.jpg'),0.5),[40,20],'bilinear');

digit(:,:,2)=imresize(im2bw(imread('License_plate_recognition/Number character/1.jpg'),0.5),[40,20],'bilinear');

digit(:,:,3)=imresize(im2bw(imread('License_plate_recognition/Number character/2.jpg'),0.5),[40,20],'bilinear');

digit(:,:,4)=imresize(im2bw(imread('License_plate_recognition/Number character/3.jpg'),0.5),[40,20],'bilinear');

digit(:,:,5)=imresize(im2bw(imread('License_plate_recognition/Number character/4.jpg'),0.5),[40,20],'bilinear');

digit(:,:,6)=imresize(im2bw(imread('License_plate_recognition/Number character/5.jpg'),0.5),[40,20],'bilinear');

digit(:,:,7)=imresize(im2bw(imread('License_plate_recognition/Number character/6.jpg'),0.5),[40,20],'bilinear');

digit(:,:,8)=imresize(im2bw(imread('License_plate_recognition/Number character/7.jpg'),0.5),[40,20],'bilinear');

digit(:,:,9)=imresize(im2bw(imread('License_plate_recognition/Number character/8.jpg'),0.5),[40,20],'bilinear');

digit(:,:,10)=imresize(im2bw(imread('License_plate_recognition/Number character/9.jpg'),0.5),[40,20],'bilinear');

% letter = LoadLetter();
% 
% DigitLetter = cat(3,digit,letter);
 DigitLetter = digit();

end

 
