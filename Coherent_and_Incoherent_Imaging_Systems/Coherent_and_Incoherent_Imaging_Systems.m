Uo=imread('./pics/�ֱ��ʰ�_2.bmp');
Uo=double(Uo(:,:,1));
[c,r]=size(Uo);
lamda=6328e-10;
k=2*pi/lamda;
D=0.01;
f=0.4;
figure,imshow(Uo,[]);
L0=0.005;
d0=1.2;
di=d0*f/(d0-f);
cf=D/2/lamda/di;    %��ֹƵ�� 
Li=L0*di/d0;
kethi=linspace(-1/2/Li,1/2/Li,r).*r;
nenta=linspace(-1/2/Li,1/2/Li,c).*c;
[kethi,nenta]=meshgrid(kethi,nenta);
H=zeros(c,r);
for n=1:c
    for m=1:r
        if kethi(n,m)^2+nenta(n,m)^2<=cf^2
            H(n,m)=1;
        end
    end
end
figure,surfl(H),shading interp,colormap(gray);title('��ɴ��ݺ���CTF')
Gg=fftshift(fft2(Uo));
Gic=Gg.*H;
Uic=ifft2(Gic);
Iic=Uic.*conj(Uic);
figure,imshow(Iic,[]),title('�����������Ĺ�ǿ�ֲ�')

%����������ɳ���
h=fftshift(fft2(H));
HH=abs(fftshift(fft2(h.*conj(h))));
OTF1=HH./max(max(HH));
figure,surfl(OTF1),shading interp,colormap(gray);title('��ѧ���ݺ���')

[phai,rou]=cart2pol(kethi,nenta);
OTF2=zeros(c,r);
for n=1:c
    for m=1:r
        if rou(n,m)<=2*cf
            OTF2(n,m)=2*(acos(rou(n,m)/2/cf)-rou(n,m)/2/cf.*sqrt(1-(rou(n,m)/2/cf).^2))/pi;
        end
    end
end
figure,surfl(OTF2),shading interp,colormap(gray);title('�㷨2��ѧ���ݺ���')

Gii1=Gg/(max(max(abs(Gg)))).*OTF1;
Iii1=abs(ifft2(Gii1));
figure,imshow(Iii1,[]),title('OTF1�õ��������������'),colormap(gray)
