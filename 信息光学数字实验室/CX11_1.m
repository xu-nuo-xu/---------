Uo=imread('guang.bmp');          %������Ϊ���ͼ��
Uo=double(Uo(:,:,1));            %ȡ��һ�㣬��תΪ˫����
figure,imshow(Uo,[]),title('ԭʼ��')
[r,c]=size(Uo);
lamda=6328*10^(-10);k=2*pi/lamda;%��ֵ����������
zo=0.3086;                       %�ﵽȫϢ��¼��ľ���,��λ:��
Lo=5*10^(-3)                     %��ֵ������(��)�ĳߴ�,��λ:��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��T-FFT�㷨���ȫϢͼ��¼���̵ļ���
xo=linspace(-Lo/2,Lo/2,c);yo=linspace(-Lo/2,Lo/2,r);
[xo,yo]=meshgrid(xo,yo);
F0=exp(j*k*zo)/(j*lamda*zo);
F1=exp(j*k/2/zo.*(xo.^2+yo.^2));
fa=fft2(Uo); fF1=fft2(F1);
Fuf=fa.*fF1; 
O=F0.*fftshift(ifft2(Fuf));     %��ȫϢ��¼���ϵĹⳡ�ֲ�
I=O.*conj(O);                   %ȫϢ��¼���ϵĹ�ǿ�ֲ�
figure,imshow(I,[]),colormap(pink),title('����ͼ')
%�������ο���
alpha=pi/2.00;                  %�ο�����x���ļн�
beita=pi/2.02;                  %�ο�����y���ļн�
R=exp(j*k*(xo*cos(alpha)+yo*cos(beita))); %�ο���
%�������Ρ������ȫϢ��¼���ϵĸ���,�õ�ȫϢͼ
inter=O./max(max(sqrt(I)))+R;   %���ڹ����ȣ���ʹ�Ρ�������
II= inter.*conj(inter);         %����õ�ȫϢͼ
figure,imshow(II,[]),title('ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�����������
%����S-FFT�㷨����ȫϢ��
zi=0.3086;                      %ȫϢͼ���۲���ľ���,��λ:��
Li=r*lamda*zi/Lo                %��������ĳߴ�,��λ:��
x=linspace(-Li/2,Li/2,c);y=linspace(-Li/2,Li/2,r);
[x,y]=meshgrid(x,y);
F0=exp(j*k*zi)/(j*lamda*zi)*exp(j*k/2/zi*(x.^2+y.^2));
F=exp(j*k/2/zi*(xo.^2+yo.^2));  %��T-FFT�㷨�õ���ȫϢͼ�ߴ�������һ��
% ȡ���������ⴹֱ����C=1
holo=Lo/r*Lo/c*fftshift(fft2(II.*F*1)); holo=holo.*F0;
Ii=holo.*conj(holo);
figure,imshow(Ii,[0,max(max(Ii))./1]),colormap(pink),title('S-FFT������')