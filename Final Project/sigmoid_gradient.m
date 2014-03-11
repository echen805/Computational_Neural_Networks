function [dy] = sigmoid_gradient(sigmoid_matrix)
    dy = activation(sigmoid_matrix).*(1-activation(sigmoid_matrix));
end