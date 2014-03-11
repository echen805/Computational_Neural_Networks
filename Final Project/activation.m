function [sigmoid_matrix] = activation(input_matrix)
    sigmoid_matrix = 1./(1+ exp((-1)*input_matrix));    
end