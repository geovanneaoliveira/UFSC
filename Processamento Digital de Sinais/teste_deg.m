t = (0:0.01:2)';

impulse = t==0;
unitstep = t>=1;
unistep = unistep 3;
plot(t,[impulse unitstep])
