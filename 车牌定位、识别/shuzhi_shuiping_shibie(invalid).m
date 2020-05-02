number_plate = imread('车牌二值图像.png');
histcol1=sum(number_plate);      %计算垂直投影
histrow=sum(number_plate);      %计算水平投影
figure,subplot(2,1,1),bar(histcol1);title('垂直投影（含边框）');%输出垂直投影
subplot(2,1,2),bar(histrow);     title('水平投影（含边框）');%输出水平投影
figure,subplot(2,1,1),bar(histrow); title('水平投影（含边框）');%输出水平投影
number_plate=im2bw(number_plate,70/255); %该阈值根据图像的具体情况可做更改，也可以根据图像自动计算
subplot(2,1,2),imshow(number_plate);title('车牌二值子图');%输出二值图.

%(2)线性拟合，计算与x夹角
[n2,k2]=size(number_plate);
xdata=zeros(1,n2);
ydata=zeros(1,n2);
k1=1;
for l=1:1:n2
for k=1:1:k2
if number_plate(l,k)==1
xdata(k1)=l;
ydata(k1)=k;
k1=k1+1;
break;
end
end
end
res=fit(xdata',ydata','poly1');%fit函数作用？
p1=res.p1;
% R=imrotate(number_plate,p1);   %这个自动角度算法旋转
    R=imrotate(number_plate,-2,'bilinear','crop');%角度根据视觉效果来调整，也可以使用上面的算法
figure,subplot(2,1,1),imshow(number_plate);title('车牌灰度子图');%输出车牌旋转后的灰度图像标题显示车牌灰度子图
subplot(2,1,2),imshow(R);title('');%输出车牌旋转后的灰度图像
title(['车牌旋转角: ',num2str(angle),'度'] ,'Color','r');%显示车牌的旋转角度

figure,subplot(2,1,1),bar(histrow);     title('水平投影（旋转后）');
subplot(2,1,2),imshow(R);title('车牌二值子图（旋转后）');

%imwrite(R,'车牌二值图像1.png');

