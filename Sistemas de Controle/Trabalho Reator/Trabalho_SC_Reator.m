%% Parte 1
clc
clear
close all

k1 = 6.01;
k2 = 0.8433;
k3 = 0.1123;

Caf0 = 5.1;
FV0 = 1;

[U,Caf] = meshgrid(0:0.1:10,4:0.1:6);

Ca = (-(k1+U)+sqrt((k1 + U).^2+4*k3*Caf.*U))/2*k3;
Cb = (k1./(k2 + U)).*Ca;

close all


surf(U,Caf,Ca);
title('Gráfico da variação de Ca(t) em função de u(t) e Caf')
figure
surf(U,Caf,Cb);
title('Gráfico da variação de Cb(t) em função de u(t) e Caf')

%% Sistema não linear

clc
clear 
close all

k1=6.01;
k2=0.8433;
k3=0.1123;
Caf=0.1;
u=0.1;

Delta = 0.01;
t =0:Delta:40;
n=length(t);
Ca = zeros(n);
Ca(1) = 0;
DCa = zeros(n);
for i=2:n
    if i==(n-1)/2
        Caf=Caf+0.1;
        u=u+0.1;
    end
    DCa(i-1) = -k1*Ca(i-1)-k3*Ca(i-1)^2+Caf*u-Ca(i-1)*u;
    Ca(i) = Ca(i-1) + Delta*DCa(i-1);
end

Cb = zeros(n);
Cb(1) = 0;
DCb = zeros(n);
for i=2:n
    if i==(n-1)/2
        Caf=Caf+0.1;
        u=u+0.1;
    end
    DCb(i-1) = k1*Ca(i-1)-k2*Cb(i-1)-Cb(i-1)*u;
    Cb(i) = Cb(i-1) + Delta*DCb(i-1);
end

close all
subplot(2,1,1)
plot(t,Ca)
subplot(2,1,2)
plot(t,Cb)
stop()
%% Sistema Linear 

clc
clear
close all

k1=6.01;
k2=0.8433;
k3=0.1123;
Caf=0.1;
u=0.1;

Delta = 0.01;
t =0:Delta:40;
n=length(t);
Ca = zeros(n);
Ca(1) = 0;
DCa = zeros(n);
for i=2:n
    DCa(i-1) = -7.1715*Ca(i-1)+4.3808*u+Caf;
    Ca(i) = Ca(i-1) + Delta*DCa(i-1);
end

Cb = zeros(n);
Cb(1) = 0;
DCb = zeros(n);
for i=2:n
    DCb(i-1) = 6.01*Ca(i-1)-1.8433*Cb(i-1)-2.345*u;
    Cb(i) = Cb(i-1) + Delta*DCb(i-1);
end

close all
subplot(2,1,1)
plot(t,Ca)
subplot(2,1,2)
plot(t,Cb)

stop()
%% Discretizar
clc
clear
close all
s = tf("s");
C = (1.851593965*s + 3.549490385)/(s)
Ts = 0.08;
Cz = c2d(C, Ts, 'zoh')
%% Controle no discreto

clc
clear
close all

ts=0.08;
t=0:ts:20;
n=length(t);
U = zeros(n);
E = zeros(n);
CAF = zeros(n);
R=2.4;
Manual=1;

k1=6.01;
k2=0.8433;
k3=0.1123;
Caf=0;
u=0;

Ca = zeros(n);
Ca(1) = 0;
DCa = zeros(n);
Cb = zeros(n);
Cb(1) = 0;
DCb = zeros(n);

for i=2:n
    E(i)=R-Cb(i-1);
    if Manual
        CAF(i)=CAF(i-1)+0.08;
        if CAF(i)>5.1
            CAF(i)=5.1;
        end
        Caf=CAF(i);
        U(i)=U(i-1)+0.08;
        if U(i)>1
            U(i)=1;
        end
        u=U(i);
        if Cb(i-1)>=2.345
            Manual=0;
        end
    else
        CAF(i)=CAF(i-1);
        Caf=CAF(i);
        U(i)=U(i-1)+1.852*E(i)-1.568*E(i-1);
        if U(i)>10
            U(i)=10;
        end
        if U(i)<0
            U(i)=0;
        end
        u=U(i);
    end
    DCa(i-1) = -k1*Ca(i-1)-k3*Ca(i-1)^2+Caf*u-Ca(i-1)*u;
    Ca(i) = Ca(i-1) + ts*DCa(i-1);
    DCb(i-1) = k1*Ca(i-1)-k2*Cb(i-1)-Cb(i-1)*u;
    Cb(i) = Cb(i-1) + ts*DCb(i-1);
end

close all
plot(t,Cb)


stop
%% DPZ discreto
clc
clear 
close all
s = tf('s');
C = (1.85159*(s + 1.916991766))/(s);
G = (0.28975*(-s + 4.05651))/(s + 1.6334);
Yr = (C*G)/(1 + C*G);
pzmap(Yr)

%% Parte 2 DPZ
clc
clear
close all

s = tf('s');
C = (1.3103*(s + 2.6258))/(s);
G = (-0.2794*(s - 5.5388))/(s + 1.4694);
Yr = (C*G)/(1 + C*G);
pzmap(Yr)

%% Discretizar Parte 2
clc
clear
close all
s = tf("s");
%%C = (17.2083*(s + 1.4694))/((s+1.6433)*(s+6.9433)*(s+5.5388))
%%C = -0.4001;
C = (1.3103*(s + 2.6258))/(s);
Ts = 0.08;
Cz = c2d(C, Ts, 'zoh')
%% Controle no discreto parte 2

clc
clear
close all

ts=0.08;
t=0:ts:20;
n=length(t);
U = zeros(n);
E = zeros(n);
CAF = zeros(n);
R=2.4;
Manual=1;
imanual=100;
k1=6.01;
k2=0.8433;
k3=0.1123;
Caf=0;
u=0;

Ca = zeros(n);
Ca(1) = 0;
DCa = zeros(n);
Cb = zeros(n);
Cb(1) = 0;
DCb = zeros(n);

for i=2:n
    E(i)=R-Cb(i-1);
    if Manual
        CAF(i)=CAF(i-1)+0.08;
        if CAF(i)>5.1
            CAF(i)=5.1;
        end
        Caf=CAF(i);
        U(i)=U(i-1)+0.08;
        if U(i)>1
            U(i)=1;
        end
        u=U(i);
        if Cb(i-1)>=2.345
            Manual=0;
        end
    else
        CAF(i)=CAF(i-1);
        Caf=CAF(i);
        U(i)=U(i-1)+1.31*E(i)-1.035*E(i-1);
        if U(i)>10
            U(i)=10;
        end
        if U(i)<0
            U(i)=0;
        end
        u= U(i) - 0.4001*(CAF(i)-CAF(imanual));
    end
    DCa(i-1) = -k1*Ca(i-1)-k3*Ca(i-1)^2+Caf*u-Ca(i-1)*u;
    Ca(i) = Ca(i-1) + ts*DCa(i-1);
    DCb(i-1) = k1*Ca(i-1)-k2*Cb(i-1)-Cb(i-1)*u;
    Cb(i) = Cb(i-1) + ts*DCb(i-1);
end

close all
plot(t,Cb)

