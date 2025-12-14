%% Sistema Linear 

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
    DCa(i-1) = -7.1715*Ca(i-1)+4.3808*u+Caf;
    Ca(i) = Ca(i-1) + Delta*DCa(i-1);
end

Cb = zeros(n);
Cb(1) = 0;
DCb = zeros(n);
for i=2:n
    DCb(i-1) = 6.01*Ca(i-1)-1.8433*Cb(i-1)-2.345*u;
    Cb(i) = Cb(i-1) + Delta*DCb(i-1);
end

close all
subplot(2,1,1)
plot(t,Ca)
subplot(2,1,2)
plot(t,Cb)
