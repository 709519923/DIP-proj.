number_plate = imread('���ƶ�ֵͼ��.png');
histcol1=sum(number_plate);      %���㴹ֱͶӰ
histrow=sum(number_plate);      %����ˮƽͶӰ
figure,subplot(2,1,1),bar(histcol1);title('��ֱͶӰ�����߿�');%�����ֱͶӰ
subplot(2,1,2),bar(histrow);     title('ˮƽͶӰ�����߿�');%���ˮƽͶӰ
figure,subplot(2,1,1),bar(histrow); title('ˮƽͶӰ�����߿�');%���ˮƽͶӰ
number_plate=im2bw(number_plate,70/255); %����ֵ����ͼ��ľ�������������ģ�Ҳ���Ը���ͼ���Զ�����
subplot(2,1,2),imshow(number_plate);title('���ƶ�ֵ��ͼ');%�����ֵͼ.

%(2)������ϣ�������x�н�
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
res=fit(xdata',ydata','poly1');%fit�������ã�
p1=res.p1;
% R=imrotate(number_plate,p1);   %����Զ��Ƕ��㷨��ת
    R=imrotate(number_plate,-2,'bilinear','crop');%�Ƕȸ����Ӿ�Ч����������Ҳ����ʹ��������㷨
figure,subplot(2,1,1),imshow(number_plate);title('���ƻҶ���ͼ');%���������ת��ĻҶ�ͼ�������ʾ���ƻҶ���ͼ
subplot(2,1,2),imshow(R);title('');%���������ת��ĻҶ�ͼ��
title(['������ת��: ',num2str(angle),'��'] ,'Color','r');%��ʾ���Ƶ���ת�Ƕ�

figure,subplot(2,1,1),bar(histrow);     title('ˮƽͶӰ����ת��');
subplot(2,1,2),imshow(R);title('���ƶ�ֵ��ͼ����ת��');

%imwrite(R,'���ƶ�ֵͼ��1.png');

