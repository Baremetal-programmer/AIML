% Define the adjacency matrix based on the distances between cities
% Cities are indexed as follows:
% 1 = Arad, 2 = Zerind, 3 = Oradea, 4 = Sibiu, 5 = Fagaras, 6 = Rimnicu Vilcea,
% 7 = Pitesti, 8 = Timisoara, 9 = Lugoj, 10 = Mehadia, 11 = Drobeta, 12 = Craiova,
% 13 = Bucharest, 14 = Giurgiu, 15 = Urziceni, 16 = Hirsova, 17 = Eforie,
% 18 = Vaslui, 19 = Iasi, 20 = Neamt

clc;
clearvars;
close all;
figure;

% Load Romania map
romania_city = imread('Romania_Map.png');
imshow(romania_city);

% Adjacency matrix representing distances between cities
graph = [
    0   75  0   140 0   0   0   118 0   0   0   0   0   0   0   0   0   0   0   0;  % Arad
    75  0   71  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0;  % Zerind
    0   71  0   151 0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0;  % Oradea
    140 0   151 0   99  80  0   0   0   0   0   0   0   0   0   0   0   0   0   0;  % Sibiu
    0   0   0   99  0   0   0   0   0   0   0   0   211 0   0   0   0   0   0   0;  % Fagaras
    0   0   0   80  0   0   97  0   0   0   0   146 0   0   0   0   0   0   0   0;  % Rimnicu Vilcea
    0   0   0   0   0   97  0   0   0   0   0   138 101 0   0   0   0   0   0   0;  % Pitesti
    118 0   0   0   0   0   0   0   111 0   0   0   0   0   0   0   0   0   0   0;  % Timisoara
    0   0   0   0   0   0   0   111 0   70  0   0   0   0   0   0   0   0   0   0;  % Lugoj
    0   0   0   0   0   0   0   0   70  0   75  0   0   0   0   0   0   0   0   0;  % Mehadia
    0   0   0   0   0   0   0   0   0   75  0   120 0   0   0   0   0   0   0   0;  % Drobeta
    0   0   0   0   0   146 138 0   0   0   120 0   0   0   0   0   0   0   0   0;  % Craiova
    0   0   0   0   211 0   101 0   0   0   0   0   0   90  85  0   0   0   0   0;  % Bucharest
    0   0   0   0   0   0   0   0   0   0   0   0   90  0   0   0   0   0   0   0;  % Giurgiu
    0   0   0   0   0   0   0   0   0   0   0   0   85  0   0   98 0   142 0   0;  % Urziceni
    0   0   0   0   0   0   0   0   0   0   0   0   0   0   98  0   86  0   0   0;  % Hirsova
    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   86 0   0   0   0;  % Eforie
    0   0   0   0   0   0   0   0   0   0   0   0   0   0   142 0   0   0   92 0;  % Vaslui
    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   92 0   87;  % Iasi
    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   87 0;  % Neamt
];

% Define heuristic values for each city
heuristic = [366, 374, 380, 253, 176, 193, 100, 329, 244, 241, 242, 160, 0, 77, 80, 151, 161, 199, 226, 234];

% Define start and goal nodes (1 = Arad, 13 = Bucharest)
startNode = 1;
goalNode = 13;

% Run Greedy Best-First Search
[greedyPath, greedyCost, greedyPathCosts, greedyMetrics] = greedyBestFirstSearch(graph, heuristic, startNode, goalNode);

% Display Greedy Best-First Search results
fprintf('Greedy Best-First Search:\n');
fprintf('Path: %s\n', mat2str(greedyPath));
fprintf('Path Cost: %d\n', greedyCost);
fprintf('Nodes Expanded (Time Complexity): %d\n', greedyMetrics.nodesExpanded);
fprintf('Maximum Open List Size (Space Complexity): %d\n\n', greedyMetrics.maxOpenListSize);

% Run A* Search
[astarPath, astarCost, astarPathCosts, astarMetrics] = aStarSearch(graph, heuristic, startNode, goalNode);

% Display A* Search results
fprintf('A* Search:\n');
fprintf('Path: %s\n', mat2str(astarPath));
fprintf('Path Cost: %d\n', astarCost);
fprintf('Nodes Expanded (Time Complexity): %d\n', astarMetrics.nodesExpanded);
fprintf('Maximum Open List Size (Space Complexity): %d\n', astarMetrics.maxOpenListSize);

% Plot the graph and path for Greedy Best-First Search
figure;
plotGraphWithPath(graph, greedyPath, 'Greedy Best-First Search Path', startNode, goalNode);

% Plot the graph and path for A* Search
figure;
plotGraphWithPath(graph, astarPath, 'A* Search Path', startNode, goalNode);

