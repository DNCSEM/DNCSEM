%data analysis and process contain
%read_data,resize_data PutNoiseFreToZero & rectangle kit.
% This is 2nd.
freBorder=512; % This is frequency border, which is 
%used to simplized the computation. Here the default value is 40.
F=Y;
F1=F;
F2=F;

F2(kk1+1)=0;
F2(L-(kk1-1))=0;
r=find(f>freBorder);
k1=r(1);
F1(k1+1:L-(k1-1))=0;
F2(k1+1:L-(k1-1))=0;
%N=nextpow2(2*k);
PN=T/(1/fre(1));
N=nextpow2(2*k1/PN);
NewL=2^N*PN;
if NewL>L
    NewL=2^N/2*PN;
end
F1(NewL-k1+1:L-(k1-1)-1)=[];
F2(NewL-k1+1:L-(k1-1)-1)=[];
%F1(2^N-k+1:L-(k-1)-1)=0;
f_rctrt=real(IGfft(F1));
f_rctrt_2=real(IGfft(F2));
%f_rctrt(2*105395-100:2*105395+100)=0;
Fs2=length(F1)/T;
newData=[Fs2,T;f_rctrt,zeros(NewL,1)];
newData2=[Fs2,T;f_rctrt_2,zeros(NewL,1)];
save([filename0(1:end-4),'_resize.dat'],'newData','-ascii');
save([filename0(1:end-4),'_resize_ForLocation.dat'],'newData2','-ascii');
F=Y3;
F11=F;
F11(k1+1:L-(k1-1))=0;
F11(NewL-k1+1:L-(k1-1)-1)=[];
%F11(2^N-k+1:L-(k-1)-1)=0;
Y3=F11;
f_rctrt1=real(IGfft(F11));
plot(f_rctrt);hold on;plot(f_rctrt1,'r');grid;xlim([0 length(f_rctrt)]);

magn0=2*abs(F11(1:length(F11)/2+1));
save('magn.dat','magn0','-ascii')
%semilogx(magn0)