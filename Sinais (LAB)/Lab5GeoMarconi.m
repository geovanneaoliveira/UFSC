Delta = 0.01;
a = 3;
b = 5;
Z = 2;
R = 5;
A = 3;
t = 0:Delta:10;
n = length(t);
yp = zeros(n,1)
y = zeros(n);
x1 = @(t) heaviside(t);
x2 = @(t) cos(t);
x3 = @(t) a*x1(t) + b*x2(t);
x4 = @(t) x1(t-Z);
yp = zeros(2,n);

for i=2:n
   yp(i-1) = (-1/R*A)*y(i-1)+(1/A)*x1(t(i-1));
   y(i) = y(i-1) + Delta*yp(i-1);
end
plot(t,x4(t));


