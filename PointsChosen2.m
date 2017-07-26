Index_vec=load('mdfy_point1.dat');
Index_n=find(Index_vec(:,1)==0);
Index_vec(Index_n,:)=[];
Index_vec=round(Index_vec);
Index_vec=sortrows(Index_vec,1);
[r c1]=size(Index_vec);
raw_data=load(Filename);
L1=length(raw_data); 
points_chosen=zeros(L1,4);
boot=1;
for x=1:r
    Index1=Index_vec(x,1):step:Index_vec(x,1)+floor(Index_vec(x,3));
    debris_L=length(Index1);
    points_chosen(boot:boot-1+debris_L,1)=Index1;
    points_chosen(boot:boot-1+debris_L,2)=raw_data(Index1);
    points_chosen(boot:boot-1+debris_L,3)=mean(raw_data(Index1));
    boot=boot+debris_L;
end
PC_n=find(points_chosen(:,1)==0);
points_chosen(PC_n,:)=[];
show_out=points_chosen(:,2)-points_chosen(:,3);
save points_chosen.dat points_chosen -ascii