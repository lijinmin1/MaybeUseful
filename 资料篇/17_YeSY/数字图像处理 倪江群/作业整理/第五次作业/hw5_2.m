clc
clear

A = im2double(imread('blobz1.png'));
figure;
subplot(2,2,1);imshow(A);title("ԭͼ1")
subplot(2,2,2);imshow(segmentation(A));title("ͼ1ֱ�Ӵ����")

B = im2double(imread('blobz2.png'));
subplot(2,2,3);imshow(B);title("ͼ2")
subplot(2,2,4);imshow(segmentation(B));title("ͼ2ֱ�Ӵ����")
[m, n] = size(B);

figure
segments = [2,4,6,8];
[sm,sn]=size(segments);
R=B; % ����һ��һ�������������װ���ɵ�Ŀ��
for s=1:sn
    segment=segments(s);
    for i = 1:segment
        for j = 1:segment
            PB = segmentation(B(floor((i-1)/segment*m+1):min(floor(i/segment*m),m), floor((j-1)/segment*n+1):min(floor(j/segment*n),n)));
            R(floor((i-1)/segment*m)+1:min(floor(i/segment*m),m), floor((j-1)/segment*n)+1:min(floor(j/segment*n),n)) = PB;
        end
    end
    subplot(2,2,s);imshow(R);title("ͼ2�ֿ鴦��")
end

