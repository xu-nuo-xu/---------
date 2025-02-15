r=512,c=r;                            %给出衍射面上的抽样数
a=zeros(r,c);                         %预设衍射面
a(r/2-r/4:r/2+r/4,c/2-c/4:c/2+c/4)=1; %生成衍射孔
lamda=6328*10^(-10);k=2*pi/lamda;     %赋值波长、波数
L0=5*10^(-3);                         %赋值衍射面尺寸，单位:米
d=0.1;                                %赋值观察屏到衍射面的距离,单位:米 
x0=linspace(-L0/2,L0/2,c);            %生成衍射面x轴坐标
y0=linspace(-L0/2,L0/2,r);            %生成衍射面y轴坐标
kethi=linspace(-1./2./L0,1./2./L0,c).*c; %给出频域坐标
nenta=linspace(-1./2./L0,1./2./L0,r).*r;
[kethi,nenta]=meshgrid(kethi,nenta);
H=exp(j*k*d.*(1-lamda.*lamda.*(kethi.*kethi+nenta.*nenta)./2)); %传递函数H
fa=fftshift(fft2(a));                 %衍射面上光场的傅里叶变换
Fuf=fa.*H;                            %光场的频谱与传递函数相乘
U=ifft2(Fuf);                         %在观察屏上的光场分布
I=U.*conj(U);                         %在观察屏上的光强分布
figure,imshow(I,[0,max(max(I))]),colormap(gray)