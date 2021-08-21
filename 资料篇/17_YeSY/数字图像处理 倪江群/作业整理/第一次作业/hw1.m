clc;
clear;
fx = imread('river.jpg');

subplot(2,2,1);imshow(fx);title('�Ҷ�ͼ');
subplot(2,2,3);imhist(fx);title('�Ҷ�ͼ');
 
[R, C] = size(fx);

% ͳ��ÿ������ֵ���ִ���
% ��Ϊ�±���1��256��ֱ��ͼ��0��255
cum = zeros(1, 256);
for i = 1 : R
    for j = 1 : C
        cum(fx(i, j) + 1) = cum(fx(i, j) + 1) + 1;
    end
end


cum = double(cum);
% ���ۼƸ��ʣ��õ��ۼ�ֱ��ͼ
for i = 2 : 256
    cum(i) = (cum(i - 1) + cum(i));
end
 
for i = 1 : 256
    cum(i) = cum(i)/(R*C) * 255;
end

% ӳ��
fy = double(fx);
for i = 1 : R
    for j = 1 : C
        fy(i, j) = cum(fy(i, j) + 1);
    end
end
 
% �����ȻҪ�ǵø���������
fy = uint8(fy);
subplot(2,2,2);imshow(fy,[]);title('ֱ��ͼ���⻯');
subplot(2,2,4);imhist(fy);title('ֱ��ͼ���⻯');