function [ new_state_vector ] = Limit_state_vector( new_state_vector, min_bound, max_bound, dim )
% if max_bound is 100 and you have 400, change that to 100
for i=1:dim
    if new_state_vector(i)<min_bound
        new_state_vector(i)=min_bound;
    elseif new_state_vector(i)>max_bound
        new_state_vector(i)=max_bound;
    end
end
        
%x(x<L) everytime it's inside vector that's less than L, give me that
%indices
end

