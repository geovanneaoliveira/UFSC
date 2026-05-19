clear; close all; clc;

% ganho = 10db

fc = 350 % Hz

av1 = 1;
av2 = 4;

C1 = 1e-9;
C2 = 1e-9;

q1 = 0.522;
q2 = 0.806;

e1 = -2.896 + 0i;
e2 = -1.419 + 1.103i;

mag1 = sqrt(2.896^2 + 0^2);
mag2 = sqrt(1.419^2 + 1.103^2);

p1 = -mag1 *2*pi*fc

sqrr1r2 = 1/(-p1 * 1e-9)

% wc1 = 1/(sqrt(R1*R2*C1*C2))

rp1mrp2 = sqrr1r2/q1

% rp2 = rp1mrp2 - rp1

sq