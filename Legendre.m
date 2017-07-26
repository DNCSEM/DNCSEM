function P=Legendre(n,mg)
% This file is developed by Yang Yang.
if (n==0)
P=1;
else 
if (n==1)
P=mg;
elseif (n==2)
P=(3*mg.^2)/2 - 1/2;
elseif (n==3)
P=1/2*(5*mg.^3-3*mg);
elseif (n==4)
P=1/8*(35*mg.^4-30*mg.^2+3);
elseif (n==5)
P=1/8*(63*mg.^5-70*mg.^3+15*mg);
elseif (n==6)
P=1/16*(231*mg.^6-315*mg.^4+105*mg.^2-5);
elseif (n==7)
P=1/16*(429*mg.^7-693*mg.^5+315*mg.^3-35*mg);
else
P=((2*n-1)*mg*Legendre(n-1)-(n-1)*Legendre(n-2))/(n);
end
end