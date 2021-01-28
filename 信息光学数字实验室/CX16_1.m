r=512,c=r;                             %���������ϵĳ�����
Uo=zeros(r,c);                         %Ԥ����ⳡ
Uo(r/2-r/4+1:r/2+r/4,c/2-c/4+1:c/2+c/4)=2;  %������ⳡ���
Uo(r/2-round(r/6)+1:r/2+round(r/6),c/2-round(c/6)+1:c/2+round(c/6))=4; 
Uo(r/2-round(r/12)+1:r/2+round(r/12),c/2-round(c/12)+1:c/2+round(c/12))=6;
Uo(r/2-r/4+1:r/2+r/4,c/2-c/4+1:c/2+c/4)=...
Uo(r/2-r/4+1:r/2+r/4,c/2-c/4+1:c/2+c/4).*exp(j*peaks(256)*2); %����������λ
lamda=6328*10^(-10);k=2*pi/lamda;      %��ֵ����,��λ:��,��ʸ
D=0.06;f=0.4;                          %��ֵ͸���Ŀ׾�������,��λ:��
figure,imshow(Uo.*conj(Uo),[])         %��ʾ����ǿ�ֲ�
%���������⴫�ݵ�͸�����������
L0=0.005                               %��ֵ����ĳߴ�L0,��λ:��
x0=linspace(-L0/2,L0/2,c);y0=linspace(-L0/2,L0/2,r); %��ֵ���������
[x0,y0]=meshgrid(x0,y0);
d1=1.2;                                %���浽͸���ľ���d1,��λ:��
L=r*lamda*d1/L0                  %�������͸��ǰ�����ϵĳߴ�L,��λ:��
p=linspace(-L/2,L/2,c);q=linspace(-L/2,L/2,r); %��ֵ͸��ǰ���������
[p,q]=meshgrid(p,q);
F00=exp(j*k*d1)/(j*lamda*d1)*exp(j*k/2/d1*(p.^2+q.^2));
Fpq=exp(j*k/2/d1*(x0.^2+y0.^2));
a= Uo.*Fpq;FUpq=fft2(a); Ffpq=fftshift(FUpq);
Fufpq=F00.*Ffpq;                      %͸��ǰ�����ϵĹⳡ������ֲ�
%�������ͨ��͸����Ĺⳡ
DD=round(D*r/L);                      %����׾���Ӧ�Ĳ�����
pxy=zeros(r,c);                       %���ɿ׾�����
for n=1:r
   for m=1:c
      if (n-r/2).^2+(m-c/2).^2<=(DD/2).^2;
      pxy(n,m)=1;
      end
   end
end
Fufpqyp=Fufpq.*pxy.*exp(-j*k.*(p.^2+q.^2)/2/f); %����ͨ��͸����Ĺⳡ
%��������͸����������������
d2=d1*f/(d1-f)                        %�����ʽ�������d2,��λ:��
Lyp=r*lamda*d2/L,                     %��������ĳߴ�,��λ:��
x=linspace(-Lyp/2,Lyp/2,c);y=linspace(-Lyp/2,Lyp/2,r); %�������������
[x,y]=meshgrid(x,y);
F0=exp(j*k*d2)/(j*lamda*d2)*exp(j*k/2/d2*(x.^2+y.^2));
F=exp(j*k/2/d2*(p.^2+q.^2));
re_image=fft2(Fufpqyp.*F);re_image=re_image.*F0;%�ع�������ⳡ
figure,imshow(re_image.*conj(re_image),[]),title('������')
%��������������ⳡ��ο���ĸ������ƣ�����ȫϢͼ��
meanA=mean(abs(re_image(:))).*4;     %Ϊ�����Ρ����Ĺ�������׼��
alpha=pi/2.00; beita=pi/2.02;        %�ο�����x�ᡢy���ļн�
R=meanA.*exp(j*k*(x*cos(alpha)+y*cos(beita))); %׼�������ĸ��ο���
R1=R;                         %�ο���1
R2=R.*exp(j*pi/2);                   %�ο���2
R3=R.*exp(j*2*pi/2);                 %�ο���3
R4=R.*exp(j*3*pi/2);                 %�ο���4
I1=(re_image+R1).*conj(re_image+R1); %��������ȫϢͼ1
I2=(re_image+R2).*conj(re_image+R2); %��������ȫϢͼ2
I3=(re_image+R3).*conj(re_image+R3); %��������ȫϢͼ3
I4=(re_image+R4).*conj(re_image+R4); %��������ȫϢͼ4
figure,imshow(I1,[])                 %��ʾ����ȫϢͼ1
ph=atan((I4-I2)./(I1-I3));           %�����ؽ���λ
figure,imshow(ph,[])                 %��ʾ�ؽ���λ
figure,plot(ph(r/2-r/4+1:r/2+r/4,c/2)) %������λ����
FI=fft2(I1);                         %����ȫϢͼ1��Ƶ��,׼���ø���Ҷ�任���ؽ���λ
figure,imshow(log(abs(FI)),[])       %��ʾȫϢͼ1��Ƶ��
FIyp=zeros(r,c);                     %Ԥ���˲����Ƶ��
FIyp(258:393,174:323)=FI(258:393,174:323); %�˲����Ƶ��
OR=ifft2(FIyp);                      %���渵��Ҷ�任�ع�OR*
phyp=atan(imag(OR)./real(OR));       %�����ؽ���λ
figure,imshow(phyp,[])               %��ʾ�ؽ���λ
figure,plot(phyp (r/2-r/4+1:r/2+r/4,c/2)) %������λ����