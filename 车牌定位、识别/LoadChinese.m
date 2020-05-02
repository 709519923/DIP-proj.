function Chinese = LoadChinese()

Chinese(:,:,1) = imresize(im2bw(imread('License_plate_recognition/Chinesecharacter/ÔÆ.jpg'),0.5),[40,20],'bilinear');  % ÔÆ

Chinese(:,:,2) = imresize(im2bw(imread('License_plate_recognition/Chinesecharacter/¼ª.jpg'),0.5),[40,20],'bilinear');  % ¼ª

Chinese(:,:,3) = imresize(im2bw(imread('License_plate_recognition/Chinesecharacter/¾©.jpg'),0.5),[40,20],'bilinear');  % ¾©

Chinese(:,:,4) = imresize(im2bw(imread('License_plate_recognition/Chinesecharacter/Ãö.jpg'),0.5),[40,20],'bilinear');  % Ãö

Chinese(:,:,5) = imresize(im2bw(imread('License_plate_recognition/Chinesecharacter/ËÕ.jpg'),0.5),[40,20],'bilinear');  % ËÕ

Chinese(:,:,6) = imresize(im2bw(imread('License_plate_recognition/Chinesecharacter/ÔÁ.jpg'),0.5),[40,20],'bilinear');  % ÔÁ

Chinese(:,:,7) = imresize(im2bw(imread('License_plate_recognition/Chinesecharacter/Õã.jpg'),0.5),[40,20],'bilinear');  % Õã

end

 
