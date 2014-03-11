function [ A ] = new_A( f_vectors,g_vectors )
% creates the linear associator corrected for error
    % transposes the entire matrix of input vectors
    f_vectors_T = transpose(f_vectors);
    % creates the first associative matrix based on random selection
    random = randi(20,1);
    A = g_vectors(:,random)*f_vectors_T(random,:);
    disp('Matrix A ');
    disp(A);

    % generates a vector of error lengths until a criteria is met or enough
    % iterations have occurred
    errors = [];
    % used to keep track the number of iterations that has occured
    iteration = 1;
    % used to determine if the last pair of the sequence has been exceeded
    random2 = 0;

    % checks for convergence
    converge = 0;
    constant = 0;
    while converge == 0
       random2 = randi(20,1);
        % function creates the average error lengths from all sets of input based on
        % the current learning matrix
        avg_error = error_func(20,4,A,f_vectors, g_vectors);
        % pushes the average error length into a vector
        errors(iteration)= avg_error;
        % checks to see if the iterations have exceeded 1000 and checks for
        % convergence
        if iteration >1000
            if abs(errors(iteration)-errors(iteration-5)) < .0001*errors(iteration-5)
                converge = 1;
            end
        end
        % learns a new association through a new input
        g_prime = A*f_vectors(:,random2);
        % generates new error
        new_error = g_vectors(:,random2) - g_prime;
        % increases the iteration
        iteration = iteration + 1;
        % creates a difference matrix based on new input
        delta_A = new_error*f_vectors_T(random2,:);
        % applies a decreasing constant
        delta_A = delta_A/(iteration);
        % creates a new A
        A = A + delta_A;
    end
end

