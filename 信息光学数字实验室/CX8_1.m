Uo=imread('�ֱ��ʰ�_2.bmp');               %������Ϊ���ͼ��
Uo=double(Uo(:,:,1));                      %��ȡ��һ�㣬ת��Ϊ˫����
[c,r]=size(Uo);                            %��ȡ���������
lamda=6328*10^(-10);k=2*pi/lamda;          %��ֵ����,��λ:��,��ʸ
D=0.01;                                    %��ֵ͸���Ŀ׾�,��λ:��
f=0.4;                                     %��ֵ͸���Ľ���,��λ:��
figure,imshow(Uo,[])
Lo=0.005;                                  %����ߴ�,��λ:��
do=1.2;                                    %�ﵽ͸���ľ���,�༴��ͫ��,��λ:��,���Ըı�
di=do*f/(do-f);                            %͸�����۲����ľ���,��λ:��
cf=D/2/lamda/di;                           %��ֹƵ��(�����۵�)
Li=Lo*di/do;                               %����ߴ�,��λ:��
kethi=linspace(-1./2./Li,1./2./Li,r).*r;nenta=linspace(-1./2./Li,1./2./Li,c).*c;
[kethi,nenta]=meshgrid(kethi,nenta);       %��Ķ�άƵ������
H=zeros(c,r);                              %Ԥ�贫��ɵݺ���
for n=1:c
   for m=1:r
      if kethi(n,m).^2+nenta(n,m).^2<=cf.^2;
      H(n,m)=1;
      end
   end
end
figure,surfl(H),shading interp,colormap(gray);title('��ɴ��ݺ���CTF ')
Gg=fftshift(fft2(Uo));                     %�������Ƶ��
Gic=Gg.*H;                                 %������������Ƶ��
Uic=ifft2(Gic);                            %�����������Ĺⳡ�ֲ�
Iic=Uic.*conj(Uic);                        %�����������Ĺ�ǿ�ֲ�
figure,imshow(Iic,[]),title('�����������Ĺ�ǿ�ֲ�')
%���濪ʼ��ɷ���������µĳ������
%�����㷨1����OTF
h=fftshift(fft2(H));                       %��(8-30)�������������������Ӧ
HH=abs(fftshift(fft2(h.*conj(h))));        %����CTF�����������
OTF1=HH./max(max(HH));                     %�����������������һ��
figure,surfl(OTF1),shading interp,colormap(gray);title('�㷨1�õ��Ĺ�ѧ���ݺ���')
%�����㷨2����OTF
[phai,rou]=cart2pol(kethi,nenta);          %����άƵ���ֱ������תΪ������
OTF2=zeros(c,r);                           %Ԥ���ѧ���ݺ���
for n=1:c                                  %��ʽ(8-31)ѭ����ֵ��ѧ���ݺ���
   for m=1:r
      if rou(n,m)<=2.*cf
      OTF2(n,m)=2*(acos(rou(n,m)/2/cf)-rou(n,m)/2/cf.*sqrt(1-(rou(n,m)/2/cf).^2))/pi;
      end
   end
end
figure,surfl(OTF2),shading interp,colormap(gray);title('�㷨2�õ��Ĺ�ѧ���ݺ���')
%������������㷨�ĳ�����
Gii1=Gg.*OTF1;                             %��������������Ƶ�ף���OTF1��
Iii1=abs(ifft2(Gii1));                     %����������µĳ�����OTF1��
figure,imshow(Iii1,[]),title('��OTF1�õ��ķ������������'),colormap(gray)
Gii2=Gg.*OTF2;                             %��������������Ƶ�ף���OTF2��
Iii2=abs(ifft2(Gii2));                     %����������µĳ�����OTF2��
figure,imshow(Iii2,[]),title('��OTF2�õ��ķ������������'),colormap(gray)