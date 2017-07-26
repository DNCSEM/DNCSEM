%data analysis and process contain
%read_data,resize_data & rectangle kit.
% This is 1st.
[filename0,pathname] = uigetfile('*.*','Select a data file');
data0=load(filename0);
%Fs1=6.826666666666666e+02;fre=load('fres7_4_2.dat');
%Fs1=64;fre=1/16:1/16:30;
data=data0(2:end,1);
Fs1=data0(1,1);
T=data0(1,2);

[Filename_fre,Pathname,FilterIndex]=uigetfile({'*.dat;*.txt','File format(*.dat,*.txt)';...
    '*.*','All Files (*.*)'}); 
fre_mat=load(Filename_fre);
fre=fre_mat(:,1);
%fre=getFre(1/2^6,40);

t=0:1/Fs1:T-1/Fs1;
data1=data;
%data1=data1-mean(data1);
L=length(data1);
f = Fs1/2*linspace(0,1,L/2+1);
Y = Gfft(data1);
Y1=Y;
%y1=real(IGfft(Y1));
smalls=0;

figure(1)
main_fre=fre(1);
fre_vec=fre;
fre_index=round(fre_vec/(Fs1/L))+1;
Y2=Y1;
kk=fre_index-1;
Y1_1=Y1;
Y1_1(kk+1)=smalls;
Y1_1(L-(kk-1))=smalls;
f_rc1=real(IGfft(Y1_1));

Y_rc=Y1;
MagnEdit0=ones(L/2,1);
MagnEdit=zeros(L/2,1);
MagnEdit0(kk+1)=2*abs(Y_rc(kk+1));
MagnEdit(kk+1)=abs(Y_rc(kk))+abs(Y_rc(kk+2));
preRatio=MagnEdit./MagnEdit0;
[r_j,c_j]=find(preRatio>0 & preRatio<0.5);
kk1=r_j-1;

Y2(kk1+1)=smalls;
Y2(L-(kk1-1))=smalls;
f_rc2=real(IGfft(Y2));

Y3=Y1;
Y3(kk+1)=(Y3(kk)+Y3(kk+2))/2;
Y3(L-(kk-1))=(Y3(L-(kk-2))+Y3(L-(kk)))/2;
f_rc3=real(IGfft(Y3));


%y3=real(IGfft(Y3));
%y2=IGfft(Y2);
figure(1)
subplot(2,1,1)
magn=2*abs(Y(1:L/2+1));
loglog(f,magn,'k','linewidth',2);
hold on
magn2=2*abs(Y2(1:L/2+1));
loglog(f,magn2,'linewidth',2);grid;ylim([10^-3 10^4])
hold on
magn3=2*abs(Y3(1:L/2+1));
%loglog(f,magn3,'r','linewidth',2);

magn1_1=2*abs(Y1_1(1:L/2+1));
loglog(f,magn1_1,'g','linewidth',2);

xlabel('\bf Frequency/Hz','fontsize',16);
ylabel('\bf Magnitude log10','fontsize',16); 
set(gca,'LineWidth',2);
set(gca,'FontSize',20);

subplot(2,1,2)
magn=2*abs(Y(1:L/2+1));
semilogx(f,magn,'k','linewidth',2);
hold on
magn2=2*abs(Y2(1:L/2+1));
semilogx(f,magn2,'linewidth',2);grid
hold on
magn3=2*abs(Y3(1:L/2+1));
%semilogx(f,magn3,'r','linewidth',2);

magn1_1=2*abs(Y1_1(1:L/2+1));
semilogx(f,magn1_1,'g','linewidth',2);

xlabel('\bf Frequency/Hz','fontsize',16);
ylabel('\bf Magnitude','fontsize',16); 
set(gca,'LineWidth',2);
set(gca,'FontSize',20);

figure(2)
plot(data1,'k')
hold on
plot(f_rc1,'g')
hold on
plot(f_rc2,'b')
hold on; plot(f_rc3,'r')


mag=2*abs(Y(kk+1));
pha=angle(Y(kk+1));
reliability=abs(Y1(kk)/2+Y1(kk+2)/2)./abs(Y(kk+1));
mat_out=[fre_vec mag pha  real(Y(kk+1)) imag(Y(kk+1)) 1-reliability];
save([filename0(1:end-4),'_RawInfo.dat'],'mat_out','-ascii')
save('magn.dat','magn2','-ascii')

new_data1=data0;
new_data1(2:end,2)=f_rc1;
save([filename0(1:end-4),'_forLocation1.dat'],'new_data1','-ascii')
new_data2=data0;
new_data2(2:end,2)=f_rc2;
save([filename0(1:end-4),'_forLocation2.dat'],'new_data2','-ascii')
