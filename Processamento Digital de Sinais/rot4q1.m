dev = daqlist("ni").DeviceI;
dqi = daq("ni"); %criação do objeto
dqi.Rate = 1000; %frequência de amostrage
inCh = addinput(dqi,dev,0,"Voltage"); %adiciona a entrada AI0 no objeto dqi
inCh.TerminalConfig = "SingleEnded"; %configura o barramento no modo RSE

while 1 
    
end