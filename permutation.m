function vec_out=permutation(data)
% This file is developed by Yang Yang.
[r c]=size(data);
if r==1
    data=data';
end
L=length(data);
vec=data;
Nums=factor(L);
m=length(find(Nums==2));
order=Nums(m+1:end);
order=fliplr(order);
num=L/prod(order);
mm=floor(m/4);

for z=1:length(order)    
    b=sparse(eye(num/2^(4*mm)));
    for u=1:mm
        b=kron(b,sparse(eye(2^4)));
    end  
    if z~=length(order)
    b=kron(b,sparse(eye(prod(order(z+1:end)))));     
    mat1_0=kron(b,sparse([1 zeros(1,order(z)-1)]));
    else
    mat1_0=kron(b,sparse([1 zeros(1,order(z)-1)]));
    end
    
    mat1=mat1_0;
    for w=1:order(z)-1 
        mat1_1=[zeros(num*prod(order(z+1:end)),1) mat1_0];
        mat1_1(:,end)=[];
        mat1=[mat1;mat1_1];
        mat1_0=mat1_1;
    end
    
    if z~=1
       permu=kron(eye(prod(order(1:z-1))),mat1);
    else
       permu=mat1;
    end
    vec=permu*vec;
end
vec_out=full(vec);

