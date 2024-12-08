% Step 1: Load the Iris dataset
load fisheriris

data = meas;

% Step 2: Compute the pairwise distance between observations
distances = pdist(data, 'euclidean');

% Step 3: Perform hierarchical clustering using linkage
% Using 'average' linkage as an example; options include 'single', 'complete', 'ward', etc.
linkageTree = linkage(distances, 'average');

% Step 4: Plot dendrogram
figure;
dendrogram(linkageTree, 0); % 0 means all leaves are displayed
title('Hierarchical Clustering Dendrogram (Iris Dataset)');
xlabel('Sample Index');
ylabel('Distance');

% Step 5: Define the number of clusters and assign clusters to data points
numClusters = 3; % Setosa Versicolor Virginica
clusters = cluster(linkageTree, 'maxclust', numClusters);

% Step 6: Visualize the clusters
figure;
gscatter(data(:,1), data(:,2), clusters, 'rbg', 'o', 8);
title('Hierarchical Clustering of Iris Data');
xlabel('Sepal Length');
ylabel('Sepal Width');
legend('Cluster 1', 'Cluster 2', 'Cluster 3');