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

x1h(1) = 0;
x2h(1) = 0;

for k = 1:np
  m11h(k) = x2h(k);
  m12h(k) = -x1h(k) -2*x2h(k) + u(k);

  m21h(k) = x2h(k)+dt*m12h(k);
  m22h(k) = -(x1h(k)+dt*m11h(k)) - 2*(x2h(k)+dt*m12h(k)) + u(dt*(k+0.5));

  x1h(k+1) = x1h(k) + dt*[0.5 * m21h(k) + 0.5 * m11h(k)];
  x2h(k+1) = x2h(k) + dt*[0.5 * m22h(k) + 0.5 * m12h(k)];
end
plot(t,x1h)
hold on
plot(t,x2h)
legend('x1 - heun','x2 - heun');




