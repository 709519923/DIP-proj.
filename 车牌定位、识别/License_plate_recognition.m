%----------------����ˮƽУ��--------------------
%������б��ԭ����ͶӰЧ����ɹȲ����ԣ�
%��������Ҫ�����ƽ�������
%�����ȡ��������ϵķ���,
%����������ϱ߻��±�ͼ��ֵΪ1�ĵ����ֱ����ˮƽX��ļнǡ�
number_plate = imread('���ƶ�ֵͼ��.png');
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
res=fit(xdata',ydata','poly1');
p1=res.p1;
R=imrotate(number_plate,p1);
figure(2);
subplot(2,1,1);imshow(number_plate);title('ˮƽУ��ǰ');
subplot(2,1,2);imshow(R);title('ˮƽУ����');
%-------------�ַ��з�---------------------
%�ַ�����ͶӰ�������ַ������Ե�λ��
v=sum(R);
figure(3);
subplot(2,1,1);plot(v);title('ˮƽͶӰ');
ma=max(v);    
length=size(v,2);
for i=1:1:length
    if v(1,i)<0.1*ma*2.5  %�ַ��з���ֵ����
    v(1,i)=0;
    end
end
subplot(2,1,2);plot(v);title('��ֵ�������ˮƽͶӰ');
%---------Ȼ�������ֱͶӰ�Ĺ���ȷ��ÿ���ַ�����ֹλ��-------
str=zeros(1,7);
quit=zeros(1,7);
k=1;
for i=2:1:length
        if (v(i-1)==0)&(v(i)>0)
        str(k)=i;
        else 
                if (v(i-1)>0)&(v(i)==0)
                quit(k)=i-1;
                k=k+1;
                continue;
        end
    end
end
%%�и�ÿ���ַ�
figure(4);
p1=R(:,str(1):quit(1));subplot(1,7,1);imshow(p1);
p2=R(:,str(2):quit(2));subplot(1,7,2);imshow(p2);
p3=R(:,str(3):quit(3));subplot(1,7,3);imshow(p3);
p4=R(:,str(4):quit(4));subplot(1,7,4);imshow(p4);
p5=R(:,str(5):quit(5));subplot(1,7,5);imshow(p5);
p6=R(:,str(6):quit(6));subplot(1,7,6);imshow(p6);
p7=R(:,str(7):quit(7));subplot(1,7,7);imshow(p7);
suptitle('�ַ��з�');

%��׼������
p1=imresize(p1,[40 20]);
p2=imresize(p2,[40 20]);
p3=imresize(p3,[40 20]);
p4=imresize(p4,[40 20]);
p5=imresize(p5,[40 20]);
p6=imresize(p6,[40 20]);
p7=imresize(p7,[40 20]);

%-----------------�ַ�ʶ��-------------------
%%%%%%%%1.�����и�ͼƬ
char1=p1;
char2=p2;
char3=p3;
char4=p4;
char5=p5;
char6=p6;
char7=p7;
%%%%%% 2.����ģ���
%%%%%%%%%%%%%%%%%%%%%%
Chinese = LoadChinese();
Letter = LoadLetter();
DigitLetter = LoadDigitLetter();

 %%%%%% 3.�����ַ���ģ����ַ���������ƥ��
 recog1 = identityChinese(Chinese, char1); 
 recognition(1)=recog1;
 recog2 = identityLetter(Letter, char2); 
 recognition(2)=recog2;
 recog3 = identityLetter(Letter, char3);  recognition(3)=recog3;
 recog4 = identityDigitLetter(DigitLetter, char4);  recognition(4)=recog4;
 recog5 = identityDigitLetter(DigitLetter, char5);  recognition(5)=recog5;
 recog6 = identityDigitLetter(DigitLetter, char6);  recognition(6)=recog6;
 recog7 = identityDigitLetter(DigitLetter, char7);  recognition(7)=recog7;
 
 %%%%%% 4.��ʾʶ������������д�����ݿ�%%%%%%%%%%%%%%
 disp(recognition);msgbox({'ʶ����';recognition});