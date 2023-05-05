%%% Sistema Fisico real
function [t,y]=sistemafisicoreal(x,a,b,T,h,y0)

N =length(y0);

A = [zeros(N-1,1) eye(N-1)];
for i=1:N
A(N,i) = -a(N+2-i);
end
B = [zeros(N-1,1);1];

C = zeros(1,N);
for i=1:N;
C(1,i) = b(N+2-i) - b(1)*a(N+2-i);
end

D = b(1);

zp =@(t,z) A*z + B*x(t);
yf =@(t,z) C*z+D*x(t);
      
[t,zesn,yesn] = euler(zp,yf,T,h,0*y0);

zp2 =@(t,z) A*z;
C = [1 zeros(1,N-1)];
yf2 =@(t,z) C*z;

[t,z0,y0] = euler(zp2,yf2,T,h,y0);

y = yesn+y0;
end

function [t,z,y] = euler(fnc,out,T,h,z0)  

t = T(1):h:T(2);
z(:,1) = z0;
y(1)=z0(1);

for k = 2:1:length(t)
    z(:,k) =  z(:,k-1) + h*fnc(t(k),z(:,k-1));
    y(k) = out(t(k),z(:,k));
end
z = transpose(z);
end


