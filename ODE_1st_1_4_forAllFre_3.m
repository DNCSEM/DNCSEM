 % including trade-off parameters of weighted least squares
%filename='rawdata_HiFs.dat';
[Filename,Pathname,FilterIndex]=uigetfile({'*.dat;*.txt','File format(*.dat,*.txt)';...
    '*.*','All Files (*.*)'}); 
if ~FilterIndex
    return
end
%filename='raw_data1_1.dat';
chosen_col=3;
accuracy=0;
step=1;
I_sup=5;

iRatio=0.1;
PointsChosen2; 
%Fs=256;
%Fs=85.333333333333329;
%Fs=6.826666666666666e+02; %for Raw190
%Fs=87.381333333333330; %bgp  500/(300000/524288) 
   %Fs=65.536000000000001;
   %Fs=1.310720000000000e+02;
   %Fs=500;
%Fs=64;
%Fs=2^16;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_0=load(Filename);
data=data_0(2:end,1);
%data(round(length(data)/2)+5000:end)=data(round(length(data)/2)+5000:end)+8;
L=length(data);
Fs=data_0(1,1);
f = Fs/2*linspace(0,1,L/2+1);

Y = Gfft(data);
Y_ori=Y;
%fre=1*2.^[-6:0];fre=kron([1 3 5 7 9],fre);fre=sort(fre,2);
%fre=fre*main_fre;
[Filename_fre,Pathname,FilterIndex]=uigetfile({'*.dat;*.txt','File format(*.dat,*.txt)';...
    '*.*','All Files (*.*)'}); 
fre_mat=load(Filename_fre);
if mod(fre_mat(2,1),fre_mat(1,1))==0
fre_mat=fre_mat';
end
if f(end)<fre_mat(1,end)
    f_r=f(end)-fre_mat(1,:);
    [fr_c,fr_d]=find(f_r<0);
    fre_mat(:,fr_d:end)=[];
end
[fr_c1,fr_d1]=find(fre_mat(2,:)>I_sup);
fre_mat1=fre_mat(:,fr_d1);
fre=fre_mat1(1,:);
%fre=getFre(1/2^6,40);
%fre=kron([1:2:40/0.05],0.05);
%fre=[1 2 4 8 16 32 64];
%fre=[0.25,0.75];
%fre=[fre f(24)];
%fre=1:2:400;fre=fre*8;
Fre_index=round(fre/(Fs/L))+1;

Y1=Y;
kk=Fre_index-1;
Y1(kk+1)=0;
Y1(L-(kk-1))=0;
Y5=Y;
Y5(kk+1)=2*(Y5(kk)+Y5(kk+2))/2;
Y5(L-(kk-1))=2*(Y5(L-(kk-2))+Y5(L-(kk)))/2;


X5=real(IGfft(Y5));
%Y1(24)=0;
%Y1(L-(23-1))=0;

X1=real(IGfft(Y1));
i=(-1)^0.5;
w=exp(2*pi*i/L);
m=points_chosen(:,1)-1;
bb=Fre_index;
MatA=zeros(length(m),length(fre)*2);
MatAC=zeros(length(m),length(fre));

