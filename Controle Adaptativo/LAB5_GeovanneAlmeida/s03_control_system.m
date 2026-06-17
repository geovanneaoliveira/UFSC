close all;

%% ETAPA 3 - Controle

% Lista portas disponiveis
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

axes2(7) = line(axes1(2),"xdata",tempo,"ydata",nan(1,numel(tempo)));
axes2(8) = line(axes1(2),"xdata",tempo,"ydata",nan(1,numel(tempo)));

legend(axes1(2),'b_1','b_2', 'a_1', 'a_2');

##axes1(3) = subplot(2,2,3); box on; grid on; xlabel('tempo (s)');
##axes2(5) = line(axes1(3),"xdata",tempo,"ydata",nan(1,numel(tempo)));
##axes2(6) = line(axes1(3),"xdata",tempo,"ydata",nan(1,numel(tempo)));
##legend(axes1(3),'sinal de controle', 'sinal de erro');

##linkaxes([axes1(1), axes1(2), axes1(3)], "x");
linkaxes([axes1(1), axes1(2)], "x");

% Sistema de controle
y = zeros(N,1);
e = zeros(N,1);
u = zeros(N,1);

% Parametros do estimador MQR
rho = 500;
P = rho*eye(4);
v = zeros(4,1);
theta = zeros(4,N);
lambda = 0.95;

% Comando para iniciar ensaio
init_command = uint8([0, 1, 0, 0]);
fwrite(s, init_command, 'uint8');

for k = 4:N

    % Espera ate que o primeiro resultado esteja disponivel
    while(get(s,'BytesAvailable')<6); end;

    rx_buffer = uint8(fread(s,6))';

    % decodifica os dados recebidos
    y(k) = double(typecast(rx_buffer(1:2),'uint16'))*5/1023;
    Dt = double(typecast(rx_buffer(3:4),'uint16'))*4/(1e3);

    % --------------------------------------------------------------------------
    % ESTIMADOR MQR
    % Atualiza vetor u
    v = [u(k-1); u(k-2); -y(k-1); -y(k-2)];

    % Vetor de ganho h
    h = P*v/ (lambda + (v'*P*v));

    % Atualizacao dos parametros
    theta(:,k) = theta(:,k-1) + h*(y(k) - v.'*theta(:,k-1));

    % Atualizacao da matriz P
    P = (1/lambda) * (eye(4) - h*v')*P;

    % erro
    %e = (y - v.'*theta(:,k-1));

    % sinal de controle (malha aberta)
    u(k) = r(k);
    % --------------------------------------------------------------------------

    duty_cycle = uint16(double(u(k))/5 * PWM_RESOLUTION);

    % retorna sinal de controle atualizado
    tx_buffer = uint8([0, 2, typecast(duty_cycle,'uint8')]);
    fwrite(s, tx_buffer, 'uint8');

    % apresenta informacoes na tela
    fprintf('k = %3d\t y(%3d) = %4.2f\tDuty Cycle = %4d\ttempo = %2.0f ms\t(%1d)\n',...
        k, k, y(k), duty_cycle, Dt, Dt < 1e3/fs);

    set(axes2(3),"ydata",theta(1,1:k), 'linestyle', '-', 'marker', 'none');
    set(axes2(4),"ydata",theta(2,1:k), 'linestyle', '-', 'marker', 'none', 'color', [0.4 0.4 1]);
    set(axes2(7),"ydata",theta(3,1:k), 'linestyle', '-', 'marker', 'none');
    set(axes2(8),"ydata",theta(4,1:k), 'linestyle', '-', 'marker', 'none', 'color', [0.4 0.4 1]);

    set(axes2(1), "ydata", r(1:k), 'linestyle', '-', 'marker', 'none');
    set(axes2(2), "ydata", y(1:k), 'linestyle', '-', 'marker', 'none', 'color', [0.4 0.4 1]);
    drawnow;

##    set(axes2(5), "ydata", u(1:k), 'linestyle', '-', 'marker', 'none');
##    set(axes2(6), "ydata", e(1:k), 'linestyle', '-', 'marker', 'none', 'color', [0.4 0.4 1]);
    drawnow;
end

% Envia comando para finalizar o ensaio
finish_command = uint8([0, 3, 0, 0]);
fwrite(s, finish_command, 'uint8');

fclose(s);

save -mat7-binary 'ensaio_lab5_rls.mat' 'u' 'y' 'fs' 'theta' 'lambda' 'rho'


