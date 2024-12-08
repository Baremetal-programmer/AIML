a = [1 1 2 2 2 2 3 3 3 3];  % Source nodes
s = [3 4 5 1 7 8 9 10 11 12];  % Target nodes
g = graph(a, s);  % Create graph
plot(g);  % Plot the graph
ans = bfsearch(g, 1);
disp(ans);