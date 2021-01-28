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
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%�������Ρ������ȫϢ��¼���ϵĸ���,�õ�ȫϢͼ
IH=(O+R).*conj(O+R);             %����õ�ȫϢͼIH
figure,imshow(IH,[]),title('ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%������S-FFT�㷨����ȫϢ��
zi=0.20;                         %ȫϢͼ���۲���ľ���,��λ:��
Li=r*lamda*zi/Lo                 %��������ĳߴ�,��λ:��
x=linspace(-Li/2,Li/2,c);y=linspace(-Li/2,Li/2,r);
[x,y]=meshgrid(x,y);
F0=exp(j*k*zi)/(j*lamda*zi)*exp(j*k/2/zi*(x.^2+y.^2));
F=exp(j*k/2/zi*(xo.^2+yo.^2));   %��T-FFT�㷨�õ���ȫϢͼ�ߴ�������һ��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% �ȼ��㲻�ı����λ�õ����
% ȡ����������Ϊ��ֱ����ƽ�й�C=1
holo1=Lo/r*Lo/c*fftshift(fft2(IH.*F.*1));holo1=holo1.*F0;
Ii1=holo1.*conj(holo1);
figure,imshow(Ii1,[0,max(max(Ii1))./1]),colormap(pink),title('������Ϊ��ֱ����ƽ�й�')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% �ټ��㽫�������ƶ����۲�������
% ȡ����������Ϊ�ο���Ĺ����C=R*
holo2=Lo/r*Lo/c*fftshift(fft2(IH.*F.*conj(R)));holo2=holo2.*F0;
Ii2=holo2.*conj(holo2);
figure,imshow(Ii2,[0,max(max(Ii2))./1]),colormap(pink),title('������Ϊ�ο���Ĺ����')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% �����㽫ԭʼ���ƶ����۲�������
% ȡ����������Ϊ�ο���C=R
holo3=Lo/r*Lo/c*fftshift(fft2(IH.*F.*R));holo3=holo3.*F0;
Ii3=holo3.*conj(holo3);
figure,imshow(Ii3,[0,max(max(Ii3))./1]),colormap(pink),title('������Ϊ�ο���')