clear all; close all; clc;
XY_Points = [ 138 52
              263 95
              523 16
              365 363
              545 197
              618 289
              752 200
              797 216
              893 60
              1000 344
              295 377
              435 377
              683 377
              894 377];
nodesName = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O'};
Adj_ndir = squareform(pdist(XY_Points));
G1 = graph(Adj_ndir,nodesName(1:length(Adj_ndir)));
figure('Name','G1');
P1 = plot(G1,'XData',(XY_Points(:,1))','YData',(XY_Points(:,2))','NodeFontSize',20,'NodeColor','k','EdgeColor','b','LineWidth',1,'Marker','o','MarkerSize',10);
[mst, cost] = prim(Adj_ndir,P1);
disp('Mst: ');
disp(mst);
disp('Cost: ');
disp(cost);