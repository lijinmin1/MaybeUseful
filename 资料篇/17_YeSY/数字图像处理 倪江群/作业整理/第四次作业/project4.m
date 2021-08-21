image = imread('book_cover.jpg');
[m,n] = size(image);
image = double(image);  

F1 = fftshift(fft2(image));  % ����Ҷ�任�����Ļ�

%% ��һ����
% ����ģ���˲���
a = 0.1;
b = 0.1;
T = 1;
for u = 1:m
    for v = 1:n
        x = pi * ((u-m/2)*a + (v-n/2)*b); % ��Ϊ�������Ļ���ԭ�㱻ƽ�Ƶ���m/2 n/2
        if (x == 0)
            H(u,v) = T;
        else
            H(u,v) = (T / x) * sin(x) * exp(-1i*x);
        end
    end
end
% ��ԭͼ����ģ���˲������˲� ������Ҷ���任
res1 = real(ifft2(ifftshift(F1 .* H))); %ȥ���Ļ�������һ��������Ҷ�任��ȡʵ��

% ʹ��minmax��ͼ����0��255֮��
minmax = max(res1(:)) - min(res1(:));
res1 = uint8((res1 - min(res1(:))).*255./minmax);

stand_normal_noise = randn(m,n); % randn��������һ������ı�׼��̬�ֲ�����
normal_noise = stand_normal_noise*sqrt(500)+0;% �Ա�׼��̬�ֲ�����һ�����Ա任�õ�Ŀ����̬�ֲ�
res2 = res1 + uint8(normal_noise);



%% ������
% ������Ľ�����и���Ҷ�任
F3_1 = fftshift(fft2(res1));
F3_2 = fftshift(fft2(res2));

% ���˲� �ڷ�����Ҷ�任 ��ȡʵ��
% ����Ҫ��һ��ֹ����0���������
res3_1 = real(ifft2(ifftshift(F3_1 ./ (H+1)))); 
minmax = max(res3_1(:)) - min(res3_1(:));
res3_1 = uint8((res3_1 - min(res3_1(:))) .* 255 ./ minmax);

res3_2 = real(ifft2(ifftshift(F3_2 ./ (H+1))));
minmax = max(res3_2(:)) - min(res3_2(:));
res3_2 = uint8((res3_2 - min(res3_2(:))) .* 255 ./ minmax);

K_list=[0.005,0.01,0.05,0.1];
[km,kn]=size(K_list);

figure
subplot(2,3,1), imshow(uint8(image)), title("ԭͼ��");
subplot(2,3,2), imshow(res1), title("�˶�ģ��ͼ��");
subplot(2,3,3), imshow(res2), title("�˶�ģ������ͼ��");
subplot(2,3,4), imshow(res3_1), title("���˲������˶�ģ��ͼ��");
subplot(2,3,5), imshow(res3_2), title("���˲������˶�ģ������ͼ��");

%% ������
figure
for i =1:kn
    K = K_list(i);
    Wiener = (1./H).*(abs(H).^2) ./ (abs(H).^2 + K);
    F4 = fftshift(fft2(res2)); % ��blurryͼ����Ҷ�任
    res4 = real(ifft2(ifftshift(F4 .* Wiener)));
    range = max(res4(:)) - min(res4(:));
    res4_1 = uint8((res4 - min(res4(:))) .* 255 ./ range);
    res4(:,:,i)=res4_1;
    subplot(2,2,i), imshow(uint8(res4(:,:,i))), title(["ά���˲���K=",num2str(K)]);
end

