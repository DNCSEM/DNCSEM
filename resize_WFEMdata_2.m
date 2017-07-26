border=40; %% give the up bound frequency of useful signal
[Filename,Pathname,FilterIndex]=uigetfile({'*.dat;*.txt','File format(*.dat,*.txt)';...
    '*.*','All Files (*.*)'},'d:\samples\'); 
if ~FilterIndex
   return;
else
    Infile=[Pathname,Filename];
    if strcmp(Filename(end-3:end),'.dat')
        a1=load(Infile);
    elseif strcmp(Filename(end-3:end),'.txt')
        file=fopen(Infile,'r');
        da=textscan(file,'%f %f','HeaderLines',17);
        a1=cell2mat(da);
        fclose(file);
    end
end
InfoMat=load('SignalInfo.dat');
rowNum=str2double(Filename(end-25))+1;
Fs=InfoMat(rowNum,3); 
Lowest=InfoMat(rowNum,2);

Period=floor(length(a1)/Fs*Lowest);
T=Period/Lowest;
data=a1(1:Fs*T,2);
L=length(data);

f = Fs/2*linspace(0,1,L/2+1);
F=Gfft(data);
r=find(f>border); % give the up bound of useful signal
k=r(1);
F0=F;
F0(k+1:L-(k-1))=0;
F1=F0;
%N=nextpow2(2*k);
N=nextpow2(2*(k+1))+1;
F1(2^N-k+1:L-(k-1)-1)=[];
f_rctrt=real(IGfft(F1));
semilogx(f(1:2^N/2+1),2*abs(F1(1:2^N/2+1)),'r','linewidth',2);
Fs1=length(F1)/T;
newData=[Fs1,T;f_rctrt,zeros(2^N,1)];
save(['New_',Filename(1:end-4),'.dat'],'newData','-ascii')

figure(2)
semilogx(f(1:L/2+1),2*abs(F(1:L/2+1)),'r','linewidth',2);
xlabel('\bf Frequency/Hz','fontsize',24)
ylabel('\bf Amplitude/mv','fontsize',24)
set(gca,'LineWidth',2);grid
set(gca,'FontSize',20);