%% Function Definitions
% Greedy Best-First Search
function [path, totalCost, pathCosts, metrics] = greedyBestFirstSearch(graph, heuristic, startNode, goalNode)
    openList = [startNode];
    cameFrom = zeros(1, size(graph, 1));
    pathCosts = inf(1, size(graph, 1)); % Path cost for each node
    pathCosts(startNode) = 0;
    metrics.nodesExpanded = 0; % Number of nodes expanded (time complexity)
    metrics.maxOpenListSize = 0; % Maximum size of open list (space complexity)

    while ~isempty(openList)
        % Update metrics
        metrics.nodesExpanded = metrics.nodesExpanded + 1;
        metrics.maxOpenListSize = max(metrics.maxOpenListSize, length(openList));
        
        % Choose node with lowest heuristic value
        [~, idx] = min(heuristic(openList));
        current = openList(idx);

        openList(idx) = [];
        
        % Check if goal reached
        if current == goalNode
            path = reconstructPath(cameFrom, startNode, goalNode);
            totalCost = pathCosts(goalNode);
            return;
        end
        
        % Get neighbors
        neighbors = find(graph(current, :) > 0);
        for neighbor = neighbors
            if cameFrom(neighbor) == 0 && neighbor ~= startNode
                cameFrom(neighbor) = current;
                pathCosts(neighbor) = pathCosts(current) + graph(current, neighbor);
                openList = [openList, neighbor];
            end
        end
    end
    path = []; % No path found
    totalCost = inf;
end

% A* Search
function [path, totalCost, pathCosts, metrics] = aStarSearch(graph, heuristic, startNode, goalNode)
    openList = [startNode];
    cameFrom = zeros(1, size(graph, 1));
    pathCosts = inf(1, size(graph, 1)); % Path cost for each node
    pathCosts(startNode) = 0;
    metrics.nodesExpanded = 0; % Number of nodes expanded (time complexity)
    metrics.maxOpenListSize = 0; % Maximum size of open list (space complexity)
    fScores = inf(1, size(graph, 1));
    fScores(startNode) = heuristic(startNode);

    while ~isempty(openList)
        % Update metrics
        metrics.nodesExpanded = metrics.nodesExpanded + 1;
        metrics.maxOpenListSize = max(metrics.maxOpenListSize, length(openList));
        
        % Choose node with lowest fScore value
        [~, idx] = min(fScores(openList));
        current = openList(idx);

        openList(idx) = [];
        
        % Check if goal reached
        if current == goalNode
            path = reconstructPath(cameFrom, startNode, goalNode);
            totalCost = pathCosts(goalNode);
            return;
        end
        
        % Get neighbors
        neighbors = find(graph(current, :) > 0);
        for neighbor = neighbors
            tentativeGScore = pathCosts(current) + graph(current, neighbor);
            if tentativeGScore < pathCosts(neighbor)
                cameFrom(neighbor) = current;
                pathCosts(neighbor) = tentativeGScore;
                fScores(neighbor) = pathCosts(neighbor) + heuristic(neighbor);
                openList = [openList, neighbor];
            end
        end
    end
    path = []; % No path found
    totalCost = inf;
end

% Path reconstruction
function path = reconstructPath(cameFrom, startNode, goalNode)
    path = goalNode;
    while path(1) ~= startNode
        path = [cameFrom(path(1)), path];
    end
end

% Graph visualization function
function plotGraphWithPath(graph, path, titleText, startNode, goalNode)
    % Coordinates for cities in Romania (simplified)
    cityCoords = [
        0   0; % Arad
        1   2; % Zerind
        2   3; % Oradea
        3   2; % Sibiu
        4   2; % Fagaras
        5   2; % Rimnicu Vilcea
        6   2; % Pitesti
        7   2; % Timisoara
        8   2; % Lugoj
        9   3; % Mehadia
        10  4; % Drobeta
        11  4; % Craiova
        12  4; % Bucharest
        13  5; % Giurgiu
        14  5; % Urziceni
        15  6; % Hirsova
        16  7; % Eforie
        17  8; % Vaslui
        18  9; % Iasi
        19  10; % Neamt
    ];

    hold on;
    % Plot each city as a point
    plot(cityCoords(:, 1), cityCoords(:, 2), 'bo');
    % Label each city
    labels = {'Arad', 'Zerind', 'Oradea', 'Sibiu', 'Fagaras', 'Rimnicu Vilcea', 'Pitesti', 'Timisoara', 'Lugoj', 'Mehadia', 'Drobeta', 'Craiova', 'Bucharest', 'Giurgiu', 'Urziceni', 'Hirsova', 'Eforie', 'Vaslui', 'Iasi', 'Neamt'};
    for i = 1:length(labels)
        text(cityCoords(i, 1) + 0.1, cityCoords(i, 2), labels{i});
    end

    % Plot the edges between cities
    [i, j] = find(graph);
    for idx = 1:length(i)
        plot([cityCoords(i(idx), 1), cityCoords(j(idx), 1)], ...
             [cityCoords(i(idx), 2), cityCoords(j(idx), 2)], 'k-');
    end
    
    % Highlight the path
    for k = 1:length(path)-1
        plot([cityCoords(path(k), 1), cityCoords(path(k+1), 1)], ...
             [cityCoords(path(k), 2), cityCoords(path(k+1), 2)], 'r-', 'LineWidth', 2);
    end

    % Highlight start and goal
    plot(cityCoords(startNode, 1), cityCoords(startNode, 2), 'go', 'MarkerFaceColor', 'g');
    plot(cityCoords(goalNode, 1), cityCoords(goalNode, 2), 'ro', 'MarkerFaceColor', 'r');
    title(titleText);
    hold off;
end

