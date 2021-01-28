Uo=imread('guang.bmp');          %������Ϊ���ͼ��
Uo=double(Uo(:,:,1));            %ȡ��һ�㣬��תΪ˫����
figure(1),imshow(Uo,[]),title('ԭʼ��')
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
O=F0.*fftshift(ifft2(Fuf));      %��ȫϢ��¼���ϵĹⳡ�ֲ�
I=O.*conj(O);                    %ȫϢ��¼���ϵĹ�ǿ�ֲ�
figure(2),imshow(I,[]),colormap(pink),title('����ͼ')
%�������ο���
alpha=pi/2.00;                   %�ο�����x���ļн�
beita=pi/2.02;                   %�ο�����y���ļн�
R=exp(j*k*(xo*cos(alpha)+yo*cos(beita))); %�ο���
%�������Ρ������ȫϢ��¼���ϵĸ���,�õ�ȫϢͼ
inter=O./max(max(sqrt(I)))+R;    %���ڹ����ȣ���ʹ�Ρ�������
II=inter.*conj(inter);           %����õ�ȫϢͼ
figure(3),imshow(II,[]),title('ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%��ȫϢͼ������
%���ڿ����м���ƽ��ֵ
s1=5                             %�趨�˲����ڵĴ�С(����)
B=ones(s1,s1);                   %�������ھ�ֵ�˲���mark
meanII=filter2(B,II)/s1/s1;      %�þ�ֵ�˲�����ȫϢͼ��(x,y)������ƽ��ֵ
II_meanII=II-meanII;             %ȫϢͼ��ƽ��ֵ���,ֻ���¸�����Ľ���ֵ
figure(4),subplot(4,1,1),plot(II(:,257)),title('ȫϢͼ') %����ȫϢͼ������
subplot(4,1,2),plot(meanII(:,257)),title('����ƽ��') %����ȫϢͼƽ��ֵ������
subplot(4,1,4), plot(I(:,257)),title('�����ǿ') %���������ǿ������
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%����Ƶ��������ͨ�˲�
s2=25                             %�趨��ͨ�˲����Ĵ��ڴ�С(����)
H=ones(r,c);                      %Ԥ���ͨ�˲���
H(round(r/2)+1-s2:round(r/2)+s2,round(c/2)+1-s2:round(c/2)+s2)=0;%�����ͨ�˲���
IIFF=fftshift(fft2(II));          %����ȫϢͼ��Ƶ��
HFF=H.*IIFF;                      %�˲�
figure(5),imshow(abs(IIFF),[0,100])%��ʾȫϢͼ��Ƶ��
figure(6),imshow(H,[])            %��ʾ�����ͨ�˲���
IIyp=ifft2(HFF);                  %�����˲����ȫϢͼ
figure(4),subplot(4,1,3),plot(abs(IIyp(:,257))),title('Ƶ���˲�') %����ȫϢͼ������
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%������S-FFT�㷨����ȫϢ��
zi=0.20;                           %ȫϢͼ���۲���ľ���,��λ:��
Li=r*lamda*zi/Lo                   %��������ĳߴ�,��λ:��
x=linspace(-Li/2,Li/2,c);y=linspace(-Li/2,Li/2,r);
[x,y]=meshgrid(x,y);
F0=exp(j*k*zi)/(j*lamda*zi)*exp(j*k/2/zi*(x.^2+y.^2));
F=exp(j*k/2/zi*(xo.^2+yo.^2));     %��T-FFT�㷨�õ���ȫϢͼ�ߴ�������һ��
% �ȼ���δ�����������
% ȡ���������ⴹֱ����C=1
holo1=Lo/r*Lo/c*fftshift(fft2(II.*F*1));holo1=holo1.*F0;
Ii1=holo1.*conj(holo1);
figure,imshow(Ii1,[0,max(max(Ii1))./1]),colormap(pink),title('δ�����������')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% �ټ��������ƽ��ֵ������������
holo2=Lo/r*Lo/c*fftshift(fft2(II_meanII.*F*1));holo2=holo2.*F0;
Ii2=holo2.*conj(holo2);
figure,imshow(Ii2,[0,max(max(Ii2))./1]),colormap(pink),title('����ƽ��������')
% ������Ƶ���˲����������
holo3=Lo/r*Lo/c*fft2(IIyp.*F*1);holo3=holo3.*F0;
Ii3=holo3.*conj(holo3);
figure,imshow(Ii3,[0,max(max(Ii3))./1]),colormap(pink),title('Ƶ���˲�������')