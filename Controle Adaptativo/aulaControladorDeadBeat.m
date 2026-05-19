ts = 0.1

Gs = tf([0.8],[0.95 1])

Gz = c2d(Gs, 0.1, 'zoh')

% atraso da planta

d = 0.4/ts

Gz = Gz * z^-d