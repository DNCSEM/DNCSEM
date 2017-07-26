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

R_thres=0.01;
[r_out,c_out]=find(abs(a')<max(a)*R_thres);

figure(5)
plot(t,a);hold on
plot(t(r_out),1,'r','linewidth',2)

pointsChosenMat=[r_out';a(r_out);ones(1,length(r_out))*mean(a(r_out));zeros(1,length(r_out))]';
save pointsChosenMat.dat pointsChosenMat -ascii