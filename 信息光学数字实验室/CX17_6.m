Uo=imread('guang.bmp');           %������Ϊ���ͼ��
Uo=double(Uo(:,:,1));             %ȡ��һ�㣬��תΪ˫����
figure,imshow(Uo,[]),title('ԭʼ��')
[r,c]=size(Uo);
lamda=6328*10^(-10);k=2*pi/lamda; %��ֵ����������
zo=0.3086;                        %�ﵽȫϢ��¼��ľ���,��λ:��
Lo=5*10^(-3)                      %��ֵ������(��)�ĳߴ�,��λ:��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��T-FFT�㷨������䣨��ⳡ�ļ���
xo=linspace(-Lo/2,Lo/2,c);yo=linspace(-Lo/2,Lo/2,r);
[xo,yo]=meshgrid(xo,yo);
F0=exp(j*k*zo)/(j*lamda*zo);
F1=exp(j*k/2/zo.*(xo.^2+yo.^2));
fa=fft2(Uo); fF1=fft2(F1);
Fuf=fa.*fF1; 
O=F0.*fftshift(ifft2(Fuf));       %��ȫϢ��¼���ϵĹⳡ�ֲ�
alpha=pi/2.025;                   %�ο������б�Ƕ�
beita=0;
R=exp(j*k*(xo*cos(alpha)));       %�ο��ⳡ
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%���Ƽ������ȫϢͼ
U=O./max(abs(O(:)));
inter=(U+R).*conj(U+R);           %�����ͼ������ȫϢͼ
figure,imshow(inter,[]),colormap(gray),title('������ȫϢͼ')
qq=asin(abs(U))./pi;
out=inter-cos(qq.*pi);
figure,plot(inter(257, 1:258))
hold on,plot(qq(257, 1:258),'k')
hold on,plot(out(257,1:258),'r')
CGH=out;
CGH(CGH>=0)=1;                    %��ֵ���������ȫϢͼ
CGH(CGH~=1)=0;
figure,imshow(CGH,[]),colormap(pink),title('��ֵ��ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = =
%��S-FFT�㷨���ȫϢͼ����ȫϢ��
zi=0.3086;                        %ȫϢͼ���۲���ľ���,��λ:��
Li=r*lamda*zi/Lo                  %��������ĳߴ�,��λ:��
x=linspace(-Li/2,Li/2,c);y=linspace(-Li/2,Li/2,r);
[x,y]=meshgrid(x,y);
F0=exp(j*k*zi)/(j*lamda*zi)*exp(j*k/2/zi*(x.^2+y.^2));
F=exp(j*k/2/zi*(xo.^2+yo.^2));    %��T-FFT�㷨�õ���ȫϢͼ�ߴ�������һ��
holo1=Lo/r*Lo/c*fftshift(fft2(inter.*F*1)); holo1=holo1.*F0; % ���������ⴹֱ����
Ii1=holo1.*conj(holo1);           %����������Ĺ�ǿ
figure,imshow(Ii1,[0,max(max(Ii1))./2]),title('������CGH������')
holo2=Lo/r*Lo/c*fftshift(fft2(CGH.*F*1)); holo2=holo2.*F0; % ���������ⴹֱ����
Ii2=holo2.*conj(holo2);          %����������Ĺ�ǿ
figure,imshow(Ii2,[0,max(max(Ii2))./10]),title('��ֵ��CGH������')