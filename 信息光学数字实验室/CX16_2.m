r=512,c=r;                       %���������ϵĳ�����
Uo=zeros(r,c);                   %Ԥ����ⳡ
Uo(r/2-r/4+1:r/2+r/4,c/2-c/4+1:c/2+c/4)=2; %������ⳡ���
Uo(r/2-round(r/6)+1:r/2+round(r/6),c/2-round(c/6)+1:c/2+round(c/6))=4; 
Uo(r/2-round(r/12)+1:r/2+round(r/12),c/2-round(c/12)+1:c/2+round(c/12))=6;
Uo(r/2-r/4+1:r/2+r/4,c/2-c/4+1:c/2+c/4)=...
Uo(r/2-r/4+1:r/2+r/4,c/2-c/4+1:c/2+c/4).*exp(j*peaks(256)*2); %����������λ
lamda=6328*10^(-10);k=2*pi/lamda; %��ֵ����������
zo=0.3086;                        %�ﵽȫϢ��¼��ľ���,��λ:��
Lo=5*10^(-3)                      %��ֵ������(��)�ĳߴ�,��λ:��
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
%��T-FFT�㷨���ȫϢͼ��¼���̵ļ���
xo=linspace(-Lo/2,Lo/2,c);yo=linspace(-Lo/2,Lo/2,r);
[xo,yo]=meshgrid(xo,yo);
F0=exp(j*k*zo)/(j*lamda*zo);
F1=exp(j*k/2/zo.*(xo.^2+yo.^2));
fa=fft2(Uo); fF1=fft2(F1);
Fuf=fa.*fF1; 
O=F0.*fftshift(ifft2(Fuf));      %��ȫϢ��¼���ϵĹⳡ�ֲ�
I=O.*conj(O);                    %ȫϢ��¼�������ǿ�ֲ�
figure,imshow(I,[]),colormap(pink),title('����ͼ')
%�������ƽ��ο���
alpha=pi/2.02;beita=pi/2.00;     %�ο�����x�ᡢy���ļн�
R=exp(j*k*(xo*cos(alpha)+yo*cos(beita))); %�ο���
%�������Ρ������ȫϢ��¼���ϵĸ���,�õ�ȫϢͼ
inter=O./mean(sqrt(I(:)))+R;     %���ڹ����ȣ���ʹ�Ρ�������
IH=inter.*conj(inter);           %����õ�ȫϢͼ
figure,imshow(IH,[]),title('ȫϢͼ')
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%����ɿطŴ��ʵķ����ع�������
M=1.8+eps                        %��ֵ�Ŵ���,��eps����M=1�����
zp=M.*zo/(M-1)                   %����������İ뾶
%����ʹ�����ŵ�����ο���
RF=exp(j*k*zp).*exp(j*k.*(xo.^2+yo.^2)/2/zp);  %���������Ⲩ
zi=M.*zo                         %�µĳ������
F0=exp(j*k*zi)/(j*lamda*zo);
F1=exp(j*k/2/zi.*(xo.^2+yo.^2));
fF1=fft2(F1);
fa=fft2(IH.*conj(R).*RF);        %��ȫϢͼ�ϳ�R*,��������ⴹֱ����
Fuf=fa.*fF1; 
Ui=F0.*fftshift(ifft2(Fuf));     %�ڹ۲����ϵĹⳡ�ֲ�
Ii=Ui.*conj(Ui);                 %�۲����ϵĹ�ǿ
figure,imshow(Ii,[]),colormap(gray),title('���ŵ�-1���ع���')
ph=angle(Ui);                    %�����ؽ���λ
figure,imshow(ph,[]),title('�ؽ���λ')
figure,plot(ph(:,257))           %������λ����