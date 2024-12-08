a=[1 1 2 2 2 2 3 3 3 3];%dfs
s=[3 4 5 1 7 8 9 10 11 12];
g=graph(a,s);
plot(g);
ans=dfsearch(g,1);
disp(ans);