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
magn1=2*abs(F(1:L/2+1));
semilogx(f,magn1,'r','linewidth',2);
xlabel('\bf Frequency/Hz','fontsize',24)
ylabel('\bf Amplitude/mv','fontsize',24)
set(gca,'LineWidth',2);
set(gca,'FontSize',20);
grid;

