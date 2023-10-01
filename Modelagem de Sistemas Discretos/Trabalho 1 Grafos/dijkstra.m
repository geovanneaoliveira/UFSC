function [dist, path] = dijkstra(adj_matrix, start_node, end_node)

n = size(adj_matrix, 1); % number of nodes in the graph

% initialize distance and predecessor arrays
dist = inf(1, n);
prev = zeros(1, n);

% set the starting node distance to zero
dist(start_node) = 0;

% create a priority queue of all nodes in the graph
unvisited_nodes = 1:n;

% main loop
while ~isempty(unvisited_nodes)
    % find the unvisited node with the smallest tentative distance
    [min_dist, idx] = min(dist(unvisited_nodes));
    current_node = unvisited_nodes(idx);
    
    % check if we have reached the end node
    if current_node == end_node
        break
    end
    
    % remove current node from the unvisited set
    unvisited_nodes(idx) = [];
    
    % update distances to neighboring nodes
    neighbors = find(adj_matrix(current_node,:));
    for neighbor = neighbors
        alt = dist(current_node) + adj_matrix(current_node, neighbor);
        if alt < dist(neighbor)
            dist(neighbor) = alt;
            prev(neighbor) = current_node;
        end
    end
end

% construct the shortest path by backtracking from the end node to the start node
path = end_node;
while path(1) ~= start_node
    path = [prev(path(1)) path];
end
end