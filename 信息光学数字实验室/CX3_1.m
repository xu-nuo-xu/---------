r=512,c=r;                             %�����������ϵĳ�����
a=zeros(r,c);                          %Ԥ��������
a(r/2-r/4:r/2+r/4,c/2-c/4:c/2+c/4)=1;  %���������
lamda=6328*10^(-10);k=2*pi/lamda;      %��ֵ����������
L0=5*10^(-3);                          %��ֵ������ߴ磬��λ:��
d=0.1;                                 %��ֵ�۲�����������ľ���,��λ:�� 
x0=linspace(-L0/2,L0/2,c);             %����������x������
y0=linspace(-L0/2,L0/2,r);             %����������y������
[x0,y0]=meshgrid(x0,y0);               %�����������ά��������
L=r*lamda*d/L0,                        %�����۲����ĳߴ�,��λ:��
x=linspace(-L/2,L/2,c);                %���ɹ۲���x������
y=linspace(-L/2,L/2,r);                %���ɹ۲���y������
[x,y]=meshgrid(x,y);                   %���ɹ۲�����ά��������
%���濪ʼ��ʽ��3-4�������������
F0=exp(j*k*d)/(j*lamda*d)*exp(j*k/2/d*(x.^2+y.^2)); % ��ֵexp(ikd)/(i��d)exp[ik(x2+y2) /2d]
F=exp(j*k/2/d*(x0.^2+y0.^2));          %��ֵexp[ik (x02+y02) /2d]
a=a.*F;                                %��ֵU0(x0,y0)exp[ik (x02+y02) /2d]
Ff=fftshift(fft2(a));                  %���U0(x0,y0)exp[ik (x02+y02) /2d]�ĸ���Ҷ�任
Fuf=F0.*Ff;                            %�õ��۲����ϵĹⳡ�ֲ�U (x,y)
I=Fuf.*conj(Fuf);                      %����۲����ϵĹ�ǿ�ֲ�
figure,
subplot(1,2,1),imshow(I,[0,max(max(I))]),colormap(gray)
subplot(1,2,2),imshow(max(max(I))-I,[]),colormap(gray)