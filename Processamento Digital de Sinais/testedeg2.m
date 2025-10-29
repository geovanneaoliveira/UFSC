t = (0:0.1:2)

% Define the unit step function using heaviside
u_t = heaviside(t);

plot(t, u_t)