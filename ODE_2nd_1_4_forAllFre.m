% including trade-off parameters of weighted least squares
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Avec=load('mdfy_point2.dat');
points_chosen=load('points_chosen.dat');
raw=load('NPC.dat');
raw=raw';
raw0=raw;
Avec_n=find(Avec(:,1)==0);
Avec(Avec_n,:)=[];
sizeA=size(Avec);
l=sizeA(1);
Avec(:,1)=round(Avec(:,1));
Avec(:,3)=round(Avec(:,3));
mn=zeros(length(raw),1);
mn_n=0;
for j=1:l
    if Avec(j,1)+Avec(j,3)<length(raw) && Avec(j,1)>0
        raw1=raw(Avec(j,1):Avec(j,1)+Avec(j,3));
    [r,c1,v]=find(raw1>Avec(j,2) & raw1<Avec(j,2)+Avec(j,4));
    out=c1+Avec(j,1)-1;
    elseif Avec(j,1)<0 &&  Avec(j,1)+Avec(j,3)<length(raw) 
        raw1=raw(1:Avec(j,1)+Avec(j,3));
    [r,c1,v]=find(raw1>Avec(j,2) & raw1<Avec(j,2)+Avec(j,4));
    out=c1+1-1;
    elseif Avec(j,1)+Avec(j,3)>length(raw) && Avec(j,1)<0
        raw1=raw(1:length(raw));
    [r,c1,v]=find(raw1>Avec(j,2) & raw1<Avec(j,2)+Avec(j,4));
    out=c1+1-1;
    else 
        raw1=raw(Avec(j,1):length(raw));
    [r,c1,v]=find(raw1>Avec(j,2) & raw1<Avec(j,2)+Avec(j,4));
    out=c1+Avec(j,1)-1;
    end
    mn(mn_n+1:mn_n+length(out))=out;
    mn_n=mn_n+length(out);
end
nn=find(mn(:,1)==0);
mn(nn)=[];
mn=sort(mn,'descend');
mn=mn';
raw0(mn)=[];
figure;
plot(raw);hold on;plot(raw0,'r')

col_num1(mn)=[]; 
m1(mn)=[];
points_chosen(mn,:)=[];
const_mat(mn,:)=[];
yM=(X1(col_num1)-points_chosen(:,chosen_col))/2;

% trade-off parameters of weighted least squares same as ODE_1st
extra=eye(x_nums);
NewMatA1(mn,:)=[];
yM1=[yM;balance^0.5*zeros(x_nums,1);balance1^0.5*zeros(length(m),1)];

x=NewMatA1\yM1;

Result=zeros(length(Fre_index),1);
Result1=zeros(length(Fre_index),1);
Ori=zeros(length(Fre_index),1);
Y2=Y;
Y3=Y;

i=(-1)^0.5;
for num3=1:length(Fre_index) 
    Result(num3)=Y(bb(num3))+x(2*num3-1)+x(2*num3)*i;
    Result1(num3)=Y(L-bb(num3)+2)+x(2*num3-1)-x(2*num3)*i;
    
    Y2(bb(num3))=Result(num3);
    Y2(L-bb(num3)+2)=Result1(num3);

    Y3(bb(num3))=-x(2*num3-1)-x(2*num3)*i;
    Y3(L-bb(num3)+2)=-x(2*num3-1)+x(2*num3)*i;
    
    Ori(num3)=Y(bb(num3));
end

X3_1=real(IGfft(Y3));

time=1/Fs:1/Fs:L/Fs;
%figure(2)

points_chosen(:,2)=X3_1(col_num1);

points_chosen(:,chosen_col)=points_chosen(:,chosen_col)+2*const_mat*x(end-length(c)/2*(accuracy+1)+1:end);   

x_out=X3_1(col_num1)-points_chosen(:,chosen_col);
%x_out=X3_1(col_num1);
%plot(x_out,'r')
save points_chosen.dat points_chosen -ascii
save NPC.dat x_out -ascii
ylabel('Amplitude/mv')
xlabel('Number')
set(gcf,'color','white')

figure(3)
magn1=2*abs(Y(1:L/2+1));
semilogx(f0,magn1,'r','linewidth',2);
hold on;
Result_out=Y-Y3;
magn=2*abs(Result_out(1:L/2+1));
semilogx(f0,magn,'b','linewidth',2);
xlabel('\bf Frequency/Hz','fontsize',24)
ylabel('\bf Amplitude/mv','fontsize',24)
set(gca,'LineWidth',2);
set(gca,'FontSize',20);
grid;



figure(5)
plot(X3_1(col_num1));hold on;
plot(points_chosen(:,chosen_col),'r') 

spectrum_pro=[f0' magn];
spectrum_raw=[f0' magn1];
save spectrum_pro.dat spectrum_pro -ascii
save spectrum_raw.dat spectrum_raw -ascii

MatA1_inverse=NewMatA1'*NewMatA1;
[vv,dd]=eig(MatA1_inverse);
cond_num=dd(end,end)/dd(1,1); % to judge whether the matrix is a ill-conditioned matrix

MatA(mn,:)=[];
MatA1_inverse1=MatA'*MatA;
[vv1,dd1]=eig(MatA1_inverse1);
cond_num1=dd1(end,end)/dd1(1,1); 


figure(4)
Result_out=Y-Y3;
magn=2*abs(Result_out(1:L/2+1));

error=X3_1(col_num1)-points_chosen(:,chosen_col);
error=error-mean(error); 

error_vecor=zeros(length(X3_1),1);
error_vecor(col_num1)=error;
F_error= Gfft(error_vecor);
magn1=2*abs(F_error(1:L/2+1));
Amplifier=length(X3_1)/length(col_num1);
semilogx(f0,-magn1*Amplifier,'r','linewidth',2);
hold on;



NFFT = 2^nextpow2(length(error)); % Next power of 2 from length of y
F_error = fft(error,NFFT)/length(error);
f_error = Fs/2*linspace(0,1,NFFT/2);
semilogx(f0,magn,'b','linewidth',2);hold on
%semilogx(f_error,-2*abs(F_error(1:NFFT/2)),'r');
hold on
F_error1=medfilt1(F_error(1:NFFT/2),5);
%semilogx(f_error,-2*abs(F_error1),'k');
xlabel('\bf Frequency/Hz','fontsize',24)
ylabel('\bf Amplitude/mv','fontsize',24)
set(gca,'LineWidth',2);
set(gca,'FontSize',20);
grid;
%xlim([min(f0) max(f0)]);
%ylim([0 max(magn)])
npc_signal=data0;
npc_signal(2:end,1)=X3_1;
save NPC_signal.dat npc_signal -ascii
col_num2=col_num1;