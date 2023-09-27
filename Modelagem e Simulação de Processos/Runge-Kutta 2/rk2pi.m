clear
clc
close all

% Tempo

dt = 1e-3;
tf = 10;
t = [0:dt:tf];
np = tf/dt;

% Entrada

u = @(t) 1 +0*t;

% condicoes iniciais

x1(1) = 0;
x2(1) = 0;

for k = 1:np
  m11(k) = x2(k);
  m12(k) = -x1(k) -2*x2(k) + u(k);

  m21(k) = x2(k)+dt/2*m12(k);
  m22(k) = -(x1(k)+dt/2*m11(k)) - 2*(x2(k)+dt/2*m12(k)) + u(dt*(k+0.5));

  x1(k+1) = x1(k) + dt*m21(k);
  x2(k+1) = x2(k) + dt*m22(k);
end

plot(t,x1)
hold on
plot(t,x2)
legend('x1 - PI','x2 - PI')




