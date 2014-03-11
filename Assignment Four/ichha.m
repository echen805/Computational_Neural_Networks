% Intialize Parameters 

Dimensionality = 80;
HalfDimensionality = 40;
Number_of_iterations = 50;
Length_constant =2.00;
Max_strength = abs(2);
Epsilon = 1e-2;
Upper_limit = 60;
Lower_limit =0;

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
Initial_state_vector=zeros(Dimensionality,1);
for i=1:20
    Initial_state_vector(i)=10;
end
for i=21:60
    Initial_state_vector(i)=40;
end
for i=61:80
    Initial_state_vector(i)=10;
end
State_vector=Initial_state_vector;

% compute inhibitory weights 

Inhibitory_weights=(-1)*Max_strength*exp((-1)*(Distance/Length_constant));

% Compute inhibited state vector
    New_state_vector=zeros(Dimensionality,1);
for i=1:Number_of_iterations
    for j=1:Dimensionality;
    Error=Initial_state_vector(j)+(Inhibitory_weights(j,:)*Initial_state_vector)-State_vector(j);
    New_state_vector(j)=State_vector(j)+(Epsilon*Error);
    end
    
    % Limit state vector
    for k=1:Dimensionality
        if(New_state_vector(k)<Lower_limit)
            New_state_vector(k)=Lower_limit;
        
        elseif(New_state_vector(k)>Upper_limit)
            New_state_vector(k)=Upper_limit;
        end
    end
    
        
end
        Current_state_vector=zeros(Dimensionality,1);
    for p=1:Dimensionality
        Current_state_vector(p)=New_state_vector(p); 
    end

% Convergence Test 
% Starts with subtracting vectors
    for i=1:Dimensionality
        Vector_difference(i)=New_state_vector(i) - State_vector(i);
    end
    
% Then compute vector length and pass vector difference 

Sum_of_Squares=0;
for i=1:Dimensionality
    Sum_of_Squares = Sum_of_Squares + (Vector_difference(i)*Vector_difference(i));
end
Vector_length = sqrt(Sum_of_Squares);

if(Vector_length>1)
    disp('Convergence test says we have converged!')
    
end

y2=Initial_state_vector;
x=1:1:80;y=New_state_vector;plot(y,x,'r*',y2,x,'g+');
    
    