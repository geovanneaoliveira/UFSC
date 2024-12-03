M = 1;
K = 2;
B = 3;

num = [1 0];
den = [M B K];

FT = tf(num,den);

#Resn

t = 0:1e-3:30;
u = 1 + sin(t);

[y] = lsim(FT,u,t);

ya = -0.6*exp(-2*t)+0.5*exp(-t)+2*0.1581*cos(t-1.2490);

plot(t,y,'linewidth',2)
hold on
plot(t,ya,'r--','linewidth',2)
grid
legend('lsim','analitica')

# FRAÇÕES PARCIAIS

s = tf('s')

G = (s/(M*s^2 + B*s + K))*((s^2 + s + 1)/(s^3 + s))

[numG,denG] = tfdata(G,'v') # extrai polinomio da tf

[R, P, K, E] = residue(numG,denG)


