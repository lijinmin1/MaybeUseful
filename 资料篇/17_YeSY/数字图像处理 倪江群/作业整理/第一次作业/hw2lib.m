clear
I=imread('EightAM.png');%��ȡͼ��
Imatch=imread('LENA.png');%��ȡƥ��ͼ��
Jmatch=imhist(Imatch);%��ȡƥ��ͼ��ֱ��ͼ
Iout=histeq(I,Jmatch);%ֱ��ͼƥ��
figure;%��ʾԭͼ��ƥ��ͼ���ƥ����ͼ��
subplot(1,3,1),imshow(I);title('ԭͼ��');
subplot(1,3,2),imshow(Imatch);title('ƥ��ͼ��');
subplot(1,3,3),imshow(Iout);title('ƥ��֮��ͼ��');
figure;%��ʾԭͼ��ƥ��ͼ���ƥ���ͼ���ֱ��ͼ
subplot(3,1,1),imhist(I,256);title('ԭͼ��ֱ��ͼ');
subplot(3,1,2),imhist(Imatch,256);title('ƥ��ͼ��ͼ��ֱ��ͼ');
subplot(3,1,3),imhist(Iout,256);title('ƥ��֮��ͼ��ֱ��ͼ');
       