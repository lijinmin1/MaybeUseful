%����histeq��������ֱ��ͼ���⻯����
I=imread('river.jpg');
J=histeq(I,256);  %ֱ��ͼ���⻯
% figure,
% subplot(121),imshow(uint8(I));
% title('ԭͼ')
% subplot(122),imshow(uint8(J));
% title('���⻯��')
figure,
subplot(121),imhist(I,256);
% subplot(122),imhist(I,256);
title('ԭͼ��ֱ��ͼ');
subplot(122),imhist(J,256);
title('���⻯���ֱ��ͼ');