% Locally Weighted Regression (LWR) - Using Fisher Iris Dataset
clear; clc;

% Load the fisheriris dataset
load fisheriris;

X = meas(:,1); % Select Sepal Length (first feature) as input

Y = meas(:,2); % Select Sepal Width (second feature) as output

% Number of data points
m = length(X);

% Plot the original data points
figure;
scatter(X, Y, 'filled');
title('Sepal Length vs Sepal Width (Original Data)');
xlabel('Sepal Length');
ylabel('Sepal Width');
hold on;

% Parameters for Locally Weighted Regression
tau = 0.8; % Bandwidth parameter (controls the weight decay based on distance)
x_test = linspace(min(X), max(X), 100)'; % Points where we will compute predictions
y_pred = zeros(size(x_test)); % Initialize predictions

% Locally Weighted Regression (LWR) function
for i = 1:length(x_test)

% Compute weights for each training point
W = exp(-(X - x_test(i)).^2 / (2 * tau^2)); % Gaussian weighting

% Construct the weighted design matrix
X_design = [ones(m, 1), X]; % Add a column of ones for the intercept
W_matrix = diag(W); % Diagonal weight matrix

% Perform weighted linear regression to get theta
theta = (X_design' * W_matrix * X_design) \ (X_design' * W_matrix * Y);

% Predict the output for x_test(i)
y_pred(i) = [1, x_test(i)] * theta;
end

% Plot the fitted regression line
plot(x_test, y_pred, '-r', 'LineWidth', 2);
legend('Original Data', 'Locally Weighted Regression Fit');
hold off