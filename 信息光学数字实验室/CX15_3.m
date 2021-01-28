%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��������
r=512,c=r;                           %���������ϵĳ�����
Uo=zeros(c,r);                       %Ԥ��ƽ������
Uo(c/2-c/4+1:c/2+c/4, r/2-r/4+1:r/2+r/4)=1; %���ɾ���ƽ�棨��ǰ�����壩
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��T-FFT�㷨���ȫϢͼ��¼���̵ļ���
lamda=6328*10^(-10);k=2*pi/lamda;    %��ֵ����������
zo=0.3086;                           %�ﵽȫϢ��¼��ľ���,��λ:��
Lo=5*10^(-3)                         %��ֵ������(��)�ĳߴ�,��λ:��
xo=linspace(-Lo/2,Lo/2,r);yo=linspace(-Lo/2,Lo/2,c);
[xo,yo]=meshgrid(xo,yo);
F0=exp(j*k*zo)/(j*lamda*zo);
F1=exp(j*k/2/zo.*(xo.^2+yo.^2));
fa=fft2(Uo);fF1=fft2(F1);
Fuf=fa.*fF1; 
O=F0.*fftshift(ifft2(Fuf));           %��ȫϢ��¼���ϵ���ⳡ�ֲ�
I=O.*conj(O);                         %ȫϢ��¼���ϵĹ�ǿ�ֲ�
O=O./max(max(sqrt(I)));               %���ڹ�����
figure,imshow(I,[]),colormap(pink),title('��ǰ��������ͼ')
%�������ο���
alpha=pi/2.00;                        %�ο�����x���ļн�
beita=pi/2.0175;                      %�ο�����y���ļн�
R=exp(j*k*(xo*cos(alpha)+yo*cos(beita))); %�ο���
%�������Ρ������ȫϢ��¼���ϵĸ���,�õ�ȫϢͼ
inter=O+R;                            %�Ρ�������
I=inter.*conj(inter);                 %����õ�ȫϢͼ
figure,imshow(I,[]),title('��ǰ��ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%���������񶯺���ȫϢ��¼���ϵ���ⳡ�ֲ�
%������������α�
thita1=pi/2;thita2=pi/3;               %����Ǻͷ����
amplitude=zeros(c,r);                  %Ԥ�����
amplitude(c/2-c/4+1:c/2+c/4,r/2-r/4+1:r/2+r/4)=abs(peaks(256)-min(min(peaks(256))));%��peaks������ֵ���
amplitude=amplitude./max(max(amplitude)).*5.*lamda; %����������ֵ������������5��
phai0=pi;omiga=5;n=50;   %��ֵ�񶯵ĳ��ࡢ��Ƶ�ʣ�һ�������еĳ�������
t=linspace(0,2.*pi/omiga,n);            %��ֵ����ʱ��
Icontinue=zeros(c,r);                   %Ԥ�������ع�ȫϢͼ
for ii=1:n
Uoyp=Uo.*exp(j.*k.*amplitude.*cos(omiga.*t(ii)+phai0).*(cos(thita1)+cos(thita2)));%�񶯺����Ⲩ
%��T-FFT�㷨���������㣬�õ�ȫϢͼ
fayp=fft2(Uoyp);Fufyp=fayp.*fF1; 
Oyp=F0.*fftshift(ifft2(Fufyp));         %��ȫϢ��¼���ϵ���ⳡ�ֲ�
Iyp=Oyp.*conj(Oyp);                     %ȫϢ��¼���ϵĹ�ǿ�ֲ�
Oyp=Oyp./max(max(sqrt(Iyp)));           %���ڹ�����
interyp=Oyp+R;                          %�Ρ�������
Iyp=interyp.*conj(interyp);             %����õ�ȫϢͼ
Icontinue=Icontinue+Iyp;                %����(���)�ع�
end
figure,imshow(Icontinue,[]),title('ʱ��ƽ��ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%������S-FFT�㷨����ȫϢ��
zi=0.3086                              %���������λ��,��λ:��
Li=r*lamda*zi/Lo                       %��������ĳߴ�,��λ:��
x=linspace(-Li/2,Li/2,r);y=linspace(-Li/2,Li/2,c);
[x,y]=meshgrid(x,y);
F0=exp(j*k*zi)/(j*lamda*zi)*exp(j*k/2/zi*(x.^2+y.^2));
F=exp(j*k/2/zi*(xo.^2+yo.^2));  %��T-FFT�㷨�õ���ȫϢͼ�ߴ�������һ��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
% ȡ����������Ϊ�ο���R������û���������������
holo1=Lo/r*Lo/c*fftshift(fft2(I.*F.*R)); holo1=holo1.*F0;
Ii1=holo1.*conj(holo1);
figure,imshow(Ii1,[0,max(max(Ii1))./1]),colormap(pink),title('û���������������')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
% ȡ����������Ϊ�ο���R������ʱ��ƽ��ȫϢ��������
holo2=Lo/r*Lo/c*fftshift(fft2(Icontinue.*F.*R)); holo2=holo2.*F0;
Ii2=holo2.*conj(holo2);
figure,imshow(Ii2,[0,max(max(Ii2))./1]),colormap(pink),title('ʱ��ƽ��ȫϢ��������')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
% ������㱴������������������Ʒֲ�ͼ
a=k.*amplitude(c/2-c/4+1:c/2+c/4, r/2-r/4+1:r/2+r/4).*(cos(thita1)+cos(thita2));
J=besselj(0,a);
J2=J.*J;
figure,imshow(J2,[]),colormap(pink),title('�������������Ʒֲ�')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =