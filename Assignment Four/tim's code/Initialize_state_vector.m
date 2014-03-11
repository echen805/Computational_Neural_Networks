function [ state_vector ] = Initialize_state_vector( dim )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
initial_state_vector=rand(dim,1);
for i=1:20
    initial_state_vector(i)=10;
end
for i=21:60
    initial_state_vector(i)=40;
end
for i=61:80
    initial_state_vector(i)=10;
end
state_vector=initial_state_vector;
end

