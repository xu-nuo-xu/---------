r=512,c=r;                            %�����������ϵĳ�����
a=zeros(r,c);                         %Ԥ��������
a(r/2-r/4:r/2+r/4,c/2-c/4:c/2+c/4)=1; %���������
lamda=6328*10^(-10);k=2*pi/lamda;     %��ֵ����������
L0=5*10^(-3);                         %��ֵ������ߴ磬��λ:��
d=0.1;                                %��ֵ�۲�����������ľ���,��λ:�� 
x0=linspace(-L0/2,L0/2,c);            %����������x������
y0=linspace(-L0/2,L0/2,r);            %����������y������
[x0,y0]=meshgrid(x0,y0);              %����������Ķ�ά��������
%���濪ʼ��ʽ��4-13�������������
F0=exp(j*k*d)/(j*lamda*d);            %��ֵexp(ikd)/(i��d)
F1=exp(j*k/2/d*(x0.^2+y0.^2));        %��ֵexp[ik(x02+y02)/2d]
fa=fft2(a);                           %��ɹⳡU0(x0,y0)�ĸ���Ҷ�任
fF1=fft2(F1);                         %���exp[ik(x02+y02)/2d]�ĸ���Ҷ�任
Fuf=fa.*fF1;                          %���Ƶ�����
U=F0.*fftshift(ifft2(Fuf));           %�õ��۲����ϵĹⳡ�ֲ�U(x,y)
I=U.*conj(U);                         %����۲����ϵĹ�ǿ�ֲ�
figure, imshow(I,[0,max(max(I))]),colormap(gray)
figure,imshow(max(max(I))-I,[]),colormap(gray)