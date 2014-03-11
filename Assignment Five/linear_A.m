function [ A ] = linear_A( f_vectors,g_vectors )
% creates the linear associator corrected for error
    % transposes the entire matrix of input vectors
    f_vectors_T = transpose(f_vectors);
    % creates the first associative matrix based on random selection
    random = randi(20,1);
    A = g_vectors(:,random)*f_vectors_T(random,:);

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
       
        % Creates the average error lengths from all sets of input based on
        % the current learning matrix
        all_errors = [];
        % takes the error created with every association with this matrix
        for i= 1:20
            g_prime = A*f_vectors(:,i);
            error = g_vectors(:,i) - g_prime;
            all_errors (:,i) = error;
        end
        % takes the magnitude of every error
        mag_sqrd_vector = [];
        for i= 1:20
                mag_sqrd = 0;
                for j=1:4
                    mag_sqrd = mag_sqrd + all_errors(j,i)^2;
                end
                mag = sqrt(mag_sqrd);
                mag_sqrd_vector (i) = mag;
        end
        % finds the average error
        total_error = 0;
            for k=1:20
                total_error = total_error + mag_sqrd_vector(k);
            end
            avg_error = total_error/20;
        
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

