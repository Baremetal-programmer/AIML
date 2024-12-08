% Decision Tree Example in MATLAB using Iris Dataset

% Load Iris dataset (MATLAB has built-in Iris data)
load fisheriris;

% Inputs (features) and outputs (classes)

X = meas; % Features: Sepal length, Sepal width, Petal length, Petal width
Y = species; % Class labels: Setosa, Versicolor, Virginica

% Split data into training and test sets (80% train, 20% test)
cv = cvpartition(Y, 'HoldOut', 0.2);
X_train = X(training(cv), :);
Y_train = Y(training(cv), :);
X_test = X(test(cv), :);
Y_test = Y(test(cv), :);

% Train a decision tree classifier
treeModel = fitctree(X_train, Y_train, 'PredictorNames', {'Sepal Length', 'Sepal Width', 'PetalLength', 'Petal Width'});

% Display the trained tree
view(treeModel, 'Mode', 'graph'); % Visualize the tree

% Test the decision tree model on test data
Y_pred = predict(treeModel, X_test);

% Evaluate performance
accuracy = sum(strcmp(Y_pred, Y_test)) / length(Y_test) * 100;
disp(['Accuracy: ', num2str(accuracy), '%']);

% Confusion matrix to analyze predictions
confMat = confusionmat(Y_test, Y_pred);
disp('Confusion Matrix:');
disp(confMat);

% Plot the decision boundary (for first two features)
figure;
gscatter(X_test(:,1), X_test(:,2), Y_test, 'rgb', 'osd');
hold on;
title('Decision Tree Classification - Test Data');
xlabel('Sepal Length');
ylabel('Sepal Width');
legend('Setosa', 'Versicolor', 'Virginica');