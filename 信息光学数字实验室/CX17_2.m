alpha=600000;                          %������Ƶ
Uo=imread('guang1.jpg');               %����ͼ��
Uo=imresize(Uo,[256,256]);             %����ͼ���С
Uo=double(Uo (:,:,1));                 %��ȡͼ���һ��Ϊ��
figure;imshow(Uo,[]);                  %��ʾ����ͼ��
[r,c]=size(Uo);                        %��������С
l0x=0.005;l0y=0.005;                   %��������ߴ�
x=linspace(-l0x/2,l0x/2,c);y=linspace(-l0y,l0y,r);
[x,y]=meshgrid(x,y);                   %���������ά����
ef=0.5;                                %�����������λ������ϵ��
FUo=fftshift(fft2(Uo.*exp(j.*rands(r,c).*pi.*ef))); %����Ҷ�任����Ƶ�ײ���Ƶ
A=abs(FUo);                            %����Ƶ�׵����
A=A./max(A(:));                        %��һ�����
phi=angle(FUo);                        %����Ƶ�׵���λ�ֲ�
H=0.5*[1+A.*cos(2*pi*alpha.*x-phi)];   %���в������
H=round(H./max(H(:)).*255);            %��ȫϢͼ����Ϊ256���ҽ�
rU=ifft2(H);                           %�渵��Ҷ�任�õ����ֹⳡ
figure;imshow(H,[]);                   %��ʾ�������õ���ȫϢͼ
figure;imshow(rU.*conj(rU),[0,0.01]);  %��ʾ���ֵ�ͼ��