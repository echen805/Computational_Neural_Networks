%Plots a normal distribution curve

for z = 1: 12
%Creates a normally distributed variable

%Creates a random set of 100 numbers in the range of 1-20
r = 20*rand(1,100);
%Finds the mean of the data set
temp = mean(r);
%Calculates the sum of all 100
sum_total(z) = sum(temp);
end
%Plots a histogram of the normally distributed variables
hist(sum_total);

%Comparing values to an actual normal distribution
mean(sum_total)
median(sum_total)
mode(sum_total)
std(sum_total)