o=imread('�ֱ��ʰ�_1.bmp');       %������Ϊ���ͼ��
o=double(o(:,:,1));               %ȡ��һ�㣬��תΪ˫����
figure,imshow(o,[]),title('ԭʼ��')
[r,c]=size(o);
lamda=6328*10^(-10);k=2*pi/lamda; %��ֵ����������
zo=0.3086;                        %�ﵽȫϢ��¼��ľ���,��λ:��
Lo=5*10^(-3)                      %��ֵ������(��)�ĳߴ�,��λ:��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��T-FFT�㷨���ȫϢͼ��¼���̵ļ���
xo=linspace(-Lo/2,Lo/2,c);yo=linspace(-Lo/2,Lo/2,r);
[xo,yo]=meshgrid(xo,yo);          %�����������������
F0=exp(j*k*zo)/(j*lamda*zo);
F1=exp(j*k/2/zo.*(xo.^2+yo.^2));
fa=fft2(o); fF1=fft2(F1);
Fuf=fa.*fF1; 
OH=F0.*fftshift(ifft2(Fuf));      %��ȫϢ��¼���ϵĹⳡ�ֲ�
I=OH.*conj(OH);                   %ȫϢ��¼���ϵĹ�ǿ�ֲ�
figure,imshow(I,[]),colormap(pink),title('����ͼ')
%�������ο���
zr=zo                             %��ɢ���沨(�ο��⣩�İ뾶
xr=0.004;yr=-0.004;               %��ɢ���沨(�ο��⣩������λ��(��)
R=exp(j.*k.*zr).*exp(j.*k.*(((xo-xr).^2+(yo-yr).^2))/2./zr);  %�ο�����Ⲩ
%�������Ρ������ȫϢ��¼���ϵĸ���,�õ�ȫϢͼ
inter=OH./max(max(sqrt(I)))+R;    %���ڹ����ȣ���ʹ�Ρ�������
II=inter.*conj(inter);            %����õ�ȫϢͼ
figure,imshow(II,[]),title('ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%�����������
holo=fftshift(fft2(II)); 
Ii=holo.*conj(holo);
figure,imshow(Ii,[0,max(max(Ii))./20000]),colormap(pink),title('������')