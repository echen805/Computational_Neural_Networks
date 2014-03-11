% Uploading data from worksheet "Test_MaxTemp'
maxtemp = xlsread('UpdatedJanData','JanMax');
mintemp = xlsread('UpdatedJanData','JanMin');
precip = xlsread('UpdatedJanData','JanPrecip');

% z scores all variables
zmaxtemp(1,:) = zscore(maxtemp(1,:));
zmintemp(1,:) = zscore(mintemp(1,:));
zprecip(1,:) = zscore(precip(1,:));

% vert concatenates all variables into one column
input = vertcat(zmaxtemp,zmintemp,zprecip);

% Finds the number of dimensionalities in the columns
num_columns = length(input);

% Formula to create random within specific ranges [a,b]
% r = (b-a).*rand(num_of_rows,num_of_cols) + a;

% Creating the random matrix that connects input to hidden units
% Input is eight layers, hidden is two layers
min_range = -0.5;
max_range = 0.5;
w_fg = (max_range-min_range).*rand(2,3) + min_range;

% Creating the random matrix that connects hidden units to output
% hidden is two layers, output is one layer
w_gh = (max_range-min_range).*rand(1,2) + min_range;

sse = 100;
epoch = 1;
input_to_hidden = zeros(2,1);

% West == 1
% East == 0
for a=1:1000
    % Passing the activation from the input units to the hidden units
    % for loop only calculates one epoch
    for h=1:num_columns
        input_to_hidden = w_fg * input(:,h);
    
        % Applying the sigmoid activation from input to hidden layers
        hidden_activation = activation(input_to_hidden);

        % Passing the activation from the hidden units to the output units
        input_to_output = w_gh * hidden_activation;

        % Determining output activity by passing the input to the output through
        % the activation function
        output_activation = activation(input_to_output);
        
        % Total max/min temperatures
        zscoreTotal = zmaxtemp + zmintemp + zprecip;
        
        % Finding output error
        if zscoreTotal(:,h) < 0
            desired_output = 1;
        end
        if zscoreTotal(:,h) > 0
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
        sse(epoch) = trace(output_error'*output_error);
    
    % Every 10 iterations, prints the epoch number and SSE value
    if mod(a,10)==0
        epoch_string = num2str(a);
        sse_num = num2str(sse);
        epoch_iterations = ['epoch:',epoch_string,' SSE:',sse_num];
        disp(epoch_iterations);
    end
    
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



% HW5 OUTPUT PORTION
% % output generated for the new input for each of the 5 associations
% output1 = [];
% output2 = [];
% output3 = [];
% output4 = [];
% output5 = [];
% for i=1:20
%     output1(:,i) = A1*f_new(:,i);
%     output2(:,i) = A2*f_new(:,i);
%     output3(:,i) = A3*f_new(:,i);
%     output4(:,i) = A4*f_new(:,i);
%     output5(:,i) = A5*f_new(:,i);
% end
% 
% output = mean(cat(3,output1,output2,output3,output4,output5),3);
% 
% % final output is displayed in terms of their planets' arbitrary number
% planet = [];


% Comment out this part to see how it runs without the input. 
% for loop i moves to next column
% for i=1:num_columns
%     % Checks each column
%     for b=1:num_columns
%         if input(b,i) > 0
%             disp('West');
%         end
%         if input (b,i) < 0
%             disp('East');
%         end
%     end
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEW INPUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uploading data from worksheet "Test_MaxTemp'
maxtemp = xlsread('UpdatedJanData','TestJanMax');
mintemp = xlsread('UpdatedJanData','TestJanMin');
precip = xlsread('UpdatedJanData','TestJanPrecip');

% z scores all variables
zmaxtemp(1,:) = zscore(maxtemp(1,:));
zmintemp(1,:) = zscore(mintemp(1,:));
zprecip(1,:) = zscore(precip(1,:));

% vert concatenates all variables into one column
input = vertcat(zmaxtemp,zmintemp,zprecip);

% Finds the number of dimensionalities in the columns
num_columns = length(input);

% Formula to create random within specific ranges [a,b]
% r = (b-a).*rand(num_of_rows,num_of_cols) + a;

% Creating the random matrix that connects input to hidden units
% Input is eight layers, hidden is two layers
min_range = -0.5;
max_range = 0.5;
w_fg = (max_range-min_range).*rand(2,3) + min_range;

% Creating the random matrix that connects hidden units to output
% hidden is two layers, output is one layer
w_gh = (max_range-min_range).*rand(1,2) + min_range;

sse = 100;
epoch = 1;
input_to_hidden = zeros(2,1);

% West = 1
% East = 0
for a=1:1000
    % Passing the activation from the input units to the hidden units
    % for loop only calculates one epoch
    for h=1:num_columns
        input_to_hidden = w_fg * input(:,h);
    
        % Applying the sigmoid activation from input to hidden layers
        hidden_activation = activation(input_to_hidden);

        % Passing the activation from the hidden units to the output units
        input_to_output = w_gh * hidden_activation;

        % Determining output activity by passing the input to the output through
        % the activation function
        output_activation = activation(input_to_output);
        
        % Total max/min temperatures
        zscoreTotal = zmaxtemp + zmintemp + zprecip;
        
        % Finding output error
        if zscoreTotal(:,h) < 0
            desired_output = 1;
        end
        if zscoreTotal(:,h) > 0
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
        sse(epoch) = trace(output_error'*output_error);
    
    % Every 10 iterations, prints the epoch number and SSE value
    if mod(a,10)==0
        epoch_string = num2str(a);
        sse_num = num2str(sse);
        epoch_iterations = ['epoch:',epoch_string,' SSE:',sse_num];
        disp(epoch_iterations);
    end
    
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
