Uo=imread('�ֱ��ʰ�_2.bmp');               %������Ϊ���ͼ��
Uo=double(Uo(:,:,1));                      %��ȡ��һ�㣬ת��Ϊ˫����
lamda=6328*10^(-10);k=2*pi/lamda;          %��ֵ����,��λ:��,��ʸ
D=0.01;                                    %��ֵ͸���Ŀ׾�,��λ:��
f=0.4;                                     %��ֵ͸���Ľ���,��λ:��
figure,imshow(Uo,[])
[c,r]=size(Uo);                            %��ȡ���������
Lo=0.005;                                  %����ߴ�,��λ:��
do=1.2;                                    %�ﵽ͸���ľ���,�༴��ͫ��,��λ:��,���Ըı�
cutoff_frequency=D/2/lamda/do;             %��ֹƵ��(�����۵�)
kethi=linspace(-1./2./Lo,1./2./Lo,r).*r; nenta=linspace(-1./2./Lo,1./2./Lo,c).*c;
[kethi,nenta]=meshgrid(kethi,nenta);       %��Ķ�άƵ������
H=zeros(c,r);                              %Ԥ�贫�ݺ���
for n=1:c
   for m=1:r
      if kethi(n,m).^2+nenta(n,m).^2<= cutoff_frequency.^2;
         H(n,m)=1;
      end
   end
end
figure,imshow(H,[]);title('���ݺ���')
Gg=fftshift(fft2(Uo));                      %���Ƶ��
Gi=Gg.*H;                                   %���Ƶ��
Ui=ifft2(Gi);                               %��Ĺⳡ�ֲ�
Ii=Ui.*conj(Ui);                            %��Ĺ�ǿ�ֲ�
figure,imshow(Ii,[]),title('��Ĺ�ǿ�ֲ�')