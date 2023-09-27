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
x1h(1) = 0;
x2h(1) = 0;

for k = 1:np
  m11(k) = x2(k);
  m12(k) = -x1(k) -2*x2(k) + u(k);

  m21(k) = x2(k)+dt/2*m12(k);
  m22(k) = -(x1(k)+dt/2*m11(k)) - 2*(x2(k)+dt/2*m12(k)) + u(dt*(k+0.5));

  x1(k+1) = x1(k) + dt*m21(k);
  x2(k+1) = x2(k) + dt*m22(k);

  m11h(k) = x2h(k);
  m12h(k) = -x1h(k) -2*x2h(k) + u(k);

  m21h(k) = x2h(k)+dt*m12h(k);
  m22h(k) = -(x1h(k)+dt*m11h(k)) - 2*(x2h(k)+dt*m12h(k)) + u(dt*(k+0.5));

  x1h(k+1) = x1h(k) + dt*[0.5 * m21h(k) + 0.5 * m11h(k)];
  x2h(k+1) = x2h(k) + dt*[0.5 * m22h(k) + 0.5 * m12h(k)];
end
%% LSIM

A = [0 1; -1 -2;];
B = [0; 1;];
C = [1 0];
D = 0;

sys = ss(A,B,C,D);

[y,t,x_lsim] = lsim(sys,u(t),t,[0; 0;]);

plot(t,x1)
hold on
plot(t,x2)
plot(t,x_lsim,'--')
plot(t,x1h)
plot(t,x2h)
legend('x1 - PI','x2 - PI', 'x1 - LSIM', 'x2 - LSIM','x1 - Heun', 'x2 - Heun')




