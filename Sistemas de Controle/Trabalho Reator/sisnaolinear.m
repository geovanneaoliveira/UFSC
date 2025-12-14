%% Sistema não linear

clc
clear 
close all

k1=6.01;
k2=0.8433;
k3=0.1123;
Caf=0.1;
u=0.1;

Delta = 0.01;
t =0:Delta:40;
n=length(t);
Ca = zeros(n);
Ca(1) = 0;
DCa = zeros(n);
for i=2:n
    if i==(n-1)/2
        Caf=Caf+0.1;
        u=u+0.1;
    end
    DCa(i-1) = -k1*Ca(i-1)-k3*Ca(i-1)^2+Caf*u-Ca(i-1)*u;
    Ca(i) = Ca(i-1) + Delta*DCa(i-1);
end

Cb = zeros(n);
Cb(1) = 0;
DCb = zeros(n);
for i=2:n
    if i==(n-1)/2
        Caf=Caf+0.1;
        u=u+0.1;
    end
    DCb(i-1) = k1*Ca(i-1)-k2*Cb(i-1)-Cb(i-1)*u;
    Cb(i) = Cb(i-1) + Delta*DCb(i-1);
end

close all
subplot(2,1,1)
plot(t,Ca)
subplot(2,1,2)
plot(t,Cb)
