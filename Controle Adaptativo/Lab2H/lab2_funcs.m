function [K, qsi, wn, L] = lab2_funcs(y, A, fs, method)
    x = numel(y);
    ts = 1/fs;
    tempo = (0:x-1) * ts;
    if(strcmp(method, "Standard"))

        deltaY = y(end) - y(1);
        deltaX = A;

        K = deltaY / deltaX;

        [yp, tp] = max(y);
        tp = (tp - 1)/fs;

        overshoot = (yp- y(end))/y(end)* 100;

        a = log(overshoot/100)^2;
        qsi = sqrt(a/(pi^2+ a));

        wn = pi / (tp * sqrt(1 - qsi^2));

        L = 0;

    end

    if(strcmp(method,"Mollenkamp"))

        deltaY = y(end) - y(1);
        deltaX = A;

        K = deltaY / deltaX;

        y_15_ideal = 0.15 * y(end);

        t_15_inferior = find(y < y_15_ideal);
        t_15_inferior = t_15_inferior(end);
        y_15_inferior = y(t_15_inferior);
        t_15_inferior = t_15_inferior(end) * ts;

        t_15_superior = find(y > y_15_ideal);
        t_15_superior = t_15_superior(1);
        y_15_superior = y(t_15_superior);
        t_15_superior = t_15_superior(1) * ts;

        t_15_interpolado = t_15_inferior + (y_15_ideal - y_15_inferior) * (t_15_superior - t_15_inferior) / (y_15_superior - y_15_inferior);

        y_45_ideal = 0.45 * y(end);

        t_45_inferior = find(y < y_45_ideal);
        t_45_inferior = t_45_inferior(end);
        y_45_inferior = y(t_45_inferior);
        t_45_inferior = t_45_inferior(end) * ts;

        t_45_superior = find(y > y_45_ideal);
        t_45_superior = t_45_superior(1);
        y_45_superior = y(t_45_superior);
        t_45_superior = t_45_superior(1) * ts;

        t_45_interpolado = t_45_inferior + (y_45_ideal - y_45_inferior) * (t_45_superior - t_45_inferior) / (y_45_superior - y_45_inferior);
        

        y_75_ideal = 0.75 * y(end);

        t_75_inferior = find(y < y_75_ideal);
        t_75_inferior = t_75_inferior(end);
        y_75_inferior = y(t_75_inferior);
        t_75_inferior = t_75_inferior(end) * ts;

        t_75_superior = find(y > y_75_ideal);
        t_75_superior = t_75_superior(1);
        y_75_superior = y(t_75_superior);
        t_75_superior = t_75_superior(1) * ts;

        t_75_interpolado = t_75_inferior + (y_75_ideal - y_75_inferior) * (t_75_superior - t_75_inferior) / (y_75_superior - y_75_inferior);
        
        X = (t_45_interpolado - t_15_interpolado) / (t_75_interpolado - t_15_interpolado);

        qsi = (0.0805 - 5.547 * (0.475 - X)^2) / (X - .356);
        if(qsi < 1)
            f2 = .708 * (2.811)^qsi;
        else
            f2 = 2.6*qsi - 0.60;
        end
        
        wn = f2 / (t_75_interpolado - t_15_interpolado);

        f3 = 0.922 * (1.66)^qsi;

        L = t_45_interpolado - f3 / wn;

        
    end
end
