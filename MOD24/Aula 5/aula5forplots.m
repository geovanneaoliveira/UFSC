clc
clear
close all

x = [0;0]

% Entrada

t = 0:0.1:50
u = @(t) 1;
f = @(t) 10;

dx1 = @(t,x) x(2);

for i=1:4
  switch (i)
    case 1
      B = 3;
      M = 1;
      K = 1;
      plot_title = "SOBREAMORTECIDO";
    case 2
      B = 2;
      M = 1;
      K = 2;
      plot_title = "SUBAMORTECIDO";
    case 3
      B = 2;
      M = 1;
      K = 1;
      plot_title = "CRITICAMENTE AMORTECIDO";
    case 4
      B = 0;
      M = 1;
      K = 1;
      plot_title = "OSCILATÓRIO";
  endswitch

  dx2 = @(t,x) -1/M*(B*x(2) + K*x(1) - u(t));
  dxdt = @(t,x) [dx1(t,x); dx2(t,x)];

  % solucao

  [t,x2] = ode45(dxdt,t,x);

  subplot(2,2,i)
  plot(t,x2)
  title(plot_title)
  grid
  legend('x1','x2')

  disp(plot_title)
  ta = 5*B/2*M
  csi = (B/(2*M)) * sqrt(K/M)

endfor
