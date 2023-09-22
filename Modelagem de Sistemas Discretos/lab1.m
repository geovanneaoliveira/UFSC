close all

G_gen = [0 1 1 1 1;
1 0 1 1 1;
1 1 0 1 1;
1 1 1 0 1;
1 1 1 1 0];
G_ciclo = [0 1 0 0 0 1;
1 0 1 0 0 0;
0 1 0 1 0 0;
0 0 1 0 1 0;
0 0 0 1 0 1;
1 0 0 0 1 0];
G_estrela = [0 1 1 1 1 1 1;
1 0 0 0 0 0 0;
1 0 0 0 0 0 0;
1 0 0 0 0 0 0;
1 0 0 0 0 0 0;
1 0 0 0 0 0 0;
1 0 0 0 0 0 0];
G_grade = [0 1 0 0 1 0 0 0 0 0;
1 0 1 0 0 1 0 0 0 0;
0 1 0 1 0 0 1 0 0 0;
0 0 1 0 0 0 0 1 0 0;
1 0 0 0 0 1 0 0 1 0;
0 1 0 0 1 0 1 0 0 1;
0 0 1 0 0 1 0 1 0 0;
0 0 0 1 0 0 1 0 1 0;
0 0 0 0 1 0 0 1 0 1;
0 0 0 0 0 1 0 0 1 0];
G_dirPeso = [0 6 9 15 0 3;
 0 0 2 0 0 0;
 0 0 0 3 0 0;
 2 0 0 0 5 0;
 0 1 0 0 0 1;
 3 0 0 0 1 0];

nodesName = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K'}';

G1 = graph(G_gen,nodesName(1:length(G_gen))); % Grafo não dirigido
figure('Name','G1');
P1 =plot(G1,'NodeFontSize',20,'NodeColor','k','EdgeColor','b','LineWidth',3,'Marker','o','MarkerSize',10,'Layout', 'force');
%G2 - CIRCLE
G2 = graph(G_ciclo,nodesName(1:length(G_ciclo))); % Grafo não dirigido
figure('Name','G2');
P2 = plot(G2,'NodeFontSize',20,'NodeColor','k','EdgeColor','b','LineWidth',3,'Marker','o','MarkerSize',10,'Layout', 'circle');
%G3 - FORCE
G3 = graph(G_estrela,nodesName(1:length(G_estrela))); % Grafo não dirigido
figure('Name','G3');
P3 = plot(G3,'NodeFontSize',20,'NodeColor','k','EdgeColor','b','LineWidth',3,'Marker','o','MarkerSize',10,'Layout', 'force');
%G4 - CIRCLE
G4 = graph(G_grade,nodesName(1:length(G_grade))); % Grafo não dirigido
figure('Name','G4');
P4 = plot(G4,'NodeFontSize',20,'NodeColor','k','EdgeColor','b','LineWidth',3,'Marker','o','MarkerSize',10,'Layout', 'circle');
%G5 - SUBSPACE3
G5 = digraph(G_dirPeso,nodesName(1:length(G_dirPeso))); % Grafo dirigido
figure('Name','G5');
P5 = plot(G5,'NodeFontSize',20,'NodeColor','k','EdgeColor','b','LineWidth',3,'Marker','o','MarkerSize',10,'Layout', 'subspace3');