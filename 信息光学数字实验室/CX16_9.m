I4=imread('cell21.bmp');I4=double(I4(7:518,10:521,1));  %��ȡ��һ������ȫϢͼ
I3=imread('cell22.bmp');I3=double(I3(7:518,10:521,1));  %��ȡ�ڶ�������ȫϢͼ
I2=imread('cell23.bmp');I2=double(I2(7:518,10:521,1));  %��ȡ����������ȫϢͼ
I1=imread('cell24.bmp');I1=double(I1(7:518,10:521,1));  %��ȡ���ķ�����ȫϢͼ
I1=medfilt2(I1,[3,3]);                            %����ֵ�˲���ȫϢͼ����
I2=medfilt2(I2,[3,3]);                            %����ֵ�˲���ȫϢͼ����
I3=medfilt2(I3,[3,3]);                            %����ֵ�˲���ȫϢͼ����
I4=medfilt2(I4,[3,3]);                            %����ֵ�˲���ȫϢͼ����
C1=I4-I2;                                         %ȫϢͼ���
C2=I1-I3;                                         %ȫϢͼ���
ph=atan(C1./(C2+eps));                            %���������λ
figure;imshow(ph,[]);title('������λͼ');         %��ʾ�ؽ���λ
a=ph;                                             %��������λph��ֵ��a
%���濪ʼ������С���˽��������
[M,N]=size(a);                                    %�����ά������λ�Ĵ�С���С�������
dx=zeros(M,N);dy=zeros(M,N);                      %Ԥ�������λ��x�����y������ݶ�
m=1:M-1; 
dx(m,:)=a(m+1,:)-a(m,:);                          %���������λ��x������ݶ�
dx=dx-pi*round(dx/pi);                            %ȥ���ݶ��е���Ծ
n=1:N-1;
dy(:,n)=a(:,n+1)-a(:,n);                          %���������λ��y������ݶ�
dy=dy-pi*round(dy/pi);                            %ȥ���ݶ��е���Ծ
p=zeros(M,N);p1=zeros(M,N);p2=zeros(M,N); %Ϊ�����nm��׼��
m=2:M;
p1(m,:)=dx(m,:)-dx(m-1,:);                        %���㦤gxnm-��gx(n-1)m
n=2:N;
p2(:,n)=dy(:,n)-dy(:,n-1);                        %���㦤gynm�C��gyn(m-1)
p=p1+p2;                                          %�����nm
p(1,1)=dx(1,1)+dy(1,1);                           %�����nm
n=2:N;
p(1,n)=dx(1,n)+dy(1,n)-dy(1,n-1);                 %��ֵNeumann�߽�����
m=2:M;
p(m,1)=dx(m,1)-dx(m-1,1)+dy(m,1);
pp=dct2(p)+eps;                                   %�����nm��DCT
fi=zeros(M,N);
for m=1:M                                         %���㦵nm��DCT��ľ�ȷ��
   for n=1:N  
      fi(m,n)=pp(m,n)/(2*cos(pi*(m-1)/M)+2*cos(pi*(n-1)/N)-4+eps);
   end
end
fi(1,1)=pp(1,1);                                  %��ֵDCT��Ħ�11
phs=idct2(fi);                                    %��iDCT����������λ�ڿ����е�ֵ
figure,surfl(phs),shading interp,colormap(gray)   %��ʾ�������λ
%Ϊ��������Ч�����Խ������λ���ٰ�������
U=exp(j.*phs);                                    %�ý������λ�����ⳡ
rewrap_ph=atan(imag(U)./real(U));                 %���ٰ�������
figure,imshow(rewrap_ph,[])                       %��ʾ�ٰ������