function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and
%   sigma. You should complete this function to return the optimal C and
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example,
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using
%        mean(double(predictions ~= yval))
%

Xval_clone = Xval;
min_er = Inf;
C_chosen = 0.01;
sigma_chosen = 0.01;

C_pos = [0.01 0.03 0.1 0.3 1 3 10];
sigma_pos = [0.01 0.03 0.1 0.3 1 3 10];


for i = 1:length(C_pos)
  for j = 1:length(sigma_pos)
    C = C_pos(i)
    sigma = sigma_pos(j)

    model= svmTrain(X, y, C, @(Xval, Xval_clone) gaussianKernel(Xval, Xval_clone, sigma));
    predictions = svmPredict(model, Xval);

    er = mean(double(predictions ~= yval));
    if er < min_er,
      min_er = er
      C_chosen = C
      sigma_chosen = sigma
    end
  end
end

C = C_chosen
sigma = sigma_chosen
% =========================================================================

end
