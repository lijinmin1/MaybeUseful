function [train_data,test_data,test_label] = divide_data(n)  
    train_data = zeros(40,10304);   % ��ͼ�������չƽ��10304ά������
    test_data = [];
    test_label=[];
    
    % ����ÿ�������ÿ����Ƭ
    for i = 1:40
        random_num = randperm(10, n);  % ��10��������Ƭ��ѡ��n����Ϊѵ����
        for j = 1:10
            img = reshape(double(imread(['./ORL_faces/s',num2str(i),'/',num2str(j),'.pgm'])),1,10304); 
            if ismember(j, random_num)
                train_data(i,:) = train_data(i,:) + img;
            else
                test_data = [test_data; img];
                test_label = [test_label;i];   % ��¼ѵ�����ı�ǩ
            end
        end
    end
    train_data = train_data / n;       % ���㼸��ͼƬ��ƽ��ֵ
end

