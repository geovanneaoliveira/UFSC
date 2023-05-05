%% Definicoes inicias (nao e obrigatorio - serve para formatacao )

set(0, 'DefaultLineLineWidth', 3); % muda o padrao espessura da linhas do graficos
set(0,'defaultAxesFontSize',30)    % muda o padrao tamanho de fonte de escrita nos graficos
set(0,'DefaultAxesXGrid','on')     % torna a grade em x padrao
set(0,'DefaultAxesYGrid','on')     % torna a grade em y padrao 

close all
% coeficientes
%a = [1 1 -2]; % 
%b = [0 1 -1];

a = [1  8 29 52];
b = [ 0 0 0 100];

% Os proximos parametros devem escolhidos pelo usuario de acordo com a
% carateristica de comportamento observado do sistemas
T = [0 10]; % tempo de simulacao [tinicial tfinal] 
h = 0.001;   % passo da simulacao 

y0 = [0; 0; 0]; % condicao inicial da simulacao

% Entrada
k = 1;
x =@(t) k*heaviside(t) ;
%x =@(t) cos(2*t);

% Sistema
[t,y]=sistemafisicoreal(x,a,b,T,h,y0);




figure
subplot(2,1,1)
plot(t,y);
xlabel('$t$','interpreter','latex')
ylabel('$y(t)$','interpreter','latex')

subplot(2,1,2)
plot(t,x(t));
xlabel('$t$','interpreter','latex')
ylabel('$x(t)$','interpreter','latex')


