a=imread('o1.bmp');a=double(a(:,:,1));  %��ȡȫϢͼ
b=imread('o0.bmp');b=double(b(:,:,1));  %��ȡ�ο���ǿ
a=a(:,18:779); b=b(:,18:779);           %ȥ��ͼ���Ե
figure,imshow(a,[]),figure,imshow(b,[])
IH=a-b;                                 %�õ�ȫϢͼ
figure,imshow(IH,[])
[c,r]=size(IH);
zr=0.1096;                              %�ο��⵽CCD�ľ���
zo=0.0355;                              %ϸ����CCD�ľ���
Lox=r*10*10^(-6);Loy=c*10*10^(-6);      %ȫϢͼ�ĳߴ�,��λ:��
lamda=6328*10^(-10); k=2*pi/lamda;      %�����Ͳ���
xo=linspace(-Lox/2,Lox/2,r);yo=linspace(-Loy/2,Loy/2,c);%ȫϢͼ������
[xo,yo]=meshgrid(xo,yo);                %ȫϢͼ����������
%������������ο���
xr=0.0001;                              %�ο����Դ��x����
yr=0.0007;                              %�ο����Դ��y����
R=exp(j*k*zr).*exp(j*k.*((xo-xr).^2+(yo-yr).^2)/2/zr); %����ο��Ⲩ
M=5+eps                                 %��ֵ�Ŵ���
zp=M.*zo/(M-1)                          %����������İ뾶
RF=exp(j*k*zp).*exp(j*k.*(xo.^2+yo.^2)/2/zp); %���������Ⲩ
zi=M.*zo                                %�µĳ������
F0=exp(j*k*zi)/(j*lamda*zo);
F1=exp(j*k/2/zi.*(xo.^2+yo.^2));
fF1=fft2(F1);
fa2=fft2(IH.*conj(R).*RF); %��ȫϢͼ�ϳ�R*,��������ⴹֱ����
Fuf2=fa2.*fF1;
Ui=F0.*fftshift(ifft2(Fuf2));           %�ڹ۲����ϵĹⳡ�ֲ�
Ii=Ui.*conj(Ui);                        %�۲����ϵĹ�ǿ
figure,imshow(Ii,[]),colormap(pink),title('���ŵ�-1���ع���')