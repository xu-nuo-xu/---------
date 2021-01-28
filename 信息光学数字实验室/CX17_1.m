Uo=imread('guang.bmp');Uo=double(Uo(:,:,1)); %������Ϊ���ͼ��
sizeUor=64; sizeUoc=64;                    %����ͼ���С
Uo=imresize(Uo,[sizeUor,sizeUoc]);         %����ͼ���С
figure,imshow(Uo,[])                       %��ʾ��
[r,c]=size(Uo);                            %��ѯͼ���С
ef1=0.8                                    %��������ϵ����Ϊ�˽���Ƶ�׵Ķ�̬��Χ��
FUo=fftshift(fft2(Uo.*exp(j.*rands(r,c).*pi.*ef1))); % ����ⳡ���и���Ҷ�任
Am=abs(FUo);                               %����ģ�Ĵ�С
Ph=mod(angle(FUo),2*pi);                   %������λ�Ĵ�С��ȡ2�е�����
Ph=Ph./2/pi;                               %������2��
w=6                                        %ͨ��׾��Ŀ�ȣ���Ϊż����
wth=round(w/2);                            %ͨ��׾���һ��
s=2*w;                                     %���ñ��뵥Ԫ�Ĵ�С�����أ�
CGH=zeros(r*s,c*s);                        %Ԥ�����ȫϢ����
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%������ɱ���Ĳ������㣨�������ͣ�
maxAm=max(abs(FUo(:)));                    %����Ƶ�׵�ģ�����ֵ
ef2=1.5                                    %������ֵϵ��
th=maxAm/ef2;                              %������ֵ
Am(Am>th)=th;                              %��������ֵ��ģ����Ϊ������ֵ
lmn=round(Am/th*w);                        %��ģ���й�һ��,Ȼ������������0,1,2,��,w
pmn=round(Ph*w);                           %����λ������0,1,2,��,w
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%�������ȫϢͼ��ֵ����
for m=1:r;                                 %��������
    for n=1:c;                             %��������
        cgh=zeros(s,s);                    %Ԥ�����ȫϢͼ������Ԫ
        if lmn(m,n)==0;                    %��ģ��Ϊ��ĵ���б���
            elseif pmn(m,n)<=wth           %��λֵС�ڦ�/2��������ģʽ���
            cgh(w+1-lmn(m,n):w+lmn(m,n),w-wth+pmn(m,n)+1:2*w-wth+pmn(m,n))=1;
            elseif pmn(m,n)>wth            %��λֵ���ڦ�/2������ģʽ���
            cgh(w+1-lmn(m,n):w+lmn(m,n),w-wth+pmn(m,n)+1:s)=1;
            cgh(w+1-lmn(m,n):w+lmn(m,n),1:pmn(m,n)-wth)=1;
        end
        CGH((m-1)*s+1:m*s,(n-1)*s+1:n*s)=cgh;%�����ɵĳ�����Ԫ�ŵ�����ȫϢͼ��
    end
end
figure;imshow(CGH,[]);                     %�ػ�λ����������������ͣ�
%= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
%���������������
RU=fftshift(ifft2(CGH));                   %���渵��Ҷ�任�������ֹⳡ
RI=RU.*conj(RU);                           %����������Ĺ�ǿ�ֲ�
figure;imshow(RI,[0,max(RI(:))/1000]),colormap(pink); %��ʾ����ͼ��