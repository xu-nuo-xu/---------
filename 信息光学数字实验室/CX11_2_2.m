I=imread('ho.bmp');                   %��������ȫϢͼ       
II=zeros(2048,2048);                  %Ԥ��ȫϢͼ�����㣩
II(257:1792,:)=double(I(:,:,2));      %����ȡ����ȫϢͼ�ĵڶ���(��ɫ)�������ȫϢͼ��
figure,imshow(II,[])
FF=abs(fftshift(fft2(II)));           %����ȫϢͼ��Ƶ��
figure,imshow(FF,[0,max(max(FF))/200])%��ʾ����ȫϢͼ��Ƶ��
lamda=5328*10^(-10);k=2*pi/lamda;     %��ֵ����������
[r,c]=size(II);                       %����ȫϢͼ�Ĵ�С(����)
Lox=c*3.2*10^(-6)                     %��ֵȫϢͼ�ĳߴ�(����),��λ:��
Loy=r*3.2*10^(-6)                     %��ֵȫϢͼ�ĳߴ�(����),��λ:��
xo=linspace(-Lox/2,Lox/2,c);          %����ȫϢͼ��x����
yo=linspace(-Loy/2,Loy/2,r);          %����ȫϢͼ��y����
[xo,yo]=meshgrid(xo,yo);              %����ȫϢͼ����������
%������S-FFT�㷨�ع�������
zi=1.70;                              %ȫϢ��¼�浽����ľ���,��λ:��
Lix=c*lamda*zi/Lox                    %��������ĳߴ�(x����),��λ:��
Liy=r*lamda*zi/Loy                    %��������ĳߴ�(y����),��λ:��
x=linspace(-Lix/2,Lix/2,c);y=linspace(-Liy/2,Liy/2,r);
[x,y]=meshgrid(x,y);
F0=exp(j*k*zi)/(j*lamda*zi)*exp(j*k/2/zi*(x.^2+y.^2));
F=exp(j*k/2/zi*(xo.^2+yo.^2)); 
% ȡ���������ⴹֱ����C=1
holo=Lox/c*Loy/r*fftshift(fft2(II.*F*1)); holo=holo.*F0;
Ii=holo.*conj(holo);
figure,imshow(Ii,[0,max(max(Ii))./1000]),colormap(pink),title('S-FFT������')