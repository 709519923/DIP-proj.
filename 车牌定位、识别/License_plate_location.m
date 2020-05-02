%----------------车牌定位---------------------------
clear ;
close all;
%Step1 获取图像   装入待处理彩色图像并显示原始图像
Scolor = imread('车辆3.png');%imread函数读取图像文件

%将彩色图像转换为黑白并显示
Sgray = rgb2gray(Scolor);%rgb2gray转换成灰度图
figure,imshow(Sgray),title('原始黑白图像');

%对原始图像进行开操作得到图像背景图像: 类似书本指纹识别处理 可以清除噪声
s=strel('disk',13);%strei函数
Bgray=imopen(Sgray,s);%打开sgray s图像
figure,imshow(Bgray);title('背景图像');%输出背景图像

%原始图像与背景图像作减法，对图像进行增强处理:
Egray=imsubtract(Sgray,Bgray);%两幅图相减
figure,imshow(Egray);title('增强黑白图像');%输出黑白图像

%取得最佳阈值，将图像二值化:
fmax1=double(max(max(Egray)));%egray的最大值并输出双精度型
fmin1=double(min(min(Egray)));%egray的最小值并输出双精度型
% level=(fmax1-(fmax1-fmin1)/3)/255;%获得最佳阈值
level=30/255;%获得最佳阈值
bw22=im2bw(Egray,level);%转换图像为二进制图像
bw2=double(bw22);
figure,imshow(bw2);title('图像二值化');%得到二值图像

%边缘检测
grd=edge(bw2,'canny');%用canny算子识别强度图像中的边界
figure,imshow(grd);title('图像边缘提取');%输出图像边缘

%开操作进行滤波
bg1=imclose(grd,strel('rectangle',[5,19]));%取矩形框的闭运算
figure,imshow(bg1);title('图像闭运算[5,19]');%输出闭运算的图像
bg3=imopen(bg1,strel('rectangle',[5,19]));%取矩形框的开运算
figure,imshow(bg3);title('图像开运算[5,19]');%输出开运算的图像
bg2=imopen(bg3,strel('rectangle',[19,1]));%取矩形框的开运算
figure,imshow(bg2);title('图像开运算[19,1]');%输出开运算的图像

%二值图像进行区域提取，并计算区域特征参数。
%进行区域特征参数比较，提取车牌区域
[L,num] = bwlabel(bg2,8);%标注二进制图像中已连接的部分 8连通
Feastats = regionprops(L,'basic');%计算图像区域的特征尺寸
Area=[Feastats.Area];%区域面积
BoundingBox=[Feastats.BoundingBox];%[x y width height]车牌的框架大小
RGB = label2rgb(L, 'spring', 'k', 'shuffle'); %标志图像向RGB图像转换
figure,imshow(RGB);title('图像彩色标记');%输出框架的彩色图像

lx=1;%统计宽和高满足要求的可能的车牌区域个数
Getok=zeros(1,10);%统计满足要求个数
size(Getok);
for l=1:num  %num是彩色标记区域个数
width=BoundingBox((l-1)*4+3);
hight=BoundingBox((l-1)*4+4);
rato=width/hight%计算车牌长宽比
%利用已知的宽高和车牌大致位置进行确定。
if(rato>2&rato<3.5)%车牌长宽比值筛选
        Getok(lx)=l;
        lx=lx+1;  
end
end
Mark=Getok(Getok~=0) %找出非零元素
[i,j]=size(Mark);%Mark(j)表示BoundingBox中的第j个标记
%--------本段代码可以优化，利用for循环可以识别多个车牌-----------
x=Feastats(Mark(j)).BoundingBox(1);
y=Feastats(Mark(j)).BoundingBox(2);
x_end=Feastats(Mark(j)).BoundingBox(3);
y_end=Feastats(Mark(j)).BoundingBox(4);

number_plate=imcrop(Egray,[x y x_end y_end]);  %车牌区域裁剪
figure(),imshow(number_plate);
%-----提取非零元素表达------------
% A=[1 2 3 0 85];
% B=A(A~=0)

%---------------------------车牌识别-------------------------------------------
histcol1=sum(number_plate);      %计算垂直投影
histrow=sum(number_plate);      %计算水平投影
figure,subplot(2,1,1),bar(histcol1);title('垂直投影（含边框）');%输出垂直投影
subplot(2,1,2),bar(histrow);     title('水平投影（含边框）');%输出水平投影
figure,subplot(2,1,1),bar(histrow); title('水平投影（含边框）');%输出水平投影
number_plate=im2bw(number_plate,70/255); %该阈值根据图像的具体情况可做更改，也可以根据图像自动计算
subplot(2,1,2),imshow(number_plate);title('车牌二值子图');%输出二值图

%imwrite(number_plate,'车牌二值图像.png')
