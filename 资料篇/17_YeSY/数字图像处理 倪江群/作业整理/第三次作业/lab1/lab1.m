img = imread('barb.png'); % ��ȡͼƬ
[height, width] = size(img); % ��ȡͼƬ�ĳ��Ϳ�

% subplot(2, 2, 1);
% imshow(img);
figure();

f = double(img); % ��ȡͼ��ĻҶ�ֵ
f = Centralize(f); % ��ͼ��������Ļ�����
F = fft2(f); % ����Ҷ�任

% ���Ƶ���ϵ�ͼ��
% margin= log(abs(F));
% imshow(margin,[])
% pause

H = Butterworth(10,1, height, width); % ��ȡbutterworth���˲���
g = real(ifft2(H .* F));% ��һ����˲���Ȼ�󷴸���Ҷ�任
g = Centralize(g);% ���������Ļ���ͼ��ԭ��ԭ��������
subplot(2,2,1);
imshow(uint8(g));
title('D0 = 10  n=1');

H = Butterworth(20,1, height, width);
g = real(ifft2(H .* F));
g = Centralize(g);
subplot(2,2,2);
imshow(uint8(g));
title('D0 = 20  n=1');

H = Butterworth(40,1, height, width);
g = real(ifft2(H .* F));
g = Centralize(g);
subplot(2,2,3);
imshow(uint8(g));
title('D0 = 40  n=1');

H = Butterworth(80,1, height, width);
g = real(ifft2(H .* F));
g = Centralize(g);
subplot(2,2,4);
imshow(uint8(g));
title('D0 = 80  n=1');