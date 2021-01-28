r=512,c=r;                         %���������
Uo=zeros(c,r);                      %Ԥ����
d=30;a=10;                        %��դ�����ͷ��
for n=1:d:c                        %ѭ��������(��ά��դ)
   Uo(n:n+a,:)=1;
end
for m=1:d:r
   Uo (:,m:m+a)=1;
end
Uo=Uo(1:c,1:r);
figure,imshow(Uo,[])                 %��ʾ��ֲ�
lamda=6328*10^(-10);k=2*pi/lamda;    %��ֵ����,��λ:��,��ʸ
f=0.004; Lo=0.001                   %��ֵ͸���Ľ���,����ĳߴ�Lo,��λ:��
D1=0.00005                        %��ֵ�˲�Ƭֱ��,��λ:��
D2=0.00005                        %��ֵ�˲�Ƭ���,��λ:��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%���������⴫�ݵ�͸�����������(S-FFT)
xo=linspace(-Lo/2,Lo/2,r);yo=linspace(-Lo/2,Lo/2,c); %��ֵ���������
[xo,yo]=meshgrid(xo,yo);             %�����������������
do=0.0041;                         %���浽͸���ľ���do,��λ:��
L=r*lamda*do/Lo                    %�������͸��ǰ�����ϵĳߴ�L,��λ:��
xl=linspace(-L/2,L/2,r);yl=linspace(-L/2,L/2,c); %��ֵ͸��ǰ���������
[xl,yl]=meshgrid(xl,yl);               %����͸��ǰ�������������
F0=exp(j*k*do)/(j*lamda*do)*exp(j*k/2/do*(xl.^2+yl.^2));
F=exp(j*k/2/do*(xo.^2+yo.^2));
FU=(Lo*Lo/r/r).*fftshift(fft2(Uo.*F)); 
U1=F0.*FU;                         %͸��ǰ�����ϵĹⳡ������ֲ�
I1=U1.*conj(U1);                     %͸��ǰ�����ϵĹ�ǿ�ֲ�
figure,imshow(I1,[]), colormap(pink),title('͸���ϵĹ�ǿ�ֲ�')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�������ͨ��͸����Ĺⳡ
U1yp=U1.*exp(-j*k.*(xl.^2+yl.^2)/2/f);   %����ͨ��͸����Ĺⳡ
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�������ͨ��͸����Ĺⳡ�������Ĺ���(S-FFT)
dlf=f,
Lyp=r*lamda*dlf/L,                   %��������ĳߴ�,��λ:��
xf=linspace(-Lyp/2,Lyp/2,r);yf=linspace(-Lyp/2,Lyp/2,c); %�������������
[xf,yf]=meshgrid(xf,yf);               %���ɺ������������
F0=exp(j*k*dlf)/(j*lamda*dlf)*exp(j*k/2/dlf*(xf.^2+yf.^2));
F=exp(j*k/2/dlf*(xl.^2+yl.^2));
Uf=(L*L/r/r).*fft2(U1yp.*F);Uf=Uf.*F0;  % ��������ϵĹⳡ�ֲ�
I2=Uf.*conj(Uf);                     % �����ϵĹ�ǿ�ֲ�
figure,imshow(I2,[0,max(I2(:))/100]), colormap(pink),title('�����ϵĹ�ǿ�ֲ�')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�������������˲���
DD=round(D1*r/Lyp);                 %��ֵ�˲���ֱ������λ������
SD=round(D2*r/Lyp/2);                %��ֵ�˲����������λ������
H1=zeros(c,r);                        %Ԥ���˲���H1
for n=1:c                            %ѭ�������˲���H1
   for m=1:r
      if (n-c/2-1).^2+(m-r/2-1).^2<=(DD/2).^2;
      H1(n,m)=1;
      end
   end
end
figure,subplot(1,3,1),imshow(H1,[]);title('�˲���H1')
H2=zeros(c,r);                        %Ԥ���˲���H2
H2(round(c/2)-SD:round(c/2)+SD,:)=1;    %�����˲���H2
subplot(1,3,2),imshow(H2,[]);title('�˲���H2')
H3=zeros(c,r);                        %Ԥ���˲���H3
H3(:,round(r/2)-SD:round(r/2)+SD)=1;    %�����˲���H3
subplot(1,3,3),imshow(H3,[]);title('�˲���H3')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��������˲����õ�������ͬ�Ĺⳡ
Uf1=H1.*Uf;
Uf2=H2.*Uf;
Uf3=H3.*Uf;
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�������ͨ�������Ĺⳡ�������������������(S-FFT)
dfi=do*f/(do-f)-f;                     %��������ʽ
Li=r*lamda*dfi/Lyp,                  %��������ĳߴ�,��λ:��
xi=linspace(-Li/2,Li/2,r);yi=linspace(-Li/2,Li/2,c); %�������������
[xi,yi]=meshgrid(xi,yi);                %�����������������
F0=exp(j*k*dfi)/(j*lamda*dfi)*exp(j*k/2/dfi*(xi.^2+yi.^2));
F=exp(j*k/2/dfi*(xf.^2+yf.^2));
%�ȼ���û���˲�ʱ�����ֹⳡ�����ǿ�ȷֲ�
Ui=(Lyp*Lyp/r/r).*fft2(Uf.*F);Ui=Ui.*F0;
Ii=Ui.*conj(Ui);                     %���˲�ʱ�����ϵĹ�ǿ�ֲ�
figure,imshow(Ii,[]),title('���˲�ʱ��������'),colormap(gray)
% �ٷֱ���������˲�������ֹⳡ�������ǿ�ȷֲ�
Ui1=(Lyp*Lyp/r/r).*fft2(Uf1.*F);Ui1=Ui1.*F0;
Ii1=Ui1.*conj(Ui1);                   %��H1�˲�ʱ�����ϵĹ�ǿ�ֲ�
figure,imshow(Ii1,[]),title('��H1�˲���������'),colormap(gray)
Ui2=(Lyp*Lyp/r/r).*fft2(Uf2.*F);Ui2=Ui2.*F0;
Ii2=Ui2.*conj(Ui2);                   %��H2�˲�ʱ�����ϵĹ�ǿ�ֲ�
figure,imshow(Ii2,[]),title('��H2�˲���������'),colormap(gray)
Ui3=(Lyp*Lyp/r/r).*fft2(Uf3.*F);Ui3=Ui3.*F0;
Ii3=Ui3.*conj(Ui3);                   %��H3�˲�ʱ�����ϵĹ�ǿ�ֲ�
figure,imshow(Ii3,[]),title('��H3�˲���������'),colormap(gray)
figure, subplot(2,1,1),plot(Ii1(round(c/2),:))
subplot(2,1,2),plot(Ii2(round(c/2),:))