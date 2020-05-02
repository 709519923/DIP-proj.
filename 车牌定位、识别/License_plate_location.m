%----------------���ƶ�λ---------------------------
clear ;
close all;
%Step1 ��ȡͼ��   װ��������ɫͼ����ʾԭʼͼ��
Scolor = imread('����3.png');%imread������ȡͼ���ļ�

%����ɫͼ��ת��Ϊ�ڰײ���ʾ
Sgray = rgb2gray(Scolor);%rgb2grayת���ɻҶ�ͼ
figure,imshow(Sgray),title('ԭʼ�ڰ�ͼ��');

%��ԭʼͼ����п������õ�ͼ�񱳾�ͼ��: �����鱾ָ��ʶ���� �����������
s=strel('disk',13);%strei����
Bgray=imopen(Sgray,s);%��sgray sͼ��
figure,imshow(Bgray);title('����ͼ��');%�������ͼ��

%ԭʼͼ���뱳��ͼ������������ͼ�������ǿ����:
Egray=imsubtract(Sgray,Bgray);%����ͼ���
figure,imshow(Egray);title('��ǿ�ڰ�ͼ��');%����ڰ�ͼ��

%ȡ�������ֵ����ͼ���ֵ��:
fmax1=double(max(max(Egray)));%egray�����ֵ�����˫������
fmin1=double(min(min(Egray)));%egray����Сֵ�����˫������
% level=(fmax1-(fmax1-fmin1)/3)/255;%��������ֵ
level=30/255;%��������ֵ
bw22=im2bw(Egray,level);%ת��ͼ��Ϊ������ͼ��
bw2=double(bw22);
figure,imshow(bw2);title('ͼ���ֵ��');%�õ���ֵͼ��

%��Ե���
grd=edge(bw2,'canny');%��canny����ʶ��ǿ��ͼ���еı߽�
figure,imshow(grd);title('ͼ���Ե��ȡ');%���ͼ���Ե

%�����������˲�
bg1=imclose(grd,strel('rectangle',[5,19]));%ȡ���ο�ı�����
figure,imshow(bg1);title('ͼ�������[5,19]');%����������ͼ��
bg3=imopen(bg1,strel('rectangle',[5,19]));%ȡ���ο�Ŀ�����
figure,imshow(bg3);title('ͼ������[5,19]');%����������ͼ��
bg2=imopen(bg3,strel('rectangle',[19,1]));%ȡ���ο�Ŀ�����
figure,imshow(bg2);title('ͼ������[19,1]');%����������ͼ��

%��ֵͼ�����������ȡ����������������������
%�����������������Ƚϣ���ȡ��������
[L,num] = bwlabel(bg2,8);%��ע������ͼ���������ӵĲ��� 8��ͨ
Feastats = regionprops(L,'basic');%����ͼ������������ߴ�
Area=[Feastats.Area];%�������
BoundingBox=[Feastats.BoundingBox];%[x y width height]���ƵĿ�ܴ�С
RGB = label2rgb(L, 'spring', 'k', 'shuffle'); %��־ͼ����RGBͼ��ת��
figure,imshow(RGB);title('ͼ���ɫ���');%�����ܵĲ�ɫͼ��

lx=1;%ͳ�ƿ�͸�����Ҫ��Ŀ��ܵĳ����������
Getok=zeros(1,10);%ͳ������Ҫ�����
size(Getok);
for l=1:num  %num�ǲ�ɫ����������
width=BoundingBox((l-1)*4+3);
hight=BoundingBox((l-1)*4+4);
rato=width/hight%���㳵�Ƴ����
%������֪�Ŀ�ߺͳ��ƴ���λ�ý���ȷ����
if(rato>2&rato<3.5)%���Ƴ����ֵɸѡ
        Getok(lx)=l;
        lx=lx+1;  
end
end
Mark=Getok(Getok~=0) %�ҳ�����Ԫ��
[i,j]=size(Mark);%Mark(j)��ʾBoundingBox�еĵ�j�����
%--------���δ�������Ż�������forѭ������ʶ��������-----------
x=Feastats(Mark(j)).BoundingBox(1);
y=Feastats(Mark(j)).BoundingBox(2);
x_end=Feastats(Mark(j)).BoundingBox(3);
y_end=Feastats(Mark(j)).BoundingBox(4);

number_plate=imcrop(Egray,[x y x_end y_end]);  %��������ü�
figure(),imshow(number_plate);
%-----��ȡ����Ԫ�ر��------------
% A=[1 2 3 0 85];
% B=A(A~=0)

%---------------------------����ʶ��-------------------------------------------
histcol1=sum(number_plate);      %���㴹ֱͶӰ
histrow=sum(number_plate);      %����ˮƽͶӰ
figure,subplot(2,1,1),bar(histcol1);title('��ֱͶӰ�����߿�');%�����ֱͶӰ
subplot(2,1,2),bar(histrow);     title('ˮƽͶӰ�����߿�');%���ˮƽͶӰ
figure,subplot(2,1,1),bar(histrow); title('ˮƽͶӰ�����߿�');%���ˮƽͶӰ
number_plate=im2bw(number_plate,70/255); %����ֵ����ͼ��ľ�������������ģ�Ҳ���Ը���ͼ���Զ�����
subplot(2,1,2),imshow(number_plate);title('���ƶ�ֵ��ͼ');%�����ֵͼ

%imwrite(number_plate,'���ƶ�ֵͼ��.png')
