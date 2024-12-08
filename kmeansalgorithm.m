% k-Means Clustering Example in MATLAB using Iris Dataset

% Load Iris dataset (MATLAB has built-in Iris data)
load fisheriris;

% Inputs (features)
X = meas; % Features: Sepal length, Sepal width, Petal length, Petal width

% Set the number of clusters (k)
k = 3; % Since we know the Iris dataset has 3 species, we use k = 3

% Apply k-Means clustering
[idx, C] = kmeans(X, k, 'Distance', 'sqeuclidean', 'Replicates', 5);

% Plot the clustered data (using the first two features for visualization)
figure;
gscatter(X(:,1), X(:,2), idx, 'rgb', 'osd');
hold on;

% Plot the centroids
plot(C(:,1), C(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
title('k-Means Clustering of Iris Dataset (First Two Features)');
xlabel('Sepal Length');
ylabel('Sepal Width');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids');
hold off;

% Display cluster centroids
disp('Cluster centroids:');
disp(C);

% Display the number of points in each cluster
disp('Number of points in each cluster:');
disp(histcounts(idx, k));

% Evaluate the clustering with silhouette plot
figure;
silhouette(X, idx);
title('Silhouette Plot for k-Means Clustering');