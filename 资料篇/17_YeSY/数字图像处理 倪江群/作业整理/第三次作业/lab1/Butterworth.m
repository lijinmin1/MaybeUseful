function H = Butterworth( D0,n, height, width )
    % D0�����õĽ�ֹ��Ƶ��ֵ
    % n����ΪButterworth�Ľ���
    for i = 1 : height
        x = i - (height / 2);
        for j = 1 : width
            y = j - (width / 2);
            H(i, j) = 1 / (1 + ((x ^ 2 + y ^ 2) / (D0 ^ 2))^n);
        end
    end
end
