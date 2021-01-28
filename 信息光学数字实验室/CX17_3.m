Uo=imread('guang1.jpg');         %����ͼ��
Uo=double(Uo(:,:,1))./255;       %��ͼ��Ļҽ׶�ֵ��Ϊ0��1
figure,imshow(Uo,[])             %��ʾ��Ϊ���ͼ��
[r,c]=size(Uo);
ef=0.5;                          %���������λ����ϵ��
phai=rands(r,c).*pi.*ef;         %���������λ
FUo=fftshift(fft2(Uo.*exp(j.*phai))); %��FFT�任
A=abs(FUo);                      %�ⳡ������ֲ�
figure,imshow(A,[])
real1=real(FUo)./max(A(:)).*255; %��ʵ��������256�ҽ�
imag1=imag(FUo)./max(A(:)).*255; %���鲿������256�ҽ�
%����������������ҽ�ȫϢͼ
CGH=zeros(r*4,c*4);              %Ԥ��CGH����
for n=1:r
   for m=1:c
   cgh=zeros(4,4);
      if real(FUo(n,m))>=0&imag(FUo(n,m))>=0         %��ʵ������0���鲿Ҳ����0
        cgh(:,1)=real1(n,m);cgh(:,2)=imag1(n,m);     %��ֵ��1�к͵�2��
        elseif real(FUo(n,m))>=0&imag(FUo(n,m))<0    %��ʵ������0���鲿С��0
        cgh(:,1)=real1(n,m);cgh(:,4)=abs(imag1(n,m));%��ֵ��1�к͵�4��
        elseif real(FUo(n,m))<0&imag(FUo(n,m))>=0    %��ʵ��С��0���鲿����0
        cgh(:,3)=abs(real1(n,m));cgh(:,2)=imag1(n,m);%��ֵ��3�к͵�2��
        elseif real(FUo(n,m))<0&imag(FUo(n,m))<0     %��ʵ��С��0���鲿ҲС��0
        cgh(:,3)=abs(real1(n,m));cgh(:,4)=abs(imag1(n,m)); %��ֵ��3�к͵�4��
      end
    CGH((n-1)*4+1:n*4,(m-1)*4+1:m*4)=cgh; %�����ɵĳ�����Ԫ�ŵ�����ȫϢͼ��
    end
end
figure,imshow(CGH,[])            %��ʾ����ȫϢͼ
rU=fftshift(ifft2(CGH));         %�渵��Ҷ�任�õ����ֹⳡ
rI= rU.*conj(rU);                %����������
figure,imshow(rI,[0,max(max(rI))/10000])%��ʾ������