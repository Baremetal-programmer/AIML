% Define the adjacency matrix (Graph)
Graph = [0 2 5 0 0 0 0;
         2 0 6 1 3 0 0;
         5 6 0 0 0 8 0;
         0 1 0 0 4 0 0;
         0 3 0 4 0 0 9;
         0 0 8 0 0 0 7;
         0 0 0 0 9 7 0];

% Set the source node (1) and goal node (7)
source = 1;
goal = 7;

% Call the DijkstraPlot function
DijkstraPlot(Graph, source, goal);

function DijkstraPlot(Graph, source, goal)
    % Dijkstra's algorithm with detailed logging and plot with highlighted shortest path
    % Number of vertices
    numVertices = size(Graph, 1);
    
    % Initialize distances and previous nodes
    dist = inf(1, numVertices); % Distance from source to each node (initially infinite)
    prev = NaN(1, numVertices); % Previous node for the shortest path (initially undefined)
    dist(source) = 0; % Distance to the source node is 0
    
    % Set of vertices to be evaluated (Q)
    Q = 1:numVertices; % List of all nodes to explore
    
    % Start of the Dijkstra algorithm
    fprintf('Starting Dijkstra Algorithm from Node %d\n', source);
    fprintf('---------------------------------------------------\n');
    
    % While there are still nodes to explore in Q
    while ~isempty(Q)
        % Find the node in Q with the smallest distance
        [~, idx] = min(dist(Q)); % Get the index of the smallest distance
        
        u = Q(idx); % Node 'u' is the node with the smallest distance
        Q(idx) = []; % Remove 'u' from Q (we are now processing this node)
        
        % Display the node being processed and the current known distance to it
        fprintf('Currently processing Node %d. Distance from source: %d\n', u, dist(u));
        
        % Check all neighbors of node 'u'
        for v = 1:numVertices
            if Graph(u, v) > 0 % If there's an edge between 'u' and 'v'
                % Calculate the alternative distance if passing through node 'u'
                alt = dist(u) + Graph(u, v);
                
                % If the new distance (alt) is shorter than the previously known distance
                if alt < dist(v)
                    dist(v) = alt; % Update the distance to node 'v'
                    prev(v) = u; % Record that 'u' is the previous node before 'v'
                    
                    % Display the updated distance and new path information
                    fprintf(' -> Found shorter path to Node %d. Updated distance: %d (via Node %d)\n', v, alt, u);
                else
                    % Inform that no shorter path was found through this neighbor
                    fprintf(' -> Node %d already has a shorter path. No update needed.\n', v);
                end
            end
        end
    end
    fprintf('---------------------------------------------------\n');
    
    % Reconstruct the shortest path from source to goal
    path = [];
    totalCost = dist(goal); % Total cost of the path to the goal
    currentNode = goal;
    fprintf('Reconstructing the shortest path from Node %d to Node %d...\n', source, goal);
    
    while ~isnan(currentNode)
        path = [currentNode path]; % Add the current node to the path
        fprintf(' - Node %d added to the path\n', currentNode);
        currentNode = prev(currentNode); % Move to the previous node in the path
    end
    
    % Display the final shortest path and its cost
    fprintf('Shortest Path: %s\n', mat2str(path));
    fprintf('Total Path Cost: %d\n', totalCost);
    
    % Plot the graph and highlight the path
    figure;
    hold on;
    G = graph(Graph);
    
    % Plot all edges
    plot(G, 'Layout', 'force', 'EdgeLabel', G.Edges.Weight);
    
    % Highlight the shortest path from source to goal
    highlightPath(G, path, source, goal);
end

function highlightPath(G, path, source, goal)
    % Highlight the path on the plot
    p = plot(G, 'Layout', 'force', 'EdgeLabel', G.Edges.Weight);
    
    % Highlight the path with red edges
    highlight(p, path, 'EdgeColor', 'r', 'LineWidth', 2, 'NodeColor', 'y', 'MarkerSize', 7);
    
    % Highlight the source and goal nodes
    highlight(p, source, 'NodeColor', 'g', 'MarkerSize', 10);
    highlight(p, goal, 'NodeColor', 'b', 'MarkerSize', 10);
    
    % Title for the plot
    title('Graph with Shortest Path Highlighted');
    hold off;
end
