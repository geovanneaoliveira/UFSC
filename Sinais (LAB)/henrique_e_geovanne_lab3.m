%a)
%Delta = 0.01; % Delta t
%t =0:Delta:5; % intervalo de tempo para o calculo
%n=length(t); % numero de amostras
%y = zeros(n, 1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaco na memoria.
%y(1) = 0; % Define a condicao inicial
%Dy = zeros(n, 1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaço na memoria.
% Estrutura recursiva para o calculo da resposta
%for i=2:n
%    Dy(i-1) = -2 * y(i-1) + 2 ;
%    y(i) = y(i-1) + Delta * Dy(i-1);
%end
%plot(t,y)

%b)
%Delta = 0.01; % Delta t
%t =0:Delta:5; % intervalo de tempo para o calculo
%n=length(t); % numero de amostras
%y = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaco na memoria.
%y(1) = 1; % Define a condicao inicial
%Dy = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaço na memoria.
% Estrutura recursiva para o calculo da resposta
%for i=2:n
%    Dy(i-1) = -2 * y(i-1) + 2;
%    y(i) = y(i-1) + Delta * Dy(i-1);
%end
%plot(t,y)

%c-a)
%{
Delta = 0.01; % Delta t
t =0:Delta:5; % intervalo de tempo para o calculo
n=length(t); % numero de amostras
tau = 0.1;
ke = 2;
y = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaco na memoria.
y(1) = 0; % Define a condicao inicial
Dy = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaço na memoria.
% Estrutura recursiva para o calculo da resposta
for i=2:n
    Dy(i-1) = (-1 * y(i-1) + 2*ke)/tau;
    y(i) = y(i-1) + Delta * Dy(i-1);
end
plot(t,y)
%}

%c-b)]
%{
Delta = 0.01; % Delta t
t =0:Delta:5; % intervalo de tempo para o calculo
n=length(t); % numero de amostras
tau = 1;
ke = 2;
y = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaco na memoria.
y(1) = 0; % Define a condicao inicial
Dy = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaço na memoria.
% Estrutura recursiva para o calculo da resposta
for i=2:n
    Dy(i-1) = (-1 * y(i-1) + 2*ke)/tau;
    y(i) = y(i-1) + Delta * Dy(i-1);
end
plot(t,y)
%}

%c-c
%{
c
%}

% d-a)
%{
Delta = 0.01; % Delta t
t =0:Delta:5; % intervalo de tempo para o calculo
n=length(t); % numero de amostras
tau = 1;
ke = 2;
y = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaco na memoria.
y(1) = 0; % Define a condicao inicial
Dy = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaço na memoria.
% Estrutura recursiva para o calculo da resposta
for i=2:n
    Dy(i-1) = (-1 * y(i-1) + 2*ke)/tau;
    y(i) = y(i-1) + Delta * Dy(i-1);
end
plot(t,y)
%}

% d-b)
%{
Delta = 0.01; % Delta t
t =0:Delta:5; % intervalo de tempo para o calculo
n=length(t); % numero de amostras
tau = 1;
ke = 5;
y = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaco na memoria.
y(1) = 0; % Define a condicao inicial
Dy = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaço na memoria.
% Estrutura recursiva para o calculo da resposta
for i=2:n
    Dy(i-1) = (-1 * y(i-1) + 2*ke)/tau;
    y(i) = y(i-1) + Delta * Dy(i-1);
end
plot(t,y)
%}

% d-c)
%{
Delta = 0.01; % Delta t
t =0:Delta:5; % intervalo de tempo para o calculo
n=length(t); % numero de amostras
tau = 1;
ke = 10;
y = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaco na memoria.
y(1) = 0; % Define a condicao inicial
Dy = zeros(n,1); % cria um vetor de dados y com o mesmo tamanho de t e preenche com zeros, isso aloca espaço na memoria.
% Estrutura recursiva para o calculo da resposta
for i=2:n
    Dy(i-1) = (-1 * y(i-1) + 2*ke)/tau;
    y(i) = y(i-1) + Delta * Dy(i-1);
end
plot(t,y)
%}