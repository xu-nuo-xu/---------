Uo=imread('guang.bmp');             %������Ϊ���ͼ��
Uo=double(Uo (:,:,1));              %ȡ��һ�㣬��תΪ˫����
[r,c]=size(Uo);
Uo=ones(r,c)*0.98-Uo/255*0.5;       %����ת��Ϊ��͸������ϵ����
figure,imshow(Uo,[0,1]),title('��')
lamda=6328*10^(-10);k=2*pi/lamda;   %��ֵ�����Ͳ���
Lo=5*10^(-3)                        %��ֵ������(��)�ĳߴ�
xo=linspace(-Lo/2,Lo/2,r);yo=linspace(-Lo/2,Lo/2,c);
[xo,yo]=meshgrid(xo,yo);            %����������(��)����������
zo=0.20;                            %ȫϢ��¼�浽������ľ���,��λ:��
%������T-FFT�㷨������浽ȫϢ��¼����������
F0=exp(j*k*zo)/(j*lamda*zo);
F1=exp(j*k/2/zo.*(xo.^2+yo.^2));
fF1=fft2(F1);
fa1=fft2(Uo);
Fuf1=fa1.*fF1; 
Uh=F0.*fftshift(ifft2(Fuf1)); 
Ih=Uh.*conj(Uh);
figure,imshow(Ih,[0,max(max(Ih))/1]),title('ȫϢͼ')
%������T-FFT�㷨���ȫϢ�浽�۲�����������(�ع�������)
for t=1:40                         %��40��ͼ�����־ۡ��뽹����
    zi=0.10+t.*0.005               %�ò�ͬ��ֵ��ֵ���־���
    F0i=exp(j*k*zi)/(j*lamda*zi);
    F1i=exp(j*k/2/zi.*(xo.^2+yo.^2)); 
    fF1i=fft2(F1i);
    fIh=fft2(Ih); 
    FufIh=fIh.*fF1i; 
    Ui=F0i.*fftshift(ifft2(FufIh)); 
    Ii=Ui.*conj(Ui);
    imshow(Ii,[0,max(max(Ii))/1])
    str=['�������:',num2str(zi),'��'];%�趨��ʾ����
    text(257,30,str,'HorizontalAlignment','center','VerticalAlignment','middle','background','white'); %�趨��ͼ����ʾ�ַ���λ�ü���ʽ
    m(t)=getframe;                 %��ò�������ʾ��ͼ��
end
movie(m,2,5)                       %���ű����ͼ��