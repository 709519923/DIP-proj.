
video=VideoReader('Rec 0001.avi'); %读取视频文件
get(video) %获取视频信息
disp('Rec 0001.avi')   
implay('Rec 0001.avi');%播放视频
% detecting(video)

%-----------运动目标检测---------%
Background_frame=376;
Vehicle_frame=25;
background=rgb2gray(read(video,Background_frame));%读取背景帧
choosedframe=rgb2gray(read(video,Vehicle_frame));%读取车辆所在帧
dtarget=abs(background-choosedframe);%差分图像
bw=im2bw(dtarget,0.1); %二值图像处理
cc=bwlabel(bw); %区域标记
stats=regionprops(cc,'Area'); %区域面积标记
idx=find([stats.Area]>20000); %筛选
bw2=ismember(cc,idx); %新一轮筛选区域
se=strel('disk',5);
bw3=bw2;
for i=1:3
    bw3=imdilate(bw3,se);
    bw3=imerode(bw3,se);
end          %上 为新一轮开闭运算填充汽车所在区域
figure,imshow(read(video,Background_frame)),title('背景帧')
figure,imshow(read(video,Vehicle_frame)),title('车辆所在帧')
figure,imshow(dtarget),title('差分图像')
figure,imshow(bw),title('差分二值图像')
figure,imshow(bw2),title('差分二值图像 筛选后图像')
figure,imshow(bw3),title('差分二值图像 筛选后图像 三次开闭运算后')

%----------车辆重心计算-----------------
dd=bwlabel(bw3);
stats2=regionprops(dd,'Area','Centroid');
stats2.Area
stats2.Centroid
vehicle1 = imcrop(choosedframe,[stats2.Centroid(1)-105 ... %三个点表示另起一行
    stats2.Centroid(2)-115 stats2.Centroid(1)+105 stats2.Centroid(2)+115]);
figure,imshow(vehicle1)

%----------写入捕获后的车辆图--------------
% % imwrite(vehicle1,'vehicle2.png')% 25帧
% % imwrite(vehicle1,'vehicle1.png')% 245帧
% % imwrite(vehicle1,'vehicle3.png')% 463帧
% imwrite(vehicle1,'vehicle4.png')% 828帧
% imwrite(vehicle1,'vehicle5.png')% 81帧