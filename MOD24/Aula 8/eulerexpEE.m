clc
close all
clear all

A = [-1 2; -3 -5];
B = [1;1];
C = [1 1];
D = [0];

x1o = 0;
x2o = 0;

dt = 0.01;
t = 0:dt:5;
np = length(t);
u = ones(1,np);

x1(1,1) = x1o;
x2(1,1) = x2o;

for k=1:np-1
    x1(1,k+1) = x1(1,k) + dt * (A(1,1) * x1(k) + A(1,2) * x2(1,k) + u(k));
    x2(1,k+1) = x2(1,k) + dt * (A(2,1) * x1(k) + A(2,2) * x2(1,k) + u(k));
end

stem(t,x1)
hold on
stem(t,x2)
legend("x1","x2")

yE = x1+x2;
sys = ss(A,B,C,D)
[y,t,x_lsim] = lsim(sys,u,t,[x1o; x2o;]);
figure
plot(t,yE)
hold on
plot(t,y)