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
Uf=(L*L/r/r).*fft2(U1yp.*F);Uf=Uf.*F0;  %��������ϵĹⳡ�ֲ�
I2=Uf.*conj(Uf);                     %�����ϵĹ�ǿ�ֲ�
figure,imshow(I2,[0,max(I2(:))/100]), colormap(pink),title('�����ϵĹ�ǿ�ֲ�')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�������ɶ�����˲���
[cc,rr]=getline(gcf,'closed'); %��ͼ��ѡ�����Σ��������긳ֵ��cc��rr
H=zeros(c,r);                            %Ԥ���˲���H
H=roipoly(H,cc,rr);                      %�����˲���H,ʹѡ�������ڵ�ֵ����1
figure,imshow(H,[])
Ufyp=H.*Uf;
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�������ͨ�������Ĺⳡ����۲���Ĺ���
dfi=do*f/(do-f)-f;                     %��������ʽ
Li=r*lamda*dfi/Lyp,                      %������ĳߴ�,��λ:��
xi=linspace(-Li/2,Li/2,r);yi=linspace(-Li/2,Li/2,c); %�������������
[xi,yi]=meshgrid(xi,yi);             %�����������������
F0=exp(j*k*dfi)/(j*lamda*dfi)*exp(j*k/2/dfi*(xi.^2+yi.^2));
F=exp(j*k/2/dfi*(xf.^2+yf.^2));
% �������ֹⳡ�����ǿ�ֲ�
Ui=fft2(Ufyp.*F);Ui=Ui.*F0;
Ii=Ui.*conj(Ui);                          %�˲��������ϵĹ�ǿ�ֲ�
figure,imshow(Ii,[]),title('������'),colormap(gray)
figure,plot(Ii(round(c/2),:))