I4=imread('cell21.bmp');I4=double(I4(7:518,10:521,1));  %��ȡ��һ������ȫϢͼ
I3=imread('cell22.bmp');I3=double(I3(7:518,10:521,1));  %��ȡ�ڶ�������ȫϢͼ
I2=imread('cell23.bmp');I2=double(I2(7:518,10:521,1));  %��ȡ����������ȫϢͼ
I1=imread('cell24.bmp');I1=double(I1(7:518,10:521,1));  %��ȡ���ķ�����ȫϢͼ
I1=medfilt2(I1,[3,3]);                                  %����ֵ�˲���ȫϢͼ����
I2=medfilt2(I2,[3,3]);                                  %����ֵ�˲���ȫϢͼ����
I3=medfilt2(I3,[3,3]);                                  %����ֵ�˲���ȫϢͼ����
I4=medfilt2(I4,[3,3]);                                  %����ֵ�˲���ȫϢͼ����
C1=I4-I2;                                               %ȫϢͼ���
C2=I1-I3;                                               %ȫϢͼ���
ph=atan(C1./(C2+eps));                                  %���������λ
figure;imshow(ph,[]);title('������λͼ');               %��ʾ�ؽ���λ
[r,c]=size(ph);
unph=ph;                                                %Ԥ�����������λ
unph(1,:)=unwrap_one_d(ph(1,:),ph(1,1),pi/2);%����ɵ�һ��Ԫ�صĽ��������
for n=1:c
    %������ɵ�n��Ԫ�صĽ�������㣬��ʼ��λֵΪ��һ����Ԫ�صĽ������λֵ
    unph(:,n)=unwrap_one_d(ph(:,n),unph(1,n),pi/2);
end
figure,surfl(unph),shading interp,colormap(gray)        %��ʾ�������λ
figure,imshow(unph,[])