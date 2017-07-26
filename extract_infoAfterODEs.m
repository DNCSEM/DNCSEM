y=magn1*Amplifier;
y(Fre_index)=(y(Fre_index-1)+y(Fre_index+1))/2;
wavedec_num=1;
sup_num=1;
ratio1=0.09;
if wavedec_num==0
    a5=mean(y);
else
    [d,a]=wavedec(y,wavedec_num,'db30');
    a5=wrcoef('a',d,a,'db30',wavedec_num);
end

analytic=hilbert(y-a5); % get the hilbert analytic signal
baoluo=a5+abs(analytic); % get hilbert analytic envelope

data_ForEnvelop=abs(analytic); % make addtional peak envelope
index=1:length(analytic);
if sup_num==0 
    y_out3=data_ForEnvelop;
else
        for sup_rot=1:sup_num  %peaks envelope to improve the result
            out_data=zeros(length(data_ForEnvelop),2);
            n=1;
            if data_ForEnvelop(1)>data_ForEnvelop(2)
                 out_data(n,:)=[1,data_ForEnvelop(1)]; 
                 n=n+1;
            end
            for i=2:length(data_ForEnvelop)-1
                if data_ForEnvelop(i)>data_ForEnvelop(i-1) && data_ForEnvelop(i)>data_ForEnvelop(i+1)
                    out_data(n,:)=[i,data_ForEnvelop(i)];
                    n=n+1;
                end
            end
            if data_ForEnvelop(end)>data_ForEnvelop(end-1)
                 out_data(n,:)=[i+1,data_ForEnvelop(end)]; 
            end
            [r0,c0]=find(out_data(:,1)==0);
            out_data(r0:end,:)=[];
            data_ForEnvelop=interp1(out_data(:,1),out_data(:,2),index','cubic');
        end
        %y_out=spline(out_data(:,1),out_data(:,2),index');
        y_out3=interp1(out_data(:,1),out_data(:,2),index','cubic');
end
baoluo1=y_out3+a5; % get a peak envelop after Hilbert envelope
figure
semilogx(f0,-y);hold on;semilogx(f0,-baoluo1,'r');
hold on
semilogx(f0,magn,'b','linewidth',2);
vec_test=data-X3;
vec_1=vec_test;
vec_1(col_num)=0;
Y_vec = Gfft(vec_1);
L=length(Y_vec);
magn_vec=2*abs(Y_vec(1:L/2+1));
magn_vec(Fre_index)=0;
%semilogx(f0,magn_vec,'r','linewidth',2);

xlabel('\bf Frequency/Hz','fontsize',24)
ylabel('\bf Amplitude/mv','fontsize',24)
set(gca,'LineWidth',2);
set(gca,'FontSize',20);grid

ratio=baoluo1(Fre_index)./magn(Fre_index);
[r_extract,c_extract]=find(ratio<ratio1);
magn2=magn(Fre_index);

figure
semilogx(f(Fre_index),ratio,'linewidth',2);grid;ylim([0 0.3]);
xlabel('\bf Frequency/Hz','fontsize',24)
ylabel('\bf Ratio','fontsize',24)
set(gca,'LineWidth',2);
set(gca,'FontSize',20);

ProcessedData=[fre_mat(1,r_extract)',magn2(r_extract),real(Y_vec(r_extract)),imag(Y_vec(r_extract)),ratio(r_extract)];
save([Filename(1:end-4),'_',num2str(ratio1),'_DenoisingProcessed.dat'],'ProcessedData','-ascii');
