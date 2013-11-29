function [J grad] = nnCostFunction(nn_params, ...
				   input_layer_size, ...
				   hidden_layer_size, ...
				   num_labels, ...
				   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices.
%
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
		 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
		 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);

% You need to return the following variables correctly
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m

a1 = [ones(m, 1), X];
a2 = sigmoid(a1 * Theta1');
a2 = [ones(m, 1), a2];
a3 = sigmoid(a2 * Theta2');

%disp("h(theta)");
%disp(size(a3));
%disp(a3(1:10,:));
%pause;

yv = repmat(1:num_labels, size(y,1) , 1) == repmat(y, 1, num_labels);

%disp("yv");
%disp(size(yv));
%disp(yv(1:10,:));
%pause;

J_one = log(a3);
J_two = log(1-a3);

pre_cost = (J_one .* yv + J_two .* (1-yv));

%disp("pre cost");
%disp(size(pre_cost));
%disp(pre_cost(1:10,:));
%pause;

J = (-1 / m) .* pre_cost;

%disp("J matrix");
%disp(size(J));
%disp(J(1:10,:));
%pause;

J = sum(sum(J));
%disp("J");
%disp(J);
%pause;


%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the
%               first time.


%big_delta1 = 0
%big_delta2 = 0

% for t=1:m,
%for t=1:1,
%  x = X(t,:);
%  yt = yv(t,:)
%  disp("size of row");
%  disp(size(x));

%  a1 = [1 , x];
%  z2 = a1 * Theta1';
%  a2 = sigmoid(z2);
%  a2 = [1 , a2];
%  z3 = a2 * Theta2';
%  a3 = sigmoid(z3)

%  d3 = a3 .- yt

%    disp("sizes before d2 calc");
%    disp(size(Theta2));
%    disp(size(d3));
%disp(sigmoidGradient(z2));

%d2 = (d3 * Theta2(:,2:end)) .* sigmoidGradient(z2);

%disp("a1 size");
%disp(size(a1));

%disp("a2 size");
%disp(size(a2));

%disp("d2 size");
%disp(size(d2));

%big_d2 = d2' * x;

% big_delta2 += d3 * a2';
% big_delta1 += d2 * a1';

%pause;
%end

a1 = [ones(m, 1), X];
z2 = a1 * Theta1';
a2 = sigmoid(z2);
a2 = [ones(m, 1), a2];
z3 = a2 * Theta2';
a3 = sigmoid(z3);

disp("a1 size");
disp(size(a1));

disp("a2 size");
disp(size(a2));

disp("a3 size");
disp(size(a3));

delta_3 = a3 - yv;
disp("delta_3 size");
disp(size(delta_3));

r2 = delta_3 * Theta2(:,2:end);
disp("r2 size");
disp(size(r2));

delta_2 = r2 .* sigmoidGradient(z2);
disp("delta_2 size");
disp(size(delta_2));

t1 = (Theta1 .* lambda);
t1(:,1) = 0;
disp("t1 size");
disp(size(t1));

Theta1_grad = ((delta_2' * a1) .+ t1) ./ m;
disp("Theta1_grad size");
disp(size(Theta1_grad));

t2 = (Theta2 .* lambda);
t2(:,1) = 0;
disp("t2 size");
disp(size(t2));


Theta2_grad = ((delta_3' * a2) .+ t2) ./ m;
disp("Theta2_grad size");
disp(size(Theta2_grad));

%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

disp("lambda");
theta1_short = Theta1;
theta2_short = Theta2;
theta1_short(:,1) = 0;
theta2_short(:,1) = 0;

sums = sum(sum(theta1_short.^2)) + sum(sum(theta2_short.^2));
precalc = (lambda ./ (2 .* m));
reg = precalc .* sums;
% disp(lambda);

J += reg

















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
