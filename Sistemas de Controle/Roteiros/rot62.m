
G = tf([0.07581],[1 0.07581]);
%tempo de assentamento 2x mais rápido
t5 = 19.785;
%pico máximo de 15
Mp = 0.15;
% Cálculo de Xi
xi = sqrt(1/(((pi/log(Mp))^2) +1))
Wn = 3/(xi*t5);
pd1 = -xi*Wn
pd2 = Wn*sqrt(1 - xi^2)
pd = pd1 + pd2*i;
pd_conjugado = conj(pd)
th1 = atan2d(pd2,(pd1))
th2 = atan2d(pd2,(pd1+0.07581))
Nc = -180+th1+th2
z = -pd1 + pd2/(tand(Nc))
Klrm = (pd*(pd + 0.07581))/(pd + z)
Klr = abs(Klrm)
K = Klr/0.07581
C = tf([K K*z],[1 0])
H = feedback(C * G, 1);
figure;
rlocus(H);
title('Lugar das Raizes');
figure;
pzmap(H);
title('Diagrama de Polos e Zeros');