clear all; close all; clc; % Limpa memória
%% Universidade Federal de Santa Catarina
% Campus Blumenau
% Departamento de Engenharia de Controle, Automação e Computação
% BLU3504 – Modelagem, Análise e Avaliação de Desempenho de Sistemas Automatizados
% Prof. Guilherme B. Pintarelli - guilherme.pintarelli@ufsc.br
% Esse é um arquivo exemplo do uso da função do MATLAB (graph, digraph e shortestpath).
%% Input grafo com matriz de adjacência
% Dirigido
 % a b c d e f
Adj_ndir = [0 1 1 0 0; % a
 1 0 1 1 0; % b
 1 1 0 1 1; % c
 0 1 1 0 1; % d
 0 0 1 1 0];% e

% Não dirigido
Adj_dir = [1 1 0 0 0; % a
 0 0 0 1 0; % b
 1 1 0 0 1; % c
 0 0 1 0 1; % d
 0 0 0 0 0];% e
% Nomes dos nós (em função da aplicação)
nodesName = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K'}';
%% Cria tabela de nós e arcos. Entrada 'upper'/'lower' (não dirigido)
G1 = graph(Adj_ndir,nodesName(1:length(Adj_ndir))); % Grafo não dirigido
% Plota o grafo
figure('Name','G1');
P1 = plot(G1,'NodeFontSize',20,'NodeColor','k','EdgeColor','b','LineWidth',3,...
 'Marker','o','MarkerSize',10,'Layout', 'layered');
% Layout pode ser: 'circle', 'force', 'layered', 'subspace', 'force3', or 'subspace3'.

%% Cria tabela de nós e arcos. Entrada 'upper'/'lower'
G2 = digraph(Adj_dir,nodesName(1:length(Adj_dir))); % Grafo dirigido
figure('Name','G2');
P2 = plot(G2,'NodeFontSize',20,'NodeColor','k','EdgeColor','b','LineWidth',3,...
 'Marker','o','MarkerSize',10,'ArrowSize',20,'Layout', 'layered', 'EdgeLabel', G2.Edges.Weight);
%% Algoritmo de Dijkstra para encontrar menores caminhos (para ser utilizado na Q5)
%[path1,d] = shortestpath(G2,'A','D');
%highlight(P2,path1,'EdgeColor','g');
