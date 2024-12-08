%BFS VS DFS
% Define graph edges
a = [1 1 2 2 2 2 3 3 3 3];  % Source nodes
s = [3 4 5 1 7 8 9 10 11 12];  % Target nodes

% Create graph
g = graph(a, s);
plot(g);

% Measure time and space for BFS
tic;
bfsResult = bfsearch(g, 1);  % Perform BFS starting at node 1
bfsTime = toc;
bfsSpace = whos('bfsResult');
disp(['Time for BFS: ', num2str(bfsTime), ' seconds']);
disp(['Space for BFS: ', num2str(bfsSpace.bytes / 1024), ' KB']);

% Measure time and space for DFS
tic;
dfsResult = dfsearch(g, 1);  % Perform DFS starting at node 1
dfsTime = toc;
dfsSpace = whos('dfsResult');
disp(['Time for DFS: ', num2str(dfsTime), ' seconds']);
disp(['Space for DFS: ', num2str(dfsSpace.bytes / 1024), ' KB']);