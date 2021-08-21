function accuracy = Identify(train_data, test_data,test_label)
    [coeff, ~, ~] = pca(train_data); % ʹ��pcaѵ������
    train_pca = train_data * coeff;  % ��ѵ��������ӳ�䵽kά�ռ���
    % ����ͼ��ʶ��
    [M, N] = size(train_data); % ��ȡ���ݿ������ݼ���С
    [m, n] = size(test_data); % ��ȡ�ȴ����Ե�ͼƬ���ݼ���С
    count = 0;  % ͳ����ȷԤ���ͼƬ��
    for i = 1:m
        similarity = [];
        test_pca = test_data(i,:) * coeff;
        for k = 1:M   % ������������ͼ����������� ����ʹ����ͼƬ�ľ���
            similarity = [similarity,norm(train_pca(k,:) - test_pca, 2)];
        end
        [~, index] = min(similarity);   % �����п����������ҳ����ƶ���ߵ�����
        if index == test_label(i)
            count = count+1;
        end
    end
    accuracy = count / m;
end