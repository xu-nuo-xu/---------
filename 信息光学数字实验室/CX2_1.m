lamda=6328e-10;                      %��������λ����
k=2*pi/lamda;                        %����
x0=0.001                             %���Դ��x���꣬��λ����
y0=0.001;                            %���Դ��y���꣬��λ����
z=0.3                                %�۲��浽���Դ�Ĵ�ֱ���룬��λ����
L=0.005                              %�۲���ĳߴ磬��λ����
x=linspace(-L/2,L/2,512);y=x;        %����x�����y����
[x,y]=meshgrid(x,y);                 %������ά��������
U1=exp(j*k*z).*exp(j*k.*((x-x0).^2+(y-y0).^2)/2/z);  %��ɢ����Ⲩ
ph1=k.*((x-x0).^2+(y-y0).^2)/2/z;    %��ɢ���沨��ʵ����λ
figure,surfl(ph1),shading interp,colormap(gray) 
phyp1=angle(U1);                     %��ɢ���沨�İ�����λ
figure,imshow(phyp1,[])
U2=exp(-j*k*z).*exp(-j*k.*((x-x0).^2+(y-y0).^2)/2/z); %�������Ⲩ
ph2=-k.*((x-x0).^2+(y-y0).^2)/2/z;   %������沨��ʵ����λ
figure,surfl(ph2),shading interp,colormap(gray) 
phyp2=angle(U2);                     %������沨�İ�����λ
figure,imshow(phyp2,[]) 
figure, plot(ph2(257,:),'--')        %ʵ����λ������
hold on                              %���ֵ�ǰͼ��
plot(phyp2(257,:),'r')               %������λ������
diff1=U1+1;                          %�۲����Ϸ�ɢ������봹ֱ����ƽ�й�ĸ���
I1=diff1.*conj(diff1);               %�۲����ϵĹ�ǿ
figure,imshow(I1,[0,max(max(I1))])
diff2=U2+1;                          %�۲����ϻ��������봹ֱ����ƽ�й�ĸ���
I2=diff2.*conj(diff2);               %�۲����ϵĹ�ǿ
figure,imshow(I2,[0,max(max(I2))])