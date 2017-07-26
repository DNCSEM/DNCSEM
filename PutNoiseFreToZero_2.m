%data analysis and process contain
%read_data,resize_data & rectangle kit.
% This is 3rd.
Avec=load('mdfy_point0.dat');
Avec(:,2)=1000*Avec(:,2);
Avec(:,4)=1000*Avec(:,4);
raw=load('magn.dat');
[rr cc]=size(raw);
if rr>1
    raw=raw';
end
raw=raw*1000;
raw0=raw;
Avec_n=find(Avec(:,1)==0);
Avec(Avec_n,:)=[];
sizeA=size(Avec);
l=sizeA(1);
Avec=round(Avec);
colum_out=cell(1,l);
mn=zeros(length(raw),1);
mn_n=0;
for j=1:l
    if Avec(j,1)+Avec(j,3)<length(raw) && Avec(j,1)>0
        raw1=raw(Avec(j,1):Avec(j,1)+Avec(j,3));
    [r,c,v]=find(raw1>Avec(j,2) & raw1<Avec(j,2)+Avec(j,4));
    out=c+Avec(j,1)-1;
    elseif Avec(j,1)<0
        raw1=raw(1:Avec(j,1)+Avec(j,3));
    [r,c,v]=find(raw1>Avec(j,2) & raw1<Avec(j,2)+Avec(j,4));
    out=c+1-1;
    else 
        raw1=raw(Avec(j,1):length(raw));
    [r,c,v]=find(raw1>Avec(j,2) & raw1<Avec(j,2)+Avec(j,4));
    out=c+Avec(j,1)-1;
    end
    mn(mn_n+1:mn_n+length(out))=out;
    mn_n=mn_n+length(out);
end
nn=find(mn(:,1)==0);
mn(nn)=[];
mn=sort(mn);
mn=sort(mn,'descend');
mn=mn';
raw0(mn)=0;
raw=raw/1000;
raw0=raw0/1000;

Y_rc=Y3;
Y_rc(mn+1)=0;
Y_rc(length(Y_rc)-(mn-1))=0;
f_rc=real(IGfft(Y_rc));
f_rc_new=[Fs2,T;f_rc,zeros(length(f_rc),1)];
figure;
semilogx(raw);hold on
semilogx(raw0,'r')

save([filename0(1:end-4),'_ForPointsLocation.dat'],'f_rc','-ascii');
save([filename0(1:end-4),'_ForPointsLocation_forCWT.dat'],'f_rc_new','-ascii');
save magn1.dat raw0 -ascii
%figure(2);L=2*(length(raw)-1);Fs=4800;fre=Fs/2*linspace(0,1,L/2+1);
%semilogx(fre(mn),1,'r*');hold on;stem(fre(mn),ones(1,length(mn)),'r');

