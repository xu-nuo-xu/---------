IH=imread('ho.bmp');IH=double(IH(:,:,2));%��������ȫϢͼ
meanIH=filter2(ones(7,7),IH,'same')./49; %����ȫϢͼƽ��ֵ
IH=IH-meanIH;                            %��ȫϢͼƽ��ֵ�������㼶
figure,imshow(IH,[])
[c,r]=size(IH);
lamda=5328*10^(-10);k=2*pi/lamda;        %��ֵ����������
Lox=r*3.2*10^(-6);Loy=c*3.2*10^(-6);     %����ȫϢͼ�ĳߴ�,��λ:��
%������⴫�ݵ��۲������������
xo=linspace(-Lox/2,Lox/2,r);yo=linspace(-Loy/2,Loy/2,c);%ȫϢͼ������
[xo,yo]=meshgrid(xo,yo);                %ȫϢͼ����������
%��������ƽ��ο���
alpha=pi/1.962;                         %��x��ļн�
beita=pi/1.9855;                        %��y��ļн�
R=exp(j.*k*(xo*cos(alpha)+yo*cos(beita))); %����ƽ��ο���
zo=1.7000;                              %�ﵽȫϢ��ľ���,��λ:��
M=1/14+eps                              %��ֵ������ķŴ���
%����ʹ�����ŵ�����ο���
zp=M.*zo/(M-1)                          %��������������İ뾶
RF=exp(j*k*zp).*exp(j*k.*(xo.^2+yo.^2)/2/zp); %���������Ⲩ
zi=M.*zo                                %�µĳ������
F0=exp(j*k*zi)/(j*lamda*zo);
F1=exp(j*k/2/zi.*(xo.^2+yo.^2));
fF1=fft2(F1);
fa2=fft2(IH.*conj(R).*RF);              %��ȫϢͼ�ϳ�R*,��������ⴹֱ����
Fuf2=fa2.*fF1; 
Ui=F0.*fftshift(ifft2(Fuf2));           %�ڹ۲����ϵĹⳡ�ֲ�
Ii=Ui.*conj(Ui);                        %�۲����ϵĹ�ǿ
figure,imshow(Ii,[0,max(max(Ii))/1000]),colormap(gray),title('���ŵ�-1���ع���')