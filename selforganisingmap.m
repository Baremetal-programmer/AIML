% Self-Organizing Map (SOM) Example in MATLAB using Iris Dataset

% Load Iris dataset (MATLAB has built-in Iris data)
load fisheriris;

% Inputs (features)
X = meas'; % Transpose to match the SOM input format (features x samples)

% Define the size of the SOM grid (e.g., 5x5 grid)
gridSize = [5 5];

% Create and configure a Self-Organizing Map (SOM)
net = selforgmap(gridSize);

% Train the SOM network
net = train(net, X);

% Visualize the SOM grid and its clustering
figure;
plotsompos(net, X); % Plot the SOM with data points

% Visualize the SOM grid with weights
figure;
plotsom(net.iw{1,1}, net.layers{1}.distances);

% Assign input samples to clusters (SOM nodes)
clusterIdx = vec2ind(net(X));

% Display clustering result
disp('Cluster indices for each sample:');
disp(clusterIdx');

% Visualize the clustering in a scatter plot (first two features)
figure;
gscatter(X(1,:), X(2,:), clusterIdx);
title('SOM Clustering of Iris Dataset (First Two Features)');
xlabel('Sepal Length');
ylabel('Sepal Width');