
%global variables 

Dimensionality = 80;
HalfDimensionality = 40;
Number_of_iterations = 50;
Length_constant = 10.00;
Max_strength = abs(2.0);
Epsilon = 1e-1;
Upper_limit = 60;
Lower_limit = 0;

Initial_state_vector = zeros(Dimensionality,1);

%{
% 4.19 4.20 4.21 4.22 4.23
for i=1:20
    Initial_state_vector(i)=10;
end
for i=21:60
    Initial_state_vector(i)=40;
end
for i=61:80
    Initial_state_vector(i)=10;
end
%}

% Intial state vector for Winner-take-all
% For BIAS light level set initial to 10 instead of 0
% for win peaks just manually assign the initials to the graphs in book


% 4.26
Initial_state_vector(16) = 10;
Initial_state_vector(17) = 20;
Initial_state_vector(18) = 30;
Initial_state_vector(19) = 40;
Initial_state_vector(20) = 50;
Initial_state_vector(21) = 40;
Initial_state_vector(22) = 30;
Initial_state_vector(23) = 20;
Initial_state_vector(24) = 10;


%{
%4.27
Initial_state_vector = 10*ones(Dimensionality,1);
Initial_state_vector(17) = 20;
Initial_state_vector(18) = 30;
Initial_state_vector(19) = 40;
Initial_state_vector(20) = 50;
Initial_state_vector(21) = 40;
Initial_state_vector(22) = 30;
Initial_state_vector(23) = 20;
%}


%4.28/4.29 
% Initial_state_vector = 10*ones(Dimensionality,1);
% Initial_state_vector(14) = 20;
% Initial_state_vector(15) = 30;
% Initial_state_vector(16) = 20;
% Initial_state_vector(39) = 20;
% Initial_state_vector(40) = 30;
% Initial_state_vector(41) = 40;
% Initial_state_vector(42) = 30;
% Initial_state_vector(43) = 20;


State_vector=Initial_state_vector;


% creates distance matrix from one neuron to another
Distance=zeros();
for i=1:Dimensionality
    for j=1:Dimensionality
        dist=abs(i-j); % keep track of distance
        if dist > HalfDimensionality
            dist=Dimensionality-dist;
        end
        Distance(i,j)=dist;
    end
end


% compute inhibitory weights 

Inhibitory_weights=(-1)*Max_strength*exp((-1)*(Distance/Length_constant));


% For winner takes all method 
for i=1:Dimensionality 
   Inhibitory_weights(i,i) = 0;
end



%Compute inhibited state vector
    New_state_vector=zeros(Dimensionality,1);
for i=1:Number_of_iterations
    for j=1:Dimensionality;
    Error=Initial_state_vector(j)+(Inhibitory_weights(j,:)*State_vector)-State_vector(j);
    New_state_vector(j)=State_vector(j)+(Epsilon*Error);
    end
    
    
    %Limit state vector
    for k=1:Dimensionality
        if(New_state_vector(k)<Lower_limit)
            New_state_vector(k)=Lower_limit;
        
        elseif(New_state_vector(k)>Upper_limit)
            New_state_vector(k)=Upper_limit;
        end
    end
    
   State_vector = New_state_vector;
        
end
 
   
%Convergence Test 
%First we subtract the vectors and then compute the length of the new
%vector and test to see whether its greater than 1

 
Vector_difference = State_vector - Initial_state_vector;

vec_length = norm(Vector_difference);

if(vec_length>1)
    disp('Convergence test is successful')
end


y2=Initial_state_vector;
x=1:1:80;
y=New_state_vector;plot(y,x,'*',y2,x,'+');
    
    