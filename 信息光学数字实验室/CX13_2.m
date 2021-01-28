Uo=imread('guang.bmp');          %������Ϊ���ͼ��
Uo=double(Uo(:,:,1));            %ȡ��һ�㣬��תΪ˫����
figure,imshow(Uo,[]),title('ԭʼ��')
[r,c]=size(Uo);
lamda=6328*10^(-10);k=2*pi/lamda;%��ֵ����������
zo=0.20;                         %�ﵽȫϢ��¼��ľ���,��λ:��
Lo=5*10^(-3)                     %��ֵ������(��)�ĳߴ�,��λ:��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��T-FFT�㷨���ȫϢͼ��¼���̵ļ���
xo=linspace(-Lo/2,Lo/2,c);yo=linspace(-Lo/2,Lo/2,r);
[xo,yo]=meshgrid(xo,yo);
F0=exp(j*k*zo)/(j*lamda*zo);
F1=exp(j*k/2/zo.*(xo.^2+yo.^2));
fa=fft2(Uo); fF1=fft2(F1);
Fuf=fa.*fF1; 
O=F0.*fftshift(ifft2(Fuf));      %��ȫϢ��¼���ϵ���ⳡ�ֲ�
O=O./max(max(abs(O)));           %���������������1
I=O.*conj(O);                    %ȫϢ��¼���ϵĹ�ǿ�ֲ�
figure,imshow(I,[]),colormap(pink),title('�����ǿ')
%�������ο���
alpha=pi/2.00;                   %�ο�����x���ļн�
beita=pi/2.02;                   %�ο�����y���ļн�
R=exp(j*k*(xo*cos(alpha)+yo*cos(beita))); %�ο���
r2xy=R.*conj(R);                 %�ο���ǿ
%�ټ�������һ�����Ʒ��Ĳο���
derta=pi/3                       %�ο������������,��2��������
Ryp=R.*exp(j*derta);
%�������Ĵ����Ʒ��Ĳο���
R1=R.*exp(j*2*pi*0/4);           %�ο���1
R2=R.*exp(j*2*pi*1/4);           %�ο���2
R3=R.*exp(j*2*pi*2/4);           %�ο���3
R4=R.*exp(j*2*pi*3/4);           %�ο���4
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%�������Ρ������ȫϢ��¼���ϵĸ���,�õ�ȫϢͼ
%�ȼ�������һ�����Ʒ���ȫϢͼ
IH=(O+R).*conj(O+R);             %����õ�ȫϢͼIH
IHyp=(O+Ryp).*conj(O+Ryp);       %����õ�ȫϢͼIH'
figure,imshow(IH,[]),title('ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%�ټ����Ĵ����Ʒ���ȫϢͼ
I1=(O+R1).*conj(O+R1);           %����õ�ȫϢͼI1
I2=(O+R2).*conj(O+R2);           %����õ�ȫϢͼI2
I3=(O+R3).*conj(O+R3);           %����õ�ȫϢͼI3
I4=(O+R4).*conj(O+R4);           %����õ�ȫϢͼI4
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%������S-FFT�㷨����ȫϢ��
zi=0.20;                         %ȫϢͼ���۲���ľ���,��λ:��
Li=r*lamda*zi/Lo                 %��������ĳߴ�,��λ:��
x=linspace(-Li/2,Li/2,c);y=linspace(-Li/2,Li/2,r);
[x,y]=meshgrid(x,y);
F0=exp(j*k*zi)/(j*lamda*zi)*exp(j*k/2/zi*(x.^2+y.^2));
F=exp(j*k/2/zi*(xo.^2+yo.^2));   %��T-FFT�㷨�õ���ȫϢͼ�ߴ�������һ��
% ȡ���������ⴹֱ����C=1
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% �ȼ���ֱ����������������
holo1=Lo/r*Lo/c*fftshift(fft2((IH-I-r2xy).*F*1));holo1=holo1.*F0;
Ii1=holo1.*conj(holo1);
figure,imshow(Ii1,[0,max(max(Ii1))./1]),colormap(pink),title('ֱ��������������')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% �ټ���һ��������������������
holo2=Lo/r*Lo/c*fftshift(fft2((IH-IHyp).*F*1));holo2=holo2.*F0;
Ii2=holo2.*conj(holo2);
figure,imshow(Ii2,[0,max(max(Ii2))./1]),colormap(pink),title('һ������������������')
% �������Ĵ����Ʒ���������
holo3=Lo/r*Lo/c*fftshift(fft2((I1.*R1+I2.*R2+I3.*R3+I4.*R4).*F*1));holo3=holo3.*F0;
Ii3=holo3.*conj(holo3);
figure,imshow(Ii3,[0,max(max(Ii3))./1]),colormap(pink),title('�Ĵ����Ʒ�������')
holo3yp=Lo/r*Lo/c*fftshift(fft2(conj(I1.*R1+I2.*R2+I3.*R3+I4.*R4).*F*1));holo3=holo3.*F0;
Ii3yp=holo3yp.*conj(holo3yp);
figure,imshow(Ii3yp,[0,max(max(Ii3yp))./1]),colormap(pink),title('�Ĵ����Ʒ�������������')