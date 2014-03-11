% Generating vectors f and g
f = rand(1,100)-0.5; %-0.5 causes the mean to be zero
g = rand(1,100)-0.5;

% Normalizing the vectors
f = f/norm(f);
g = g/norm(g);

% Computing linear associator, A
% Assuming the learning constant is 1
A = g * f'; % this is only one association?

% Testing to see if G' == G
g_prime = A*f;
g_prime = g_prime/norm(g_prime)

% Finding the cosine theta
theta = dot(g,g_prime);
theta = acos(theta)*180/pi; %putting it in degrees

length_gprime = norm(g_prime);

% Problem 2

% Generating a new normalized random vector, f'
f_prime = rand(1,100)-0.5;
f_prime = f_prime/norm(f_prime);

% Testing to see if orthogonal
theta2 = dot(f,f_prime);
theta2 = acos(theta2)*180/pi;

% Compute Af' and look at the length of the vector
    % it should be g which is in the same direction as g'?
test = A*f_prime;
length_test = norm(test);

% Problem 3

A_sum = [];
Fmatrix =[];
Gmatrix = [];

% Generates a matrix containing normalized vectors
for i=1:50
  % Generating random vectors  
  F_i = (rand(50,1)-0.5);
  G_i = (rand(50,1)-0.5);  
  F_i = F_i/norm(F_i);
  G_i =G_i/norm(G_i);
  
  % Placing vectors in matrix
  Fmatrix(:,i) = F_i;
  Gmatrix(:,i) = G_i;
  
  Ai= G_i*F_i';     % Uses outer product to find the linear association
  A_sum(i,:) = sum(Ai);
 
end

% Check to see if the matrix created is orthogonal to Fmatrix and Gmatrix
 GallPrime = A_sum*Fmatrix;
 GallPrime = GallPrime / norm(GallPrime);
 theta3 = dot(Gmatrix, GallPrime);
 theta3 = acos(theta3)*180/pi
 Length = length(GallPrime)
    
  
%New set of 50 random vectors to test selectivity 
%   for i=1:50
%       Ftest = (rand(50,1)-0.5);
%       Gtest = (rand(50,1)-0.5);  
%       Ftest = Ftest/norm(Ftest);
%       Gtest =Gtest/norm(Gtest);
%       
%       fnewall(:,i) = Ftest;
%       gnewall(:,i)=Gtest;
%   end
%   
%   gnewprime =A_sum*fnewall;
%   gnewprime = gnewprime /norm(gnewprime);
%   theta4 = dot(gnewprime, gnewall);
%   theta4 = acos(theta4)*180/pi
  
  %Repeat for different numbers of pairs of stored vectors 
  
  % One Pair - returns a complex double
%   F_one = (rand(1,1)-0.5);
%   G_one = (rand(1,1)-0.5);  
%   F_one = F_one/norm(F_one);
%   G_one =G_one/norm(G_one);
%   test_fnewall(:,i) = F_one;
%   test_gnewall(:,i)=G_one;
%   
%   gnewprime_test =A_sum*test_fnewall';
%   gnewprime_test = gnewprime_test /norm(gnewprime_test);
%   theta5 = dot(gnewprime_test, test_gnewall);
%   theta5 = acos(theta4)*180/pi
  
%   % 20 Pair
  for i=1:100
      F_twenty = (rand(100,1)-0.5);
      G_twenty = (rand(100,1)-0.5);  
      F_twenty = F_twenty/norm(F_twenty);
      G_twenty =G_twenty/norm(G_twenty);
      clear fnewall;
      clear gnewall;
      fnewall(:,i) = F_twenty;
      gnewall(:,i)=G_twenty;
  end
  
  gnewprime_test =A_sum*test_fnewall';
  gnewprime_test = gnewprime_test /norm(gnewprime_test);
  theta5 = dot(gnewprime_test, test_gnewall);
  theta5 = acos(theta4)*180/pi
%   
%   % 40 Pair
%   for i=1:40
%       F_forty = (rand(40,1)-0.5);
%       G_forty = (rand(40,1)-0.5);  
%       F_forty = F_forty/norm(F_forty);
%       G_forty =G_forty/norm(G_forty);
%       fnewall(:,i) = F_forty;
%       gnewall(:,i)=G_forty;
%   end

% Problem 4
