ph=peaks(256)*3;                     %Ԥ��ԭʼ��λ
mu=0.5;                              %����ϵ��
noise=rands(256,256).*mu.*pi;        %����
ph=ph+noise;                         %������������Ԥ��ԭʼ��λ
U=exp(j*ph); ph0=angle(U);           %��Ӧ�İ�����λ
[r,c]=size(ph0);
figure,imshow(ph0,[])
unph=ph0;                             %Ԥ�����������λ
unph(1,:)=unwrap_one_d(ph0(1,:),ph0(1,1),pi);%����ɵ�һ��Ԫ�صĽ��������
for n=1:c
    %������ɵ�n��Ԫ�صĽ�������㣬��ʼ��λֵΪ���е�һ����Ԫ�صĽ������λֵ
    unph(:,n)=unwrap_one_d(ph0(:,n),unph(1,n),pi);
end
figure,imshow(unph,[])