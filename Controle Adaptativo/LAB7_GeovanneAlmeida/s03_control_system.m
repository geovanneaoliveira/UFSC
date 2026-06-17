%% ETAPA 3 - Controle com Dahlin Tradicional

% Lista portas disponoveis
portas = serialportlist();

fprintf('Portas disponiveis:\n');
for k = 1:numel(portas)
  fprintf('%d) %s\n', k, portas{k});
end

fprintf('\n');
p = input('Porta desejada: ');
fprintf('\n');

s = serial(portas{p});

% limpa buffers de transmissao e recepcao
srl_flush(s);
pause(1);

% Cria figura e subplots
figure('units', 'centimeters', 'position', [3 1.5 25 13]);
axes1(1) = subplot(2,1,1); box on; grid on; xlabel('tempo (s)');
axes2(1) = line(axes1(1),"xdata",tempo,"ydata",nan(1,numel(tempo)));
axes2(2) = line(axes1(1),"xdata",tempo,"ydata",nan(1,numel(tempo)));
legend(axes1(1),'entrada','saida');

axes1(2) = subplot(2,1,2); box on; grid on; xlabel('tempo (s)');
axes2(3) = line(axes1(2),"xdata",tempo,"ydata",nan(1,numel(tempo)));
axes2(4) = line(axes1(2),"xdata",tempo,"ydata",nan(1,numel(tempo)));
legend(axes1(2),'sinal de controle', 'sinal de erro');

linkaxes([axes1(1), axes1(2)], "x");

% Sistema de controle
y = zeros(N,1);
e = zeros(N,1);
u = zeros(N,1);

% Comando para iniciar ensaio
init_command = uint8([0, 1, 0, 0]);
fwrite(s, init_command, 'uint8');

for k = 3:N

    % Espera ate que o primeiro resultado esteja disponivel
    while(get(s,'BytesAvailable')<6); end;

    rx_buffer = uint8(fread(s,6))';

    % decodifica os dados recebidos
    y(k) = double(typecast(rx_buffer(1:2),'uint16'))*5/1023;
    Dt = double(typecast(rx_buffer(3:4),'uint16'))*4/(1e3);

    % --------------------------------------------------------------------------
    % ADICIONE O SEU CODIGO AQUI
    e(k) = r(k) - y(k);


    u(k) = r(k);
    % --------------------------------------------------------------------------

    duty_cycle = uint16(double(u(k))/5 * PWM_RESOLUTION);

    % retorna sinal de controle atualizado
    tx_buffer = uint8([0, 2, typecast(duty_cycle,'uint8')]);
    fwrite(s, tx_buffer, 'uint8');

    % apresenta informacoes na tela
    fprintf('k = %3d\t y(%3d) = %4.2f\tDuty Cycle = %4d\ttempo = %2.0f ms\t(%1d)\n',...
        k, k, y(k), duty_cycle, Dt, Dt < 1e3/fs);

    set(axes2(1), "ydata", r(1:k-1), 'linestyle', '-', 'marker', 'none');
    set(axes2(2), "ydata", y(1:k), 'linestyle', '-', 'marker', 'none', 'color', [0.4 0.4 1]);
    drawnow;

    set(axes2(3), "ydata", u(1:k), 'linestyle', '-', 'marker', 'none');
    set(axes2(4), "ydata", e(1:k), 'linestyle', '-', 'marker', 'none', 'color', [0.4 0.4 1]);
    drawnow;
end

% Envia comando para finalizar o ensaio
finish_command = uint8([0, 3, 0, 0]);
fwrite(s, finish_command, 'uint8');

fclose(s);

save -mat7-binary 'ensaio_lab6_atividade4a.mat' 'r' 'y' 'e' 'u' 'fs'


