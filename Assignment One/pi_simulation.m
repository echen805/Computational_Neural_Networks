% Generates pi

% Counts the number of times the coordinates falls in the circle
count = 0;
total = 1000000;
for i=1:total
% Creates random x and y points
a = -1; b = 1; x = (b-a).*rand(1)-1;
a = -1; b = 1; y = (b-a).*rand(1)-1;

%Tests to see if coordinate is within circle
if x^2 + y^2 <= 1
    count = count + 1;
end
end
piSimulation = 4 * (count/total)
difference = pi - piSimulation