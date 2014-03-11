function [ new_state_vector ] = Compute_inhibited_state_vector( dim, iterations, inhibitory_weights, epsilon )
% Compute inhibited state vector
initial_state_vector=Initialize_state_vector(dim);
disp(initial_state_vector)
current_state_vector=initial_state_vector;
new_state_vector=zeros(dim,1);
%inhibitory_weights=Make_inhibitory_weights(dim,max_strength,length_constant);

for i=1:iterations
    for j=1:dim
        difference=initial_state_vector(j)+(inhibitory_weights(j,:)*current_state_vector)-current_state_vector(j);
        new_state_vector(j)=current_state_vector(j)+(epsilon*difference);            
    end 
    new_state_vector=Limit_state_vector(new_state_vector,0,60, dim);
    for j=1:dim
        current_state_vector(j)=new_state_vector(j);
    end     
end
end

