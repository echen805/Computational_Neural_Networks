function [ d ] = Distance(dim)

% need 0's across diaganols, also distance increases then starts decreasing
% in middle back to 0 as ends of circle neurons meet

d=zeros();
for i=1:dim
    for j=1:dim
        dist=abs(i-j); % keep track of distance
        if dist > dim/2
            dist=dim-dist;
        end
        d(i,j)=dist;
    end
end

% input dimension, minimum bound, maximum bounds



        
        
        



end

