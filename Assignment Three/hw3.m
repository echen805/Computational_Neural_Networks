%Problem One

%Global Variables
dimensions = 200;
iterations = 25;

% Creating linear associator 
A = zeros(dimensions,dimensions);
Fmatrix =zeros(dimensions,1);
Gmatrix = zeros(dimensions,1);


% ORIGINAL LINEAR ASSOCIATOR
for i=1:iterations
  % Generating random vectors 
  
  % Setting mean to zero
  F_set = (rand(dimensions,1)-0.5); 
  G_set = (rand(dimensions,1)-0.5);  
  % Normalizing vector
  F_set = F_set/norm(F_set); 
  G_set =G_set/norm(G_set);
  
  % Placing vectors in matrix
  Fmatrix(:,i) = F_set;
  Gmatrix(:,i) = G_set;
  
  Ai= G_set*F_set';     % Uses outer product to find the linear association
  A = A + Ai;           % Adding association to linear associator A
 
end


% Check to see if the matrix created is orthogonal to Fmatrix and Gmatrix
    % dot product G1_prime with the individual elements of the G_matrix in
    % a loop. Theta should be getting bigger with more iterations to
    % indicate deteriorations
%theta_values_g_prime = zeros(iterations,1);
for h=1:iterations    
    GPrime = A*Fmatrix(:,h);
    GPrimenorm = GPrime / norm(GPrime);
    costheta_gprime = dot(GPrimenorm,Gmatrix(:,h));
    %theta_g_prime(h) = acosd(costheta_gprime);
    Length = norm(GPrime);
end

%newGprime = A * Fmatrix; % dont modify the original GPrime
%difference = Gmatrix - newGprime;
 % Error Correcting Procedure
 
 % Tapering the learning constant
 %n = 5; % n is just the number of learning trials
 %k = 1/n;
 
 % Learning Constant
 % for individual elements, not entire vectors
 %k = 1/(Fmatrix'*Fmatrix)
 
 
 
 % Grab random associated pair from original linear associator A
    %can't use for loop because it'll grab pairs sequentially
    
    CopyFmatrix = Fmatrix;
    vector_shuffle = randperm(25); 
    CopyFmatrix = CopyFmatrix(:,vector_shuffle);
    
 % gradient descent is g - g'
 % g is what we want, g' is what we got
 
 %deltA = k(g-g')f' is the error correcting 
 

 % Initializing vectors
deltA = zeros(dimensions,dimensions);
grad_descent = zeros(200,25);
%newA = zeros(dimensions,dimensions);
newA = A;
GprimeMatrix = zeros(dimensions,dimensions);


% Constructing new A with delta A
k = 1;
GprimeMatrix = A*Fmatrix;
 for u=1:iterations
    grad_descent(:,u) = Gmatrix(:,u)-GprimeMatrix(:,u);
    deltA = k*(grad_descent(:,u))*CopyFmatrix(:,u)';
    error(:,u) = norm(grad_descent(:,u));
    newA = newA + deltA;
    plot(grad_descent(:,u))
 end

% Testing to see if the new linear associator works
GprimeNorm1 = GprimeMatrix / norm(GprimeMatrix,1);
for u=1:iterations
   costheta(:,u) = dot(Gmatrix(:,u),GprimeNorm1(:,u));
   newtheta(:,u) = acosd(costheta(:,u));
end



%{
k = 3;
GprimeMatrix = A*Fmatrix;
 for u=1:600
    r = round(unifrnd(1,25));
    grad_descent(:,r) = Gmatrix(:,r)-GprimeMatrix(:,r);
    error(:,r) = norm(grad_descent(:,r);
    deltA = k*(grad_descent(:,r))*Fmatrix(:,r)';
    newA = newA + deltA;
    plot(error)
 end
%}
 
 
 % Testing to see if the new linear associator works
GprimeNorm1 = GprimeMatrix / norm(GprimeMatrix,1);
for u=1:600
   costheta(:,iterations) = dot(Gmatrix(:,iterations),GprimeNorm1(:,iterations));
   newtheta(:,iterations) = acosd(costheta(:,iterations));
end




 % to figure out how long it takes to converge, get the error difference
 % between each individual gprime from the original A and gprime from the new A
 % with delta A integrated and compare that with original gprime from A and
 % original g
 
 