%��������
r=512,c=r;                       %���������ϵĳ�����
Uo=zeros(c,r);                   %Ԥ��ƽ������
Uo(c/2-c/4:c/2+c/4, r/2-r/4:r/2+r/4)=1; %���ɾ��Σ�����ǰ�����壩
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�������κ������
Uoyp=Uo.*exp(j.*peaks(r).*2);    %�������ϵ�����λ��ģ����κ������
lamda=6328*10^(-10);k=2*pi/lamda;%��ֵ����������
zo=0.3086;                       %�ﵽȫϢ��¼��ľ���,��λ:��
Lo=5*10^(-3)                     %��ֵ������(��)�ĳߴ�,��λ:��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��T-FFT�㷨����������ǰȫϢͼ��¼���̵ļ���
xo=linspace(-Lo/2,Lo/2,r);yo=linspace(-Lo/2,Lo/2,c);
[xo,yo]=meshgrid(xo,yo);
F0=exp(j*k*zo)/(j*lamda*zo);
F1=exp(j*k/2/zo.*(xo.^2+yo.^2));
fa=fft2(Uo); fF1=fft2(F1);
Fuf=fa.*fF1; 
O=F0.*fftshift(ifft2(Fuf));      %��ȫϢ��¼���ϵ���ⳡ�ֲ�
I=O.*conj(O);                    %ȫϢ��¼���ϵĹ�ǿ�ֲ�
O=O./max(max(sqrt(I)));          %���ڹ�����
figure,imshow(I,[]),colormap(pink),title('����ǰ��������ͼ')
%�������ο���
alpha=pi/2.00;                   %�ο�����x���ļн�
beita=pi/2.0175;                 %�ο�����y���ļн�
R=exp(j*k*(xo*cos(alpha)+yo*cos(beita))); %�ο���
%�������Ρ������ȫϢ��¼���ϵĸ���,�õ�ȫϢͼ
inter=O+R;                       %�Ρ�������
IH= inter.*conj(inter);          %����õ���ȫϢͼ
figure,imshow(IH,[]),title('����ǰ����ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%����������κ���ȫϢ��¼���ϵ���ⳡ�ֲ�
fayp=fft2(Uoyp);
Fufyp=fayp.*fF1; 
Oyp=F0.*fftshift(ifft2(Fufyp));  %��ȫϢ��¼���ϵ���ⳡ�ֲ�
Iyp=Oyp.*conj(Oyp);              %ȫϢ��¼���ϵ������ǿ�ֲ�
figure,imshow(Iyp,[]),colormap(pink),title('������������ͼ')
Oyp=Oyp./max(max(sqrt(Iyp)));    %���ڹ�����
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��͸����������
f=0.10                           %͸�����࣬��λ����
zi=zo*f/(zo-f)                   %�������
lens=exp(-j*k.*(xo.^2+yo.^2)/2/f);%͸������λ�任ϵ��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�����������
%��S-FFT�㷨����ȫϢ��
Li=r*lamda*zi/Lo                 %��������ĳߴ�,��λ:��
x=linspace(-Li/2,Li/2,r);y=linspace(-Li/2,Li/2,c);
[x,y]=meshgrid(x,y);
F0=exp(j*k*zi)/(j*lamda*zi)*exp(j*k/2/zi*(x.^2+y.^2));
F=exp(j*k/2/zi*(xo.^2+yo.^2));  %��T-FFT�㷨�õ���ȫϢͼ�ߴ�������һ��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
% ��ȡ����������Ϊ�ο���R
UR=Lo/r*Lo/c*fftshift(fft2(IH.*F.*R.*lens));UR=UR.*F0; %���ֹⳡ
Ii=UR.*conj(UR);
figure,imshow(Ii,[0,max(max(Ii))./1]),colormap(pink),title('�ο��������õ���������')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
% ��ȡ����������Ϊ���κ�����
UO=Lo/r*Lo/c*fftshift(fft2(IH.*F.*Oyp.*lens));UO=UO.*F0; %���ֹⳡ
Iiyp=UO.*conj(UO);
figure,imshow(Iiyp,[0,max(max(Iiyp))./1]),colormap(pink),title('������������õ���������')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
% �����������ֹⳡ�ĸ�����
II=(UR+UO).*conj(UR+UO);
figure,imshow(II,[0,max(max(II))]),colormap(pink),title('ͬʱ�����õ��ĸ�������')