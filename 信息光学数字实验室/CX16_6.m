ph=peaks(256)*1;                 %Ԥ��ԭʼ��λ
mu=0.5;                          %����ϵ��
noise=rands(256,256).*mu.*pi;    %����
ph=ph+noise;                     %������������Ԥ��ԭʼ��λ
U=exp(j*ph); ph0=angle(U);       %��Ӧ�İ�����λ
[r,c]=size(ph0);
figure,imshow(ph0,[])
phs=ph0;                         %Ԥ�����������λ
for n=1:r-1                      %���н����
   for m=1:c-1                   %���н����
      if phs(n,m)-phs(n+1,m)>=pi
        phs(n+1,m)=phs(n+1,m)+2*pi;
      end
      if phs(n,m)-phs(n+1,m)<=-pi
        phs(n+1,m)=phs(n+1,m)-2*pi;
      end
   end
end
figure,imshow(phs,[])