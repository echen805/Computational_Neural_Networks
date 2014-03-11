function [ inhibitory_weight ] = Make_inhibitory_weights( dim, max_strength, length_constant )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
inhibitory_weight=(-1)*max_strength*exp((-1)*(Distance(dim))/length_constant);
end

