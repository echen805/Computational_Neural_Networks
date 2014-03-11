for i = 1: 1000
   %Generating random vectors
    a =rand(1,100)-0.5;
    b =rand(1,100)-0.5;
   %Generating uniform random vectors
    x_temp = a-mean(a);
    y_temp = b-mean(b);
    
    x = x_temp/norm(x_temp);
    y = y_temp/norm(y_temp);
    
    dot_product(i)= dot(x, y);
end
hist(dot_product,1000000);
mean(dot_product)
std(dot_product)
