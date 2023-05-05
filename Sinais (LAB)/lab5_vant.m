%% LAB 5 - VANT
% Delta(t) = Mo + Ma(1-(1-e^(-0.1(t-T)))u(t)
Delta = 0.01;  % Delta t 
t =0:Delta:10;   % intervalo de tempo para o calculo 
n= length(t);    % numero de amostras

theta =@(t) pi*sin(t);
u =@(t) 1.*(t>0) + 0.5.*(t==0);
z1 = zeros(n); % cria um vetor de dados z com duas linhas o mesmo tamanho de t e preenche com zeros, isso aloca espaco na memoria. 
z2 = zeros(n);
z1p = zeros(n);
z2p = zeros(n);

z1(1) = 0; % z1 = y(t)
z2(1) = 0; % z2 = yp(t)
mo = 2;
b = 1;
ma = 0.5;
fp = 5;
T = 3;
m =@(t) mo + ma*(1-(1-exp(-0.1*(t-T))))*u(t);

for i=2:n
    z2p(i-1) =  (-b*z2(i-1)+fp*sin(theta(t(i-1))))/m(t(i-1));
    z1p(i-1) = z2(i-1);
    z1(i) = z1(i-1) + T*z1p(i-1);
    z2(i) = z2(i-1) + T*z2p(i-1);
end

plot(t,z1);
figure(2);
plot(t,z2);