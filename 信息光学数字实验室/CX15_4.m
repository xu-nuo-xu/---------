I1=imread('b1.bmp');I1=double(I1(:,:,1)); %�����һ������ȫϢͼ
I2=imread('b4.bmp');I2=double(I2(:,:,1)); %����ڶ�������ȫϢͼ
IH=I1+I2;                                 %�ϳ�˫�ع�����ȫϢͼ
meanIH=filter2(ones(7,7),IH,'same')./49;  %����˫�ع�ȫϢͼ��ƽ��ֵ
meanI1=filter2(ones(7,7),I1,'same')./49;  %�����һ��ȫϢͼ��ƽ��ֵ
meanI2=filter2(ones(7,7),I2,'same')./49;  %����ڶ���ȫϢͼ��ƽ��ֵ
IH=IH-meanIH;                             %��ȫϢͼƽ��ֵ�������㼶
I1=I1-meanI1;                             %��ȫϢͼƽ��ֵ�������㼶
I2=I2-meanI2;                             %��ȫϢͼƽ��ֵ�������㼶
figure,imshow(IH,[])
[c,r]=size(IH);
lamda=6328*10^(-10);k=2*pi/lamda;         %��ֵ����������
Lox=r*3.2*10^(-6);Loy=c*3.2*10^(-6);      %����ȫϢͼ�ĳߴ�,��λ:��
%���������⴫�ݵ��۲���������������
xo=linspace(-Lox/2,Lox/2,r);yo=linspace(-Loy/2,Loy/2,c);%ȫϢͼ������
[xo,yo]=meshgrid(xo,yo);                  %ȫϢͼ����������
%��������ƽ��ο��⣬������������ͼ������
alpha=pi/2.045;                           %��x��ļн�
beita=pi/1.9655;                          %��y��ļн�
R=exp(j.*k*(xo*cos(alpha)+yo*cos(beita))); %����ƽ��ο���
zo=0.120;                                 %�ﵽȫϢ��ľ���,��λ:��
M=1/3+eps                                 %��ֵ������ķŴ���
%����ʹ�����ŵ�����ο���
zp=M.*zo/(M-1)                            %��������������İ뾶
RF=exp(j*k*zp).*exp(j*k.*(xo.^2+yo.^2)/2/zp); %���������Ⲩ
zi=M.*zo                                  %�µĳ������
F0=exp(j*k*zi)/(j*lamda*zo);
F1=exp(j*k/2/zi.*(xo.^2+yo.^2));
fF1=fft2(F1);
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%�ȼ���˫�ع�ȫϢͼ��������
fa2=fft2(IH.*conj(R).*RF);               %��ȫϢͼ�ϳ�R*,��������ⴹֱ����
Fuf2=fa2.*fF1; 
Ui=F0.*fftshift(ifft2(Fuf2));            %�ڹ۲����ϵĹⳡ�ֲ�
Ii=Ui.*conj(Ui);                         %�۲����ϵĹ�ǿ�ֲ�
Ii=medfilt2(Ii,[5,5]);                   %��ֵ�˲���������
figure,imshow(Ii,[0,max(max(Ii))/50]),colormap(pink),title('˫�ع�ȫϢ������')
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%�����һ��ȫϢͼ��������
fa2=fft2(I1.*conj(R).*RF);               %��ȫϢͼ�ϳ�R*,��������ⴹֱ����
Fuf2=fa2.*fF1; 
Ui1=F0.*fftshift(ifft2(Fuf2));           %�ڹ۲����ϵĹⳡ�ֲ�
Ii1=Ui1.*conj(Ui1);                      %�۲����ϵĹ�ǿ�ֲ�
Ii1=medfilt2(Ii1,[5,5]);                 %��ֵ�˲���������
figure,imshow(Ii1,[0,max(max(Ii1))/50]),colormap(pink),title('��һ��ȫϢͼ������')
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%����ڶ���ȫϢͼ�������� 
fa2=fft2(I2.*conj(R).*RF);              %��ȫϢͼ�ϳ�R*,��������ⴹֱ����
Fuf2=fa2.*fF1; 
Ui2=F0.*fftshift(ifft2(Fuf2));          %�ڹ۲����ϵĹⳡ�ֲ�
Ii2=Ui2.*conj(Ui2);                     %�۲����ϵĹ�ǿ�ֲ�
Ii2=medfilt2(Ii2,[5,5]);                %��ֵ�˲���������
figure,imshow(Ii2,[0,max(max(Ii2))/50]),colormap(pink),title('�ڶ���ȫϢͼ������')
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%��������ȫϢͼ���ֹⳡ��ĸ���
U=Ui2./Ui1;
I=cos(angle(U));                       %�����ֹⳡ�໥����
I=medfilt2(I,[5,5]);                   %��ֵ�˲���������
figure,imshow(I,[]),colormap(gray),title('��ȫϢ���ֹⳡ�γɵĸ�������')