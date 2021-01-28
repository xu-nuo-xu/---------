Uo=imread('�ֱ��ʰ�_2.bmp');               %������Ϊ���ͼ��
Uo=double(Uo (:,:,1));                     %��ȡ��һ�㣬ת��Ϊ˫����
lamda=6328*10^(-10);k=2*pi/lamda;          %��ֵ����,��λ:��,��ʸ
D=0.01;                                    %��ֵ͸���Ŀ׾�,��λ:��
f=0.4;                                     %��ֵ͸���Ľ���,��λ:��
figure,imshow(Uo,[])
[c,r]=size(Uo);                            %��ȡ���������
%���������⴫�ݵ�͸�����������
L0=0.005                                   %��ֵ����ĳߴ�L0,��λ:��
x0=linspace(-L0/2,L0/2,r);y0=linspace(-L0/2,L0/2,c); %��ֵ���������
[x0,y0]=meshgrid(x0,y0);
d1=1.2;                                    %���浽͸���ľ���d1,��λ:��
L=r*lamda*d1/L0                            %�������͸��ǰ�����ϵĳߴ�L,��λ:��
p=linspace(-L/2,L/2,r);q=linspace(-L/2,L/2,c); %��ֵ͸��ǰ���������
[p,q]=meshgrid(p,q);
F00=exp(j*k*d1)/(j*lamda*d1)*exp(j*k/2/d1*(p.^2+q.^2));
Fpq=exp(j*k/2/d1*(x0.^2+y0.^2));
a= Uo.*Fpq;
FUpq=fft2(a);                              %��FFT�任
Ffpq=fftshift(FUpq);
Fufpq=F00.*Ffpq;                           %͸��ǰ�����ϵĹⳡ������ֲ�
I=Fufpq.*conj(Fufpq);                      %͸��ǰ�����ϵĹ�ǿ�ֲ�
figure,imshow(I,[]), colormap(pink),title('͸���ϵĹ�ǿ�ֲ�')
%�������ͨ��͸����Ĺⳡ
DD=round(D*r/L);                           %����׾���Ӧ�Ĳ�����
pxy=zeros(c,r);                            %���ɿ׾�����
for n=1:c
   for m=1:r
      if (n-c/2).^2+(m-r/2).^2<=(DD/2).^2;
      pxy(n,m)=1;
      end
   end
end
figure,imshow(pxy,[]);title('�׾�����')
Fufpqyp=Fufpq.*pxy.*exp(-j*k.*(p.^2+q.^2)/2/f); %����ͨ��͸����Ĺⳡ
%��������͸�����۲�����������
d2=d1*f/(d1-f)                             %�����ʽ�������d2,��λ:��
Lyp=r*lamda*d2/L,                          %�����۲��棨���棩�ĳߴ�,��λ:��
x=linspace(-Lyp/2,Lyp/2,r);y=linspace(-Lyp/2,Lyp/2,c); %�����۲��������
[x,y]=meshgrid(x,y);
F0=exp(j*k*d2)/(j*lamda*d2)*exp(j*k/2/d2*(x.^2+y.^2));
F=exp(j*k/2/d2*(p.^2+q.^2));
% ����������
re_image=fft2(Fufpqyp.*F);re_image=re_image.*F0;
if Lyp<0                                   %������ʱ����
   re_image=flipud(re_image);re_image=fliplr(re_image);%���ҡ����·�ת
end
figure,imshow(re_image.*conj(re_image),[]),title('������')