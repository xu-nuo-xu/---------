II=imread('rw630mm.jpg');              %��������ȫϢͼ
II=double(II(:,:,1));                  %��ȡ����ȫϢͼ�ĵ�һ��(��ɫ)
figure,imshow(II,[])
holo=fftshift(fft2(II));               %�������ֹⳡ
Ii=holo.*conj(holo);                   %�����������ǿ
figure,imshow(Ii,[0,max(max(Ii))./ 200000]),colormap(pink),title('������')