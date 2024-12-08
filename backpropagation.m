clear; clc;

% Load Iris dataset
load fisheriris;
X = meas; % Input features (Sepal Length, Sepal Width, Petal Length, Petal Width)
Y_labels = species; % Output classes (Setosa, Versicolor, Virginica)

% Convert class labels to one-hot encoding
Y = zeros(length(Y_labels), 3);
for i = 1:length(Y_labels)
    if strcmp(Y_labels{i}, 'setosa')
        Y(i,1) = 1;
    elseif strcmp(Y_labels{i}, 'versicolor')
        Y(i,2) = 1;
    else
        Y(i,3) = 1;
    end
end

% Normalize input data (scale to [0, 1])
X = (X - min(X)) ./ (max(X) - min(X));

% Network parameters
inputLayerSize = 4; % 4 input features
hiddenLayerSize = 5; % 5 hidden neurons (can be adjusted)
outputLayerSize = 3; % 3 output neurons (one for each class)
learningRate = 0.01; % Learning rate
epochs = 5000; % Number of iterations

% Initialize weights and biases
W1 = rand(inputLayerSize, hiddenLayerSize) - 0.5; % Weights between input and hidden layer
b1 = rand(1, hiddenLayerSize) - 0.5; % Bias for hidden layer
W2 = rand(hiddenLayerSize, outputLayerSize) - 0.5; % Weights between hidden and output layer
b2 = rand(1, outputLayerSize) - 0.5; % Bias for output layer

% Sigmoid activation function and its derivative
sigmoid = @(x) 1 ./ (1 + exp(-x));
sigmoidDerivative = @(x) x .* (1 - x);

% Training the neural network using backpropagation
for epoch = 1:epochs
    for i = 1:size(X,1)
        % --- Forward Propagation ---
        % Input layer to hidden layer
        z1 = X(i,:) * W1 + b1; % Weighted sum at hidden layer
        a1 = sigmoid(z1); % Activation at hidden layer
        % Hidden layer to output layer
        z2 = a1 * W2 + b2; % Weighted sum at output layer
        a2 = sigmoid(z2); % Activation at output layer
        
        % --- Backpropagation ---
        % Error at output layer
        error = Y(i,:) - a2; % Calculate the error (target - prediction)
        % Delta for output layer
        delta2 = error .* sigmoidDerivative(a2);
        % Error for hidden layer (backpropagating error to hidden layer)
        delta1 = delta2 * W2' .* sigmoidDerivative(a1);
        
        % --- Weight Update ---
        W2 = W2 + learningRate * (a1' * delta2); % Update weights between hidden and output layer
        b2 = b2 + learningRate * delta2; % Update biases for output layer
        W1 = W1 + learningRate * (X(i,:)' * delta1); % Update weights between input and hidden layer
        b1 = b1 + learningRate * delta1; % Update biases for hidden layer
    end
    
    % Optional: Display mean error every 1000 epochs
    if mod(epoch, 1000) == 0
        meanError = sum(sum(abs(error))) / size(X, 1);
        disp(['Epoch ' num2str(epoch) ', Mean Error: ' num2str(meanError)]);
    end
end

% --- Testing the trained network ---
disp('Testing the trained network:');
correct = 0;
for i = 1:size(X,1)
    % Forward propagation (without updating weights)
    z1 = X(i,:) * W1 + b1;
    a1 = sigmoid(z1);
    z2 = a1 * W2 + b2;
    a2 = sigmoid(z2);
    % Predicted class (find the index of the max activation)
    [~, pred] = max(a2);
    [~, trueClass] = max(Y(i,:));
    if pred == trueClass
        correct = correct + 1;
    end
end

% Display the accuracy
accuracy = (correct / size(X,1)) * 100;
disp(['Accuracy: ' num2str(accuracy) '%']);
