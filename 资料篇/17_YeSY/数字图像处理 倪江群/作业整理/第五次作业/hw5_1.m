clc
clear
A = [0, 0, 0, 0, 0, 0, 0;
     0, 0, 1, 1, 0, 0, 0;
     0, 0, 0, 1, 0, 0, 0;
     0, 0, 0, 1, 1, 0, 0;
     0, 0, 1, 1, 1, 1, 0;
     0, 0, 1, 1, 1, 0, 0;
     0, 1, 0, 1, 0, 1, 0;
     0, 0, 0, 0, 0, 0, 0]; 

figure;
subplot(3,2,1);imshow(A);title('ԭͼ');
subplot(3,2,3);R1 = Dilation1(A);imshow(R1);title('����1');
subplot(3,2,4);R2 = Erosion1(A);imshow(R2);title('��ʴ1');
subplot(3,2,5);R3 = Dilation2(A);imshow(R3);title('����2');
subplot(3,2,6);R4 = Erosion2(A);imshow(R4);title('��ʴ2');
figure;
subplot()
subplot(2,2,1);R5 = Dilation1(Erosion1(A));imshow(R5);title('���任1');
subplot(2,2,3);R6 = Dilation2(Erosion2(A));imshow(R6);title('���任2');
subplot(2,2,2);R7 = Erosion1(Dilation1(A));imshow(R7);title('�ձ任1');
subplot(2,2,4);R8 = Erosion2(Dilation2(A));imshow(R8);title('�ձ任2');

% ע�� ��Ҫ��ͼƬ����padding0�����������֤
function R = Dilation1(I)
    kernal = [1, 1, 1];  % ԭ���ṹ��Ԫ�����ڵ�һ��λ�� ���ŵ�ʱ����һ��180�ȷ�ת ���ĵ��˵�����λ��
    [m, n] = size(I);
    R = zeros(m, n);
    padding_I = zeros(m, n+2);
    padding_I(:, 3:n+2) = I;
    for i = 1:m
        for j = 1:n
            R(i,j) = 1-min(xor(kernal,padding_I(i,j:j+2)));
        end
    end
end

function R = Erosion1(I)
    kernal = [1, 1, 1];
    [m, n] = size(I);
    R = zeros(m, n);
    padding_I = zeros(m, n+2);
    padding_I(:, 1:n) = I;
    for i = 1:m
        for j = 1:n
            R(i,j) = 1 - max(xor(kernal,padding_I(i,j:j+2)));
        end
    end
end

function R = Dilation2(I)
    kernal = [1, 0; 1, 1];% ԭ�����������Ͻ� ��һ��180�ȷ�ת�������½�
    [m, n] = size(I);
    R = zeros(m, n);
    padding_I = zeros(m+1, n+1);
    padding_I(2:m+1, 1:n) = I;
    for i = 1:m
        for j = 1:n
            R(i, j) = sign(sum(dot(kernal,padding_I(i:i+1,j:j+1))));
        end
    end
end

function R = Erosion2(I)
    kernal = [1, 1; 0, 1];
    [m, n] = size(I);
    R = zeros(m, n);
    padding_I = zeros(m+1, n+1);
    padding_I(1:m, 2:n+1) = I;
    for i = 1:m
        for j = 1:n
            if  sum(dot(kernal,padding_I(i:i+1,j:j+1)))==3
                R(i, j) = 1;
            else
                R(i, j) = 0;
            end
        end
    end
end