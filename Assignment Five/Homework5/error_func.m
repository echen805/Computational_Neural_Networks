function [ avg_error ] = error_func(pair_amount, random_amount,A, f_vectors, g_vectors )
% takes an outerproduct and generates the average error based on the rest
% of the pairs
all_errors = [];
% takes the error created with every association with this matrix
for i= 1:pair_amount
    g_prime = A*f_vectors(:,i);
    error = g_vectors(:,i) - g_prime;
    all_errors (:,i) = error;
end
% takes the magnitude of every error
mag_sqrd_vector = [];
for j= 1:pair_amount
        mag_sqrd = 0;
        for b=1:random_amount
            mag_sqrd = mag_sqrd + all_errors(b,j)^2;
        end
        mag = sqrt(mag_sqrd);
        mag_sqrd_vector (j) = mag;
end
% finds the average error
total_error = 0;
    for k=1:pair_amount
        total_error = total_error + mag_sqrd_vector(k);
    end
    avg_error = total_error/pair_amount;

end

