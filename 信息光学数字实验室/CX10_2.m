Uo=imread('1.bmp');                     %��������ȫϢͼ
Uo =double(Uo (:,:,1));                 %��ȡ����ȫϢͼ�ĵ�һ��(��ɫ)
figure,imshow(Uo,[])
lamda=6328*10^(-10);k=2*pi/lamda;       %��ֵ����������
[r,c]=size(Uo);                         %����ȫϢͼ�Ĵ�С(����)
Lox=c*4.65*10^(-6)                      %��ֵȫϢͼ�ĳߴ�(����),��λ:��
Loy=r*4.65*10^(-6)                      %��ֵȫϢͼ�ĳߴ�(����),��λ:��
xo=linspace(-Lox/2,Lox/2,c);            %����ȫϢͼ��x����
yo=linspace(-Loy/2,Loy/2,r);            %����ȫϢͼ��y����
[xo,yo]=meshgrid(xo,yo);                %����ȫϢͼ����������
zo=0.052;                               %������(��)��ȫϢ��¼��ľ���,��λ:��
%������T-FFT�㷨�ع�������
F0=exp(j*k*zo)/(j*lamda*zo);
F1=exp(j*k/2/zo.*(xo.^2+yo.^2));
fF1=fft2(F1);
fa1=fft2(Uo);
Fuf1=fa1.*fF1; 
Ui=F0.*fftshift(ifft2(Fuf1));          %�ڹ۲�ƽ���ϵ��ع��ⳡ
Ii=Ui.*conj(Ui);                       %������Ĺ�ǿ
figure,imshow(Ii,[0,max(max(Ii))/1]),colormap(gray),title('-1����')