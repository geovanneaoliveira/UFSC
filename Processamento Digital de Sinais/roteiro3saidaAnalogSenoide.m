clear
clc

dev = daqlist("ni").DeviceID;
dqo = daq("ni");
dqo.Rate = 500;
outCh = addoutput(dqo,dev,0,"Voltage");
theta  - linspace(0,2*pi,100);
theta(end) = [];
vout = sin(theta);
// plot(vout);
preload(dqo,vout);
// hz = frequencia de escrita / nro de pontos do periodo
start(dqo, "repeatoutput");

pause();

stop(dqo);
clear("dqo");
