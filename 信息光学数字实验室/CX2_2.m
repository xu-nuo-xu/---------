lamda=6328*(10^(-10));         %����
k=2*pi/lamda;                  %����
alpha=pi/2.005;                %����X��ļн�
beita=pi/2.005;                %����Y��ļн�
L=0.004                        %�۲���ĳߴ磬��λ����
x=linspace(-L/2,L/2,512);y=x;
[x,y]=meshgrid(x,y);
U=exp(j.*k.*(x.*cos(alpha)+y.*cos(beita))); %��������ƽ�йⳡ
ph=k.*(x.*cos(alpha)+y.*cos(beita)); %ֱ�Ӽ���ʵ����λ
figure,surfl(ph),shading interp,colormap(gray)
phyp=angle(U);                %����ⳡ����λ��������λ��
figure,imshow(phyp,[])
figure,plot(ph(257,:) , '--')
hold on,plot(phyp(257,:),'r')
diff=U+1;                     %�۲���������ƽ�й��봹ֱ����ƽ�й�ĸ���
I=diff.*conj(diff);           %�۲����ϵĹ�ǿ
figure,imshow(I,[])
UFuv=fftshift(fft2(U));       %����ⳡ��Ƶ��
figure,imshow(abs(UFuv),[0,max(max(abs(UFuv)))./50]) %�ⳡ��Ƶ��
IFuv=fftshift(fft2(I));       %����������Ƶ�Ƶ��
figure,imshow(abs(IFuv),[0,max(max(abs(IFuv)))./50]) %�������Ƶ�Ƶ��