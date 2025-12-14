%% Controle no discreto

clc
clear
close all

ts=0.08;
t=0:ts:20;
n=length(t);
U = zeros(n);
E = zeros(n);
CAF = zeros(n);
R=2.4;
Manual=1;

k1=6.01;
k2=0.8433;
k3=0.1123;
Caf=0;
u=0;

Ca = zeros(n);
Ca(1) = 0;
DCa = zeros(n);
Cb = zeros(n);
Cb(1) = 0;
DCb = zeros(n);

for i=2:n
    E(i)=R-Cb(i-1);
    if Manual
        CAF(i)=CAF(i-1)+0.08;
        if CAF(i)>5.1
            CAF(i)=5.1;
        end
        Caf=CAF(i);
        U(i)=U(i-1)+0.08;
        if U(i)>1
            U(i)=1;
        end
        u=U(i);
        if Cb(i-1)>=2.345
            Manual=0;
        end
    else
        CAF(i)=CAF(i-1);
        Caf=CAF(i);
        U(i)=U(i-1)+1.852*E(i)-1.568*E(i-1);
        if U(i)>10
            U(i)=10;
        end
        if U(i)<0
            U(i)=0;
        end
        u=U(i);
    end
    DCa(i-1) = -k1*Ca(i-1)-k3*Ca(i-1)^2+Caf*u-Ca(i-1)*u;
    Ca(i) = Ca(i-1) + ts*DCa(i-1);
    DCb(i-1) = k1*Ca(i-1)-k2*Cb(i-1)-Cb(i-1)*u;
    Cb(i) = Cb(i-1) + ts*DCb(i-1);
end

close all
plot(t,Cb)