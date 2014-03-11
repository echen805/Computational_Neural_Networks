% rows represent the number of inputs
% columns represent the number of patterns the network will be trained on
rows = 8;
columns = 8;
check_one = 0;
input = randweights(rows,columns)

% Checks the number of ones in the matrix
for j=1:columns
    for i=1:rows
       if input(j,i) == 1
           check_one = check_one + 1;
       end
    end
end
% Displays the numbers of ones in the weight
check_one
if mod(check_one,2)== 0
    disp('There are even number of ones!');
end
if mod(check_one,2)~= 0
    disp('There are odd number of ones!');
end

% Formula to create random within specific ranges [a,b]
% r = (b-a).*rand(num_of_rows,num_of_cols) + a;

% Creating the random matrix that connects input to hidden units
% Input is eight layers, hidden is three layers
min_range = -0.5;
max_range = 0.5;
w_fg = (max_range-min_range).*rand(3,8) + min_range;

% Creating the random matrix that connects hidden units to output
% hidden is three layers, output is one layer
w_gh = (max_range-min_range).*rand(1,3) + min_range;

sse = 100;
epoch = 0;
input_to_hidden = zeros(3,1);

% while epoch < 1000 || sse <= 0.01
for a=1:1000
    % Passing the activation from the input units to the hidden units
    % for loop only calculates one epoch
    for h=1:8
        temp = w_fg * input(:,h);
        input_to_hidden = input_to_hidden + temp;
    
        % Applying the sigmoid activation from input to hidden layers
        hidden_activation = activation(input_to_hidden);

        % Passing the activation from the hidden units to the output units
        input_to_output = w_gh * hidden_activation;

        % Determining output activity by passing the input to the output through
        % the activation function
        output_activation = activation(input_to_output);

        % Finding output error
        if mod(check_one,2)== 0
            desired_output = 1;
        end
        if mod(check_one,2)~= 0
            desired_output = 0;
        end
        % Error from a sweep
        output_error = desired_output - output_activation;
    
        % Finding the weight changes via sigmoid gradient
        dw_fg = diag(sigmoid_gradient(input_to_hidden))*w_gh'*diag(output_error)*sigmoid_gradient(w_gh*hidden_activation)*input(:,h)';
        dw_gh = (diag(sigmoid_gradient(w_gh*hidden_activation))*(desired_output-output_activation))*hidden_activation';
    end
        % Applying the weight changes
        w_fg = w_fg + dw_fg;
        w_gh = w_gh + dw_gh;
    
        % Finding the sum of squared errors
        sse = trace(output_error'*output_error);
    
    % Every 10 iterations, prints the epoch number and SSE value
    if mod(a,10)==0
        epoch_string = num2str(a);
        sse_num = num2str(sse);
        epoch_iterations = ['epoch:',epoch_string,' SSE:',sse_num];
        disp(epoch_iterations);
    end
    
    % plots the sse over time
%     plot(sse)
%     hold on
%     plot(sse)
    
    % Stops loop if sum of square error is < 0.01
    if sse < 0.01
        epoch_string = num2str(a);
        sse_num = num2str(sse);
        epoch_iterations = ['epoch:',epoch_string,' SSE:',sse_num];
        disp(epoch_iterations);
        break;
    end
end

% outputs if epoch reaches 1000 and sse is greater than 0.01
if sse > 0.01
        disp('Sorry, did not converge');
end


% hold off
imagesc(desired_output);
hold on
imagesc(output_activation)
% hold off

% New set of patterns
new_input = randweights(rows,columns)

% Checks the number of ones in the matrix
for j=1:columns
    for i=1:rows
       if new_input(j,i) == 1
           check_one = check_one + 1;
       end
    end
end

new_input_to_hidden = zeros(3,1);
for h=1:8
        new_temp = w_fg * input(:,h);
        new_input_to_hidden = new_input_to_hidden + new_temp;
    
        % Applying the sigmoid activation from input to hidden layers
        new_hidden_activation = activation(new_input_to_hidden);

        % Passing the activation from the hidden units to the output units
        new_input_to_output = w_gh * new_hidden_activation;

        % Determining output activity by passing the input to the output through
        % the activation function
        new_output_activation = activation(new_input_to_output);

        % Finding output error
        if mod(check_one,2)== 0
            new_desired_output = 1;
        end
        if mod(check_one,2)~= 0
            new_desired_output = 0;
        end
        % Error from a sweep
        new_output_error = new_desired_output - new_output_activation;
    
        % Finding the weight changes via sigmoid gradient
        dw_fg = diag(sigmoid_gradient(new_input_to_hidden))*w_gh'*diag(new_output_error)*sigmoid_gradient(w_gh*new_hidden_activation)*new_input(:,h)';
        dw_gh = (diag(sigmoid_gradient(w_gh*new_hidden_activation))*(new_desired_output-new_output_activation))*new_hidden_activation';
end
    new_sse = trace(new_output_error'*new_output_error)



