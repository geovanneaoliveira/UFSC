t = [0:0.1:50];
f = @(t) t.^2 + 2
plot(t,f(t), 'linewidth', 4)
a = @(t) 5*exp(-3*t)
b = @(t) exp(-10*t)
c = @(t) 2*exp(-0.5*t)
d = @(t) -5*exp(-3*t)
e = @(t) 5*exp(3*t)
f = @(t) (1-exp(-2*t))
g = @(t) (2-exp(-3*t))
h = @(t) (2-2*exp(-3t))
plot()