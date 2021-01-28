Uo=imread('JTC1.bmp');                    %�����ʶ��Ŀ��ͼ��Ͳο�ͼ��
Uo=double(Uo (:,:,1));                    %��ȡ��һ�㣬ת��Ϊ˫����
Uo(Uo<=100)=0;Uo(Uo~=0)=1;                %�����ֵ��
figure,imshow(Uo,[])
[c,r]=size(Uo);                           %��ȡ���������
lamda=6328*10^(-10);k=2*pi/lamda;         %��ֵ����,��λ:��,��ʸ
f=0.004; Lo=0.001                         %��ֵ͸���Ľ���,����ĳߴ�Lo,��λ:��
D=0.00005                                 %��ֵ�˲�Ƭֱ��,��λ:��
%= = = = = = = = = = = = = = = = = = = = = = = = 
%������⴫�ݵ�͸��ǰ������������(S-FFT)
xo=linspace(-Lo/2,Lo/2,r);yo=linspace(-Lo/2,Lo/2,c); %��ֵ���������
[xo,yo]=meshgrid(xo,yo);                  %�����������������
do=0.0041;                                %���浽͸���ľ���do,��λ:��
L=r*lamda*do/Lo                           %�������͸��ǰ�����ϵĳߴ�L,��λ:��
xl=linspace(-L/2,L/2,r);yl=linspace(-L/2,L/2,c); %��ֵ͸��ǰ���������
[xl,yl]=meshgrid(xl,yl);                  %����͸��ǰ�������������
F0=exp(j*k*do)/(j*lamda*do)*exp(j*k/2/do*(xl.^2+yl.^2));
F=exp(j*k/2/do*(xo.^2+yo.^2));
FU=fftshift(fft2(Uo.*F));
U1=F0.*FU;                                %͸��ǰ�����ϵĹⳡ������ֲ�
I1=U1.*conj(U1);                          %͸��ǰ�����ϵĹ�ǿ�ֲ�
figure,imshow(I1,[]), colormap(pink),title('͸���ϵĹ�ǿ�ֲ�')
%= = = = = = = = = = = = = = = = = = = = = = = = 
%�������ͨ��͸����Ĺⳡ
U1yp=U1.*exp(-j*k.*(xl.^2+yl.^2)/2/f);   %����ͨ��͸����Ĺⳡ
%= = = = = = = = = = = = = = = = = = = = = = = = 
%�������ͨ��͸����Ĺⳡ���ｹ����������(S-FFT)
dlf=f,
Lyp=r*lamda*dlf/L,                        %��������ĳߴ�,��λ:��
xf=linspace(-Lyp/2,Lyp/2,r);yf=linspace(-Lyp/2,Lyp/2,c); %�������������
[xf,yf]=meshgrid(xf,yf);                  %���ɽ������������
F0=exp(j*k*dlf)/(j*lamda*dlf)*exp(j*k/2/dlf*(xf.^2+yf.^2));
F=exp(j*k/2/dlf*(xl.^2+yl.^2));
Uf=fft2(U1yp.*F);Uf=Uf.*F0;               %�����ϵĹⳡ
I2=Uf.*conj(Uf);                          %�����ϵĹ�ǿ�ֲ�
figure,imshow(I2,[0,max(I2(:))/100]), colormap(pink),title('�����ϵĹ�ǿ�ֲ�')
%= = = = = = = = = = = = = = = = = = = = = = = = 
Uf=I2;                                    %�ⳡ��ƽ����ת����ת���ɹ����׷ֲ�
%= = = = = = = = = = = = = = = = = = = = = = = = 
%����ͨ�������Ĺⳡ����������������(S-FFT)
dfi=do*f/(do-f)-f;
Li=r*lamda*dfi/Lyp,                      %��������ĳߴ�,��λ:��
xi=linspace(-Li/2,Li/2,r);yi=linspace(-Li/2,Li/2,c); %�������������
[xi,yi]=meshgrid(xi,yi);                 %�����������������
F0=exp(j*k*dfi)/(j*lamda*dfi)*exp(j*k/2/dfi*(xi.^2+yi.^2));
F=exp(j*k/2/dfi*(xf.^2+yf.^2));
Ui=fftshift(fft2(Uf.*F));Ui=Ui.*F0;      %�����ϵ����ֹⳡ
Ii=Ui.*conj(Ui);                         %�����ϵĹ�ǿ�ֲ�
Ii=flipud(fliplr(Ii/max(Ii(:))));        %��תͼ�񲢹�һ��
figure,imshow(Ii,[0,max(Ii(:))/100]),title('�������ǿ�ֲ�'),colormap(pink)
[xi,yi]=ginput(1);                       %�ý���ʽ�ֶ�������ص�����
figure,surfl(Ii),shading interp,colormap(gray)
figure,plot(Ii(round(yi),:)),title('����')