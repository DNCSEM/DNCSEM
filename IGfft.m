function vec_out=IGfft(data)
% This file is developed by Yang Yang.
L=length(data);
data(L/2+2:end)=flipud(conj(data(2:L/2)));
data(L/2+1)=real(data(L/2+1));
vec=permutation(data);
new_vec=zeros(length(data),1);
Nums=factor(L);
m=length(find(Nums==2));
mm=floor(m/4);
order=Nums(m+1:end);
num=L/prod(order);

for y=1:L/num
    compo=ifft(vec((y-1)*num+1:y*num),num)*num;
    new_vec((y-1)*num+1:y*num)=compo;
end
vec_out=new_vec;

format long
i=(-1)^0.5;


for z=1:length(order)
    base=prod(Nums(1:m+z));
    base2=prod(Nums(1:m+z-1));
    w=exp(2*pi*i/base);
    BigMat=sparse(base,base);
    b=kron(sparse(eye(num/2^(4*mm))),eye(1));
    for u=1:mm
        b=kron(b,sparse(eye(2^4)));
    end  
    
        if z~=1
            for v=1:z-1
              b=kron(b,sparse(eye(order(v))));
            end
        end
    
    for x=1:order(z)
        for y=1:prod(Nums(1:m+z-1))
            b(y,y)=w^(y-1);
        end
    power=0:Nums(m+z)-1;
    c=exp(-2*pi*i*(x-1)/order(z)).^power;
    BigMat(:,1+(x-1)*base2:x*base2)=kron(c',b^(x-1));
    end
a=BigMat;
if z~=length(order)
out=kron(sparse(eye(prod(order(z+1:end)))),a);
else
out=a;
end
vec_out=sparse(out)*vec_out;
end
vec_out=vec_out*1;

    