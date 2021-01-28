Uo=imread('�ֱ��ʰ�_2.bmp');               %������Ϊ���ͼ��
Uo=double(Uo(:,:,1));                      %��ȡ��һ�㣬ת��Ϊ˫����
[c,r]=size(Uo);                            %��ȡ���������
lamda=6328*10^(-10);k=2*pi/lamda;          %��ֵ����,��λ:��,��ʸ
D=0.01;                                    %��ֵ͸���Ŀ׾�,��λ:��
f=0.4;                                     %��ֵ͸���Ľ���,��λ:��
figure,imshow(Uo,[])
Lo=0.005;                                  %����ߴ�,��λ:��
do=1.2;                       %�ﵽ͸���ľ���,�༴��ͫ��,��λ:��,���Ըı�
di=do*f/(do-f);                            %͸�����۲����ľ���,��λ:��
cutoff_frequency=D/2/lamda/di;             %��ֹƵ��(�����۵�)
Li=Lo*di/do;                               %����ߴ�,��λ:��
kethi=linspace(-1./2./Li,1./2./Li,r).*r;nenta=linspace(-1./2./Li,1./2./Li,c).*c;
[kethi,nenta]=meshgrid(kethi,nenta);       %��Ķ�άƵ������
H=zeros(c,r);                              %Ԥ�贫�ݺ���
for n=1:c
   for m=1:r
      if kethi(n,m).^2+nenta(n,m).^2<=cutoff_frequency.^2;
      H(n,m)=1;
      end
   end
end
figure,imshow(H,[]);title('���ݺ���')
Gg=fftshift(fft2(Uo));                     %�������Ƶ��
Gi=Gg.*H;                                  %���Ƶ��
Ui=ifft2(Gi);                              %��Ĺⳡ�ֲ�
Ii=Ui.*conj(Ui);                           %��Ĺ�ǿ�ֲ�
figure,imshow(Ii,[]),title('��Ĺ�ǿ�ֲ�')