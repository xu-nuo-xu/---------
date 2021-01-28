Uo=imread('xuehua.jpg');              %������Ϊ���ͼ��
Uo=double(Uo (:,:,1));                %��ȡ��һ��,ת��Ϊ˫����
figure,imshow(Uo,[])
Uo=exp(j.*Uo/255);                  %���ɴ���λ��ⳡ
[c,r]=size(Uo);                      %��ȡ���������
lamda=6328*10^(-10);k=2*pi/lamda;    %��ֵ����,��λ:��,��ʸ
f=0.004; Lo=0.001                   %��ֵ��΢�ﾵ�Ľ���,����ĳߴ�,��λ:��
D=0.00005                         %��ֵ�˲�Ƭֱ��,��λ:��
%= = = = = = = = = = = = = = = = = = = = = = = = = = =
%���������⴫�ݵ�͸��ǰ�������������(S-FFT)
xo=linspace(-Lo/2,Lo/2,r);yo=linspace(-Lo/2,Lo/2,c); %��ֵ���������
[xo,yo]=meshgrid(xo,yo);             %�����������������
do=0.0041;                         %���浽͸���ľ���do,��λ:��
L=r*lamda*do/Lo                   %�����������͸��ǰ�����ϵĳߴ�,��λ:��
xl=linspace(-L/2,L/2,r);yl=linspace(-L/2,L/2,c); %��ֵ͸��ǰ���������
[xl,yl]=meshgrid(xl,yl);               %����͸��ǰ�������������
F0=exp(j*k*do)/(j*lamda*do)*exp(j*k/2/do*(xl.^2+yl.^2));
F=exp(j*k/2/do*(xo.^2+yo.^2));
FU=(Lo*Lo/r/r).*fftshift(fft2(Uo.*F));
U1=F0.*FU;                        %͸��ǰ�����ϵĹⳡ������ֲ�
I1=U1.*conj(U1);                    %͸��ǰ�����ϵĹ�ǿ�ֲ�
figure,imshow(I1,[]), colormap(pink),title('͸���ϵĹ�ǿ�ֲ�')
%= = = = = = = = = = = = = = = = = = = = = = = = = = =
%�������ͨ��͸����Ĺⳡ
U1yp=U1.*exp(-j*k.*(xl.^2+yl.^2)/2/f);  %����ͨ��͸����Ĺⳡ
%= = = = = = = = = = = = = = = = = = = = = = = = = = =
%�������ͨ��͸����Ĺⳡ���ｹ��Ĺ���(S-FFT)
dlf=f,
Lyp=r*lamda*dlf/L,                  %������������ֳߴ�,��λ:��
xf=linspace(-Lyp/2,Lyp/2,r);yf=linspace(-Lyp/2,Lyp/2,c); %�������������
[xf,yf]=meshgrid(xf,yf);               %���ɽ������������
F0=exp(j*k*dlf)/(j*lamda*dlf)*exp(j*k/2/dlf*(xf.^2+yf.^2));
F=exp(j*k/2/dlf*(xl.^2+yl.^2));
Uf=(L*L/r/r).*fft2(U1yp.*F);Uf=Uf.*F0; %�����ϵĹⳡ�ֲ�
I2=Uf.*conj(Uf);                    %�����ϵĹ�ǿ�ֲ�
figure,imshow(log(I2),[]), colormap(pink),title('�����ϵĹ�ǿ�ֲ�')
%= = = = = = = = = = = = = = = = = = = = = = = = = = =
%�����˲���
DD=round(D*r/Lyp);                 %��ֵ�˲���ֱ��,��λ:����
H=zeros(c,r);                        %�����˲���
for n=1:c
   for m=1:r
      if (n-c/2-1).^2+(m-r/2-1).^2<=(DD/2).^2;
      H(n,m)=1;
      end
   end
end
figure,imshow(H,[]);title('�����ͨ�˲���')
H_p=exp(j*pi/2).*H;                  %������˲���
H_n=exp(j*3*pi/2).*H;                %������˲���
%= = = = = = = = = = = = = = = = = = = = = = = = = = =
%���㾭����+������-����ĺ��洦�Ĺⳡ
Uf_p=H_p.*Uf+(1-H).*Uf;              %����ĺ��洦�Ĺⳡ
Uf_n=H_n.*Uf+(1-H).*Uf;              %����ĺ��洦�Ĺⳡ
%= = = = = = = = = = = = = = = = = = = = = = = = = = =
%�������ͨ�������Ĺⳡ����۲���Ĺ���(S-FFT)
dfi=do*f/(do-f)-f;
Li=r*lamda*dfi/Lyp,                   %��������ĳߴ�,��λ:��
xi=linspace(-Li/2,Li/2,r);yi=linspace(-Li/2,Li/2,c); %�������������
[xi,yi]=meshgrid(xi,yi);                 %�����������������
F0=exp(j*k*dfi)/(j*lamda*dfi)*exp(j*k/2/dfi*(xi.^2+yi.^2));
F=exp(j*k/2/dfi*(xf.^2+yf.^2));
% ����������
Ui=(Lyp*Lyp/r/r).*fft2(Uf.*F);Ui=Ui.*F0;  
Ii=Ui.*conj(Ui);                       %�����ʱ������Ĺ�ǿ�ֲ�
figure,imshow(Ii,[]),title('�����ʱ��������'),colormap(gray)
Ui_p=(Lyp*Lyp/r/r).*fft2(Uf_p.*F);Ui_p=Ui_p.*F0;  
Ii_p=Ui_p.*conj(Ui_p);                 %�����ʱ������Ĺ�ǿ�ֲ�
figure,imshow(Ii_p,[]),title('�����ʱ��������'),colormap(gray)
Ui_n=(Lyp*Lyp/r/r).*fft2(Uf_n.*F);Ui_n=Ui_n.*F0;  
Ii_n=Ui_n.*conj(Ui_n);                 %�����ʱ������Ĺ�ǿ�ֲ�
figure,imshow(Ii_n,[]),title('�����ʱ��������'),colormap(gray)
%= = = = = = = = = = = = = = = = = = = = = = = = = = =
%����������߱Ƚ����Ч��
Ii_p_yp=flipud(fliplr(Ii_p));             %������������ת
Ii_n_yp=flipud(fliplr(Ii_n));             %������������ת
figure,subplot(2,1,1),plot(1-2*angle(Uo(round(r/2),:)),'--k'),axis([1 r -1.1 pi]) 
hold on,plot(1+2*angle(Uo(round(r/2),:)),'-+r'),title('���۽��')
subplot(2,1,2),plot(Ii_n_yp(round(r/2)-2,91:477),'--k'),axis([1 386 0 2.5e-3])
hold on,plot(Ii_p_yp(round(r/2)-2,91:477),'-+r'),title('ʵ����')