clc;
clear;

accuracy = []
n = 5;  % ÿ���˵�10����Ƭ���ü�����Ϊѵ����
% ��Ϊÿ�ζ������ѡ��ͼ��ģ����Կ��Զೢ�Լ���ѡ����ȷ����ߵ����
times = 100; 
for i = 1:times
    [train_data,test_data,test_label] = divide_data(n);
    accuracy = [accuracy, Identify(train_data, test_data,test_label)];
end
max_acc = max(accuracy)  % �ҳ�������ȷ��
meanAccu = mean(accuracy);
x = 1:times;
plot(x, accuracy,'-o');
xlabel('times');
ylabel('accuracy');