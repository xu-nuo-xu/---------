Uo=imread('guang.bmp');       %����ͼ��
Uo=imresize(Uo,[256,256]);    %��ͼ�������256��256����
Uo=double(Uo(:,:,1));
figure;imshow(Uo,[]);         %��ʾ����ͼ��
[r,c]=size(Uo);               %���ؾ����С
ef=0.5;                       %���ô���λ�������ϵ��
FUo=fftshift(fft2(Uo.*exp(j.*rands(r,c).*pi.*ef)));   %���㸵��Ҷ�任
phi=angle(FUo);               %������λ�ֲ�
H=mod(phi,2*pi);              %������λȡģ��2�е�����
H1=round(H/max(H(:))*255);    %����������Ϊ255���Ҷȼ�������ȫϢͼ
CGH=exp(j.*H1/40.58);  %Ư�������ɴ���λȫϢͼ�������������λ��ԭ��0~2�У�
rU=ifft2(CGH);                %�����渵��Ҷ�任�õ����ֹⳡ
figure;imshow(H1,[]);         %��ʾ����õ���ȫϢͼ
figure;imshow(rU.*conj(rU),[0,0.0001]); %��ʾ������