
video=VideoReader('Rec 0001.avi'); %��ȡ��Ƶ�ļ�
get(video) %��ȡ��Ƶ��Ϣ
disp('Rec 0001.avi')   
implay('Rec 0001.avi');%������Ƶ
% detecting(video)

%-----------�˶�Ŀ����---------%
Background_frame=376;
Vehicle_frame=25;
background=rgb2gray(read(video,Background_frame));%��ȡ����֡
choosedframe=rgb2gray(read(video,Vehicle_frame));%��ȡ��������֡
dtarget=abs(background-choosedframe);%���ͼ��
bw=im2bw(dtarget,0.1); %��ֵͼ����
cc=bwlabel(bw); %������
stats=regionprops(cc,'Area'); %����������
idx=find([stats.Area]>20000); %ɸѡ
bw2=ismember(cc,idx); %��һ��ɸѡ����
se=strel('disk',5);
bw3=bw2;
for i=1:3
    bw3=imdilate(bw3,se);
    bw3=imerode(bw3,se);
end          %�� Ϊ��һ�ֿ����������������������
figure,imshow(read(video,Background_frame)),title('����֡')
figure,imshow(read(video,Vehicle_frame)),title('��������֡')
figure,imshow(dtarget),title('���ͼ��')
figure,imshow(bw),title('��ֶ�ֵͼ��')
figure,imshow(bw2),title('��ֶ�ֵͼ�� ɸѡ��ͼ��')
figure,imshow(bw3),title('��ֶ�ֵͼ�� ɸѡ��ͼ�� ���ο��������')

%----------�������ļ���-----------------
dd=bwlabel(bw3);
stats2=regionprops(dd,'Area','Centroid');
stats2.Area
stats2.Centroid
vehicle1 = imcrop(choosedframe,[stats2.Centroid(1)-105 ... %�������ʾ����һ��
    stats2.Centroid(2)-115 stats2.Centroid(1)+105 stats2.Centroid(2)+115]);
figure,imshow(vehicle1)

%----------д�벶���ĳ���ͼ--------------
% % imwrite(vehicle1,'vehicle2.png')% 25֡
% % imwrite(vehicle1,'vehicle1.png')% 245֡
% % imwrite(vehicle1,'vehicle3.png')% 463֡
% imwrite(vehicle1,'vehicle4.png')% 828֡
% imwrite(vehicle1,'vehicle5.png')% 81֡