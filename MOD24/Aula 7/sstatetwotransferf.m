clear
close all
A = [-1 -2; 3 -4];
B = [1; 5;];
C = [1 5;];
D = [];

sys = ss(A,B,C,D)

[num,den] = ss2tf(sys)
FT1 = tf(num,den)

#[A2,B2,C2,D2] = tf2ss(FT1)
#sys2 = ss(A2,B2,C2,D2)
