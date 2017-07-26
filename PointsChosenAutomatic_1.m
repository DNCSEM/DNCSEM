% PointsChosenAutomatic
%threshold=1000;

[filename0,pathname] = uigetfile('*.*','Select a data file');
a1=load(filename0);
interval=1;
aa=a1(2:interval:end,1);
a=aa';
Fs=a1(1,1)/interval;
T=a1(1,2);
L=length(a);
t=linspace(0,T,L);
ps=0;
a=a+ps;

[filename1,pathname1] = uigetfile('*.*','Select a data file');
fre_mat=load(filename1);
OctNum=nextpow2(fre_mat(end,1)/fre_mat(1,1));
numOctave = OctNum;
numVoices = 8;
a0 = 2^(1/numVoices);
freq = fre_mat(1,1)/2*a0.^(1:numOctave*numVoices);

f0=centfrq('morl');
%f0=1.5;
dt=1/Fs;
%freq=[0.1:0.1:100];
m_fre=0;
vec_order=1:200;

%freq=kron(vec_order,m_fre);
%coefs = cwt(a,f0./freq*Fs,'cmor1-1.5','coloration');
cwta1 = cwtft(a,'wavelet','morl','scales',f0./freq*Fs); %f0./[1:1:100]*Fs
mat0=abs(cwta1.cfs);
contour_num=12;
log_slec=0;
norm=diag(freq.^0.5);
mat1=norm*mat0;
dif_mat=diff(mat1')';

    subplot(3,1,1)
        plot(t,a,'k','linewidth',1.5);xlim([0 max(t)]);%colorbar
        y_limit=max(a)*1.25;
        ylim([-y_limit y_limit])
        grid
        set(gca,'LineWidth',2)
        xlabel({'Second/s';'(a)'},'fontsize',22);
        ylabel('Amplitude/mv','fontsize',22); 
        set(gca,'FontSize',18);
    subplot(3,1,2)
        mat1_1=abs(mat1(end*1/4:end,:));
        plot(t(1:end),sum(mat1_1,1),'linewidth',2);
        set(gca,'LineWidth',2)
        xlabel({'Second/s';'(b)'},'fontsize',22);
        ylabel('Amplitude','fontsize',22); 
        set(gca,'FontSize',18);grid;xlim([t(1) t(end)])
        ylim([0 max(sum(mat1_1,1))/2])
    subplot(3,1,3)
        dif_mat1=abs(dif_mat(end*1/4:end,:));
        dif_mat2=[dif_mat1,dif_mat1(:,end)];
        plot(t(1:end),sum(dif_mat2,1),'linewidth',2);
        set(gca,'LineWidth',2)
        xlabel({'Second/s';'(c)'},'fontsize',22);
        ylabel('Amplitude','fontsize',22); 
        set(gca,'FontSize',18);grid;xlim([t(1) t(end)])
        ylim([0 max(sum(dif_mat1,1))/2])
        
index=1:length(aa);
chosenMat0=[index;a;sum(mat1_1,1)/size(mat1_1,1)]';

figure
AmpVec=sum(mat1_1,1)/size(mat1_1,1);
AmpVec_log=log10(AmpVec);
y=AmpVec_log;
ymin=min(y);
ymax=max(y);
L1=50;
x=linspace(ymin,ymax,L1); 
AmpVec_log1=sort(AmpVec_log,2);
thres=AmpVec_log1(floor(0.2*length(AmpVec_log1)));
[r_out,c_out]=find(chosenMat0(:,3)<10^thres);
yy=hist(y,x); %????????? 
yy=yy/length(y); %????????? 
bar(x,yy) %????????? 
R_thres=0.001;
[r_out,c_out]=find(abs(a')<max(a)*R_thres);

figure
plot(t,a);hold on
plot(t(r_out),1,'r','linewidth',2)

pointsChosenMat=[r_out';a(r_out);ones(1,length(r_out))*mean(a(r_out));zeros(1,length(r_out))]';
save pointsChosenMat.dat pointsChosenMat -ascii