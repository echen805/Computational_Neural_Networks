function [weights] = randweights(rows,columns)
   weights = zeros(rows,columns);
   weights = round(rand(rows,columns));
end