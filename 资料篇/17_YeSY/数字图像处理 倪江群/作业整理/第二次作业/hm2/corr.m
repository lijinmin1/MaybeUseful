% ת���double���͵�
image = double(imread('car.png'));
filter = double(imread('wheel.png'));

%��ȡͼ��ĳ��ȺͿ��
M = size(image,1);
N = size(image,2);

%��ȡƥ��ģ��ĳ��ȺͿ��
m=size(filter,1);
n=size(filter,2);
row_middle=(m-1)/2+1;
col_middle=(n-1)/2+1;

%����һ��ȫ0�ľ����ԭ����ͼ���Сһ��
%Ϊ���þ������������ͼ���Сһ�£������Ҫ����չͼƬ��
Corr_image = zeros([M,N]);
pad_image = padarray(image, [(m-1)/2, (n-1)/2]);

%�������
for i = (1+(m-1)/2):(M+(m-1)/2)
    for j = (1+(n-1)/2):(N+(n-1)/2)
        % ����һ��filter�еľ����  �˲���Ҳ���Ի��ɾ���ĵ����ʽ
        corr_sum=0;normal_sum=0;
        for x = -(m-1)/2:(m-1)/2
           for y = -(n-1)/2:(n-1)/2
               corr_sum=corr_sum+pad_image(i+x,j+y)*filter(row_middle+x,col_middle+y); % ���㹫ʽ�еķ��Ӳ��� �����
               normal_sum=normal_sum+pad_image(i+x,j+y); % ���㹫ʽ�еķ�ĸ���� ��һ���ĺ�
           end
        end
        Corr_image(i-(m-1)/2,j-(n-1)/2)=corr_sum/normal_sum;
    end
end

% ��һ������ ���ҳ���ֵ����һ���ĵ�
Corr_image=Corr_image./max(max(Corr_image));
res=[];
for i =1+(m-1)/2:M-(m-1)/2
    for j = 1+(n-1)/2:N-(n-1)/2
        if Corr_image(i,j) >0.86
            % ��ָ����ͬ���ӵĵ����ȥ��
            flag=1;a=size(res,1);
            for index=1:a
               if sqrt((res(index,1)-i)^2+(res(index,2)-j)^2)<10
                   flag=0;break;
               end
            end
            if flag==1
                res=[res;i,j];
            end
            wheel=image(i-(m-1):i+(m-1),j-(n-1):j+(n-1)); % ��ȡ�����Ӳ��ֵ�ͼ��
            imshow(wheel./max(max(wheel)));
            
        end
    end
end
res


% ��������ļ���
% fid=fopen('corr_mat.txt','w');
% for i=1:M
%     for j=1:N
%         if j==N
%             fprintf(fid,'%d\r\n',Corr_image(i,j));%��������һ�����ͻ���
%         else
%             fprintf(fid,'%d\r\t',Corr_image(i,j));%����������һ������tab
%         end
%     end
% end
% fclose(fid);



