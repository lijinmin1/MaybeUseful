clc;
clear all;
close all;
image = imread('sport car.pgm');
%����ͼ��ĳ��ȺͿ��
M = size(image, 1); N = size(image, 2);
% �����˲����ĳ��ȺͿ��
m = 3;n = 3;

% �����������ȷֲ�
t1 = rand([M,N]) * 255;
t2 = rand([M,N]) * 255;

% ���ɽ���������ͼ��
noise_image = image;
for i = 1:M
    for j = 1:N
        if image(i,j) > t1(i,j)
            noise_image(i,j) = 255;
        elseif image(i,j) < t2(i,j)
            noise_image(i,j) = 0;
        else
            noise_image(i,j)=image(i,j);
        end
        
    end
end

% ������ֵ�˲�����
pad_image = padarray(noise_image, [(m-1)/2, (n-1)/2]);% �ȶ�ԭ����ͼ�����padding
median_image = uint8(zeros([M,N]));
for i = 1:M
    for j = 1:N
        tmp=pad_image(i:i+m-1, j:j+n-1);
        tmp = sort(tmp(:));
        median_image(i,j) = tmp(5);
    end
end


% ��toolbox��medfilt2����
median_lib = medfilt2(noise_image, [3,3]);

% ����ͼ��
figure
subplot(2,2,1), imshow(image);
title("ԭͼ��");
subplot(2,2,2), imshow(noise_image);
title("��������ͼ��");
subplot(2,2,3), imshow(median_image);
title("��ֵ�˲�ͼ��");
subplot(2,2,4), imshow(median_lib);
title("�������ͼ��");