for num2=1:length(fre) 
    k=bb(num2)-1;
    ww=w.^(k*m);
    MatA(:,2*num2-1)=real(ww');
    MatA(:,2*num2)=imag(ww');
    MatAC(:,num2)=ww';
end

MatAC_inverse=inv(MatAC'*MatAC);
IF=MatAC_inverse(1,1);
[vv2,dd2]=eig(MatAC_inverse);

col_num=m+1;
initial_mean=points_chosen(:,3);
%yM=(X1(col_num)-initial_mean)/2;
yM=(X1(col_num)-initial_mean)/2;

[row1 col1]=size(points_chosen);
shift_vec=zeros(row1+1,1);
shift_vec(2:end)=points_chosen(:,1);
shift_vec(1)=points_chosen(1,1)-step;
shift_vec(end)=[];
pointrow=points_chosen(:,1)-shift_vec;
pr=pointrow;
% create the point list
c=zeros(1,length(pr));
c(1)=1;
n=1;
for xx=1:1:length(pr)-1
  b(xx)=pr(xx)-pr(xx+1);
  if b(xx)~=0
      n=n+1;
     c(n)=xx;
  end
end
c(n+1)=length(pr);
c(n+2:end)=[];
const_mat=zeros(length(m),(accuracy+1)*length(c)/2);
box_num=1;
for u1=1:length(c)/2
    index1=c(2*u1-1):c(2*u1);
    points_chosen(index1,4)=box_num;
    box_num=box_num+1;
    x8=linspace(-1,1,length(index1));
    x8=x8';
    for accur1=0:accuracy
        P=Legendre(accur1,x8);
        const_mat(index1,(accuracy+1)*u1-accur1)=P;
    end
end

balance=length(m)/(length(fre))*iRatio; % trade-off parameters of weighted least squares for Fourier series
balance1=0.00005; % trade-off parameters of weighted least squares for Polynomial


NewMatA=[MatA const_mat];
 % trade-off parameters of weighted least squares
x_nums=size(MatA,2);
poly_nums=size(const_mat,2);
extra0=eye(x_nums);
extra=[eye(x_nums) zeros(x_nums,poly_nums)];
Mat_zeros=zeros(length(m),length(fre)*2);
Mat_zeros1=[Mat_zeros const_mat];
NewMatA1=[NewMatA;balance^0.5*extra;balance1^0.5*Mat_zeros1];
yM1=[yM;balance^0.5*zeros(x_nums,1);balance1^0.5*zeros(length(m),1)];
%yM1=[yM;balance^0.5*0.01*ones(x_nums,1)];
x=NewMatA1\yM1;

Result=zeros(length(fre),1);
Result1=zeros(length(fre),1);
Ori=zeros(length(fre),1);
Y2=Y;
Y3=Y;

for num3=1:length(fre) 
    Result(num3)=Y(bb(num3))+x(2*num3-1)+x(2*num3)*i;
    Result1(num3)=Y(L-bb(num3)+2)+x(2*num3-1)-x(2*num3)*i;
    
    Y2(bb(num3))=Result(num3);
    Y2(L-bb(num3)+2)=Result1(num3);

    Y3(bb(num3))=-x(2*num3-1)-x(2*num3)*i;
    Y3(L-bb(num3)+2)=-x(2*num3-1)+x(2*num3)*i;
    
    Ori(num3)=Y(bb(num3));
end

%X2=real(IGfft(Y2));
X3=real(IGfft(Y3));
save X3.dat X3 -ascii

points_chosen(:,2)=X3(col_num);

points_chosen(:,chosen_col)=points_chosen(:,chosen_col)+2*const_mat*x(end-length(c)/2*(accuracy+1)+1:end);    


L=length(data);
f0=Fs/2*linspace(0,1,L/2+1);
figure(1)
magn1=2*abs(Y(1:L/2+1));
magn_ori=2*abs(Y(1:L/2+1));
semilogx(f0,magn1,'r','linewidth',2);
%loglog(f0,magn1,'r','linewidth',2);
hold on;
Result_out=Y-Y3;
magn=2*abs(Result_out(1:L/2+1));
semilogx(f0,magn,'b','linewidth',2);
%loglog(f0,magn,'b','linewidth',2);
xlabel('\bf Frequency/Hz','fontsize',24)
ylabel('\bf Amplitude/mv','fontsize',24)
set(gca,'LineWidth',2);
set(gca,'FontSize',20);
grid;

%figure(2)
%Result_out=Y-Y3;magn=2*abs(Result_out(1:L/2+1));semilogx(f0,magn,'b','linewidth',2);
%loglog(f0,magn,'b','linewidth',2);
xlabel('\bf Frequency/Hz','fontsize',24)
ylabel('\bf Amplitude/mv','fontsize',24)
set(gca,'LineWidth',2);
set(gca,'FontSize',20);
%grid;

figure(3)
plot(X3(col_num));hold on;
plot(points_chosen(:,chosen_col),'r')
time=1/Fs:1/Fs:L/Fs;
ylim([min(points_chosen(:,2)) max(points_chosen(:,2))]);
col_num1=col_num;
X3_1=X3;
m1=m;

%for z1=1:length(c)/2
  %x_out=X3_1(col_num1)-initial_mean-2*x(end-length(c)/2+z1)*const_mat(:,z1);
%end
x_out=X3_1(col_num1)-points_chosen(:,chosen_col);
%x_out=X3_1(col_num1);
save NPC.dat x_out -ascii

MatA_inverse=NewMatA'*NewMatA;
[vv,dd]=eig(MatA_inverse);
cond_num=dd(end,end)/dd(1,1); % to judge whether the matrix is a ill-conditioned matrix

MatA_inverse1=MatA'*MatA;
[vv1,dd1]=eig(MatA_inverse1);
cond_num1=dd1(end,end)/dd1(1,1); 

MatAC_inverse=inv(MatAC'*MatAC);
IF=MatAC_inverse(1,1);
[vv2,dd2]=eig(MatAC_inverse);

figure(4)
error=X3(col_num)-points_chosen(:,chosen_col);
error_vecor=zeros(length(X3),1);
error_vecor(col_num)=error;
F_error= Gfft(error_vecor);
magn1=2*abs(F_error(1:L/2+1));
Amplifier=length(X3)/length(col_num);
semilogx(f0,-magn1*Amplifier,'r','linewidth',2);
hold on;

NFFT = 2^nextpow2(length(error)); % Next power of 2 from length of y
F_error = fft(error,NFFT)/length(error);
f_error = Fs/2*linspace(0,1,NFFT/2);
semilogx(f0,magn,'b','linewidth',2);hold on
%semilogx(f_error,-2*abs(F_error(1:NFFT/2)),'b');
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
col_num2=col_num;
