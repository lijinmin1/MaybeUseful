img = imread('office.jpg');
img = double(rgb2gray(img));
[height, width] = size(img);
figure();

% ����ԭͼ��
subplot(2, 2, 1);
imshow(img,[]);% �Զ�����ס��ķ�λ��0-1֮��
title('ԭͼ��');

% ����̬ͬ�˲���ͼ��
% gammaH = 2;
% gammaL = 0.25;
% C = 1;
% D0 = 1;
% num = 2;
% while 1
%     F = fft2(log(img + 1));% ��ֹ��ֵΪ0
%     H = HomomorphicFiltering(gammaH, gammaL, C, D0, height, width);% ��Ƶ��ͼ��ʹ�ø�ͨ��˹�˲���
%     g = real(exp(ifft2(H .* F)));% ������Ҷ�任�Ľ�������������뻹�Ǹ���
%     new_img = maxmin(g);
%     subplot(2,3,num); imshow(new_img);title(['̬ͬ�˲�(D0 = ',num2str(D0),')']);
%     D0=D0*10;
%     num=num+1;
%     if D0==100000
%         break
%     end
% end

% ����̬ͬ�˲���ͼ��
gammaH = 2;
gammaL = 0.25;
C = 1;
D0 = 1000;
F = fft2(log(img + 1));% ��ֹ��ֵΪ0
H = HomomorphicFiltering(gammaH, gammaL, C, D0, height, width);% ��Ƶ��ͼ��ʹ�ø�ͨ��˹�˲���
g = real(exp(ifft2(H .* F)));% ������Ҷ�任�Ľ�������������뻹�Ǹ���
new_img = maxmin(g);
subplot(2,2,2); imshow(new_img);title('̬ͬ�˲�(D0 = 1000)');


% �Աȸ�ͨ�˲���butterworthЧ��
F = fft2(Centralize(img));
D0 = 1;
H = Butterworth(D0, height, width);
g = real(ifft2(H .* F));
g = Centralize(g);
subplot(2,2,3); imshow(uint8(g));
title('��ͨ�˲�(D0 = 1)');
