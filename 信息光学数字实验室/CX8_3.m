x=linspace(0,0.0001*pi,512);y=linspace(0,0.0001*pi,512);
[x,y]=meshgrid(x,y);
b=0.00002; lamda=6328*10^(-10);di=0.02;
tx=cos(2*pi*x./b);
[c,r]=size(tx);
figure,imshow(tx,[])
a=1.5*lamda*di/b
Lo=0.0001*pi;
cutoff_frequency=a/lamda/di;
kethi=linspace(-1./2./Lo,1./2./Lo,r).*r;nenta=linspace(-1./2./Lo,1./2./Lo,c).*c;
[kethi,nenta]=meshgrid(kethi,nenta); 
CTF=zeros(c,r);
for n=1:c
   for m=1:r
      if kethi(n,m).^2+nenta(n,m).^2<= cutoff_frequency.^2;
      CTF(n,m)=1;
      end
   end
end
figure,imshow(CTF,[]);title('��ɴ��ݺ���')
h=fftshift(fft2(CTF));
OTF=abs(fftshift(fft2(h.*conj(h))));
OTF=OTF./max(max(OTF));
figure,surfl(OTF),shading interp,colormap(gray);title('��ѧ���ݺ���')
Gg=fftshift(fft2(tx));                             %�������ʱ���Ƶ��
figure,imshow(abs(Gg),[0,max(max(abs(Gg)))/10])    %��ʾƵ��
figure,plot(abs(Gg(257,:)))                        %Ƶ�׵�����
Gic=Gg.*CTF;
Uic=ifft2(Gic);
Iic=Uic.*conj(Uic);
figure,imshow(Iic,[0,1]),title('�������'),colormap(gray)
Gg=fftshift(fft2(tx.*conj(tx)));  %���������ʱ���Ƶ��(��Ϊ�������ƽ��)
figure,imshow(abs(Gg),[0,max(max(abs(Gg)))/10])    %��ʾƵ��
figure,plot(abs(Gg(257,:)))                        %Ƶ�׵�����
Gii=Gg.*OTF; 
Iii=abs(ifft2(Gii));
figure,imshow(Iii,[0,1]),title('���������'),colormap(gray)
figure, plot(Iii(257,:))
hold on,plot(Iic(257,:),'r')