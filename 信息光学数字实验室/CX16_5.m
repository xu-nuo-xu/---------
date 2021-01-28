ph=peaks(256).*4+rands(256,256).*0.5.*pi;  %����ԭʼ��λ����������
U=exp(j*ph);ph0=angle(U);                  %���ɶ�Ӧ�İ�����λ
[r,c]=size(ph0);
figure,imshow(ph0,[])
residue=zeros(r,c);                        %Ԥ��е����
for n=1:r-1                                %��ʼ����е�
   for m=1:c-1
       C(n,m)=round((ph0(n,m)-ph0(n,m+1))./2./pi)+round((ph0(n+1,m)-ph0(n,m))./2./pi)...
       +round((ph0(n+1,m+1)-ph0(n+1,m))./2./pi)+round((ph0(n,m+1)-ph0(n+1,m+1))./2./pi);
       if C(n,m)==1
          residue(n,m)=1;                  %�á�1����ʶ���е�
       end
       if C(n,m)==-1
          residue(n,m)=-1;                 %�á�-1����ʶ���е�
       end
   end
end
figure,imshow(residue,[])