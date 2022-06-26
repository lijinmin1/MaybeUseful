% ��ȡͼƬ���õ��Ҷ�ͼ
Origin      = imread('EightAM.png');
Refer   = imread('LENA.png');
histO    = imhist(Origin);          
histRefer = imhist(Refer);

% ʹ��cumsum���������ۻ���
cum_sum_O     = cumsum(histO) / numel(Origin);
cum_sum_R  = cumsum(histRefer) / numel(Refer);

% ����ӳ���ϵ
map  = zeros(1,256);
for idx = 1 : 256
    % �ҵ���ԭͼ���⻯���ÿ���Ҷȼ�
    a=abs(cum_sum_O(idx) - cum_sum_R); % �Һ�cdf(idx)��ӽ��ĻҶ�ֵ���±ꡣ
    [b,index] = min(a);
    map(idx)    = index-1;
end
 
% �±��Ǵ�1��256 �Ҷȼ���0��255�����Ҫ��һ��ͬʱ��ȡ����
OMatch = map(uint16(Origin)+1);

%��ʾͼ��
figure;
subplot(1,3,1),imshow(Origin,[]);title('ԭͼ��');
subplot(1,3,2),imshow(Refer,[]);title('ƥ��ͼ��');
subplot(1,3,3),imshow(OMatch,[]);title('ƥ��֮��ͼ��');

%��ʾֱ��ͼ
figure;
subplot(3,1,1),imhist(Origin,256);title('ԭͼ��ֱ��ͼ');
subplot(3,1,2),imhist(Refer,256);title('ƥ��ͼ��ֱ��ͼ');
subplot(3,1,3),imhist(uint8(OMatch),256);title('ƥ��֮��ͼ��ֱ��ͼ');