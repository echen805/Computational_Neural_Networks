% HW 4 

% Global Variables
Upper_limit = 60;             %Maximum firing rate of model neuron
Lower_limit = 0;              %Minimum firing rate of model neuron
Length_constant = 2.00;          %Length constant of inhibition
Epsilon = 0.1;                %Constant
Max_strength = abs(0.1);        %Maximum value of inhibition
Dimensionality = 80;
node_diff = zeros(Dimensionality,1);
New_state_vector = zeros(Dimensionality,1);
Number_of_iterations = 50;
% Inhibitory_weights = zeros(Dimensionality,1);
Half_dimensionality=Dimensionality/2;
Initial_state_vector = zeros(Dimensionality,1);
% State_vector = zeros(Dimensionality,1);

%Initialize_parameters(void)
disp('Lateral Inhibition Demonstration');
disp('Using a One Dimensional Circular Eye, with wraparound');
disp('Enter Parameters of Lateral Inhibition');
disp('Inhibitory Maximum Strength (0.1 .. 2) : '); 
disp('Inhibitory Length Constant (2..4) : '); 
disp('Epsilon  (0.01..0.1) : ');        

% Figures out the distance
distance=zeros();
for i=1:Dimensionality
    for j=1:Dimensionality
        dist=abs(i-j);          % accounts for both directions
        if dist > Half_dimensionality
            dist=Dimensionality-dist;
        end
        distance(i,j)=dist;
    end
end

% /*-----------------------------------------------------------------------
% The initial input is a circular pattern, changing from 10 to 40
% at neuron 20 and 40 to 10 at neuron 60.
% -----------------------------------------------------------------------*/

% for simple lateral netowrks 

% for i=1:20
%    Initial_state_vector(i)=10;
% end
% for i=21:60
%     Initial_state_vector(i)=40;
% end
% for i=61:80
%     Initial_state_vector(i)=10;
% end
% State_vector = Initial_state_vector;

% Winner take all networks
Initial_state_vector(16) = 10;
Initial_state_vector(17) = 20;
Initial_state_vector(18) = 30;
Initial_state_vector(19) = 40;
Initial_state_vector(20) = 50;
Initial_state_vector(21) = 40;
Initial_state_vector(22) = 30;
Initial_state_vector(23) = 20;
Initial_state_vector(24) = 10;



   
% Initialize_display 
% -----------------------------------------------------------------------
% This writes a four line header at the top of the screen.
% -----------------------------------------------------------------------
disp('Initial state: +.  Final state: *');
disp('Parameters: Length Constant: 2 Maximum Inhibition: 2');
disp('Neuron  |  Firing Rate: Spikes/Second |         |         |');
disp('        0........10........20........30........40........50');


% /*-----------------------------------------------------------------------
% Each row of the N x N weight matrix should contain an exponential
% distribution that falls off in both directions from a value of
% <Max_strength>.  Each row is considered circular, and in the first
% the peak occurs at position 0, in the second at position 1 etc.
% -----------------------------------------------------------------------*/

% Make first vector 
% Inhibitory_weights=(-1)*Max_strength * exp((-1)*distance/Length_constant);

% Winner takes all inhibition
for i=1:Dimensionality 
   Inhibitory_weights(i,i) = 0;
end


% void Compute_inhibited_state_vector(void) {
%     i;      %/* iteration number */
%     j;      %/* element, 0..Dimensionality-1 */
    
%     Error;  %/* Difference between init_state+(weights.state) and state */

for i=1:Number_of_iterations
    for j= 1:Dimensionality
        Error=Initial_state_vector(j) + (Inhibitory_weights(j,:)*Initial_state_vector) -State_vector(j);
        New_state_vector(j)=State_vector(j) + (Epsilon*Error);
    end
        
% Limit_state_vector(New_state_vector);
    for h = 1:Dimensionality
        if (New_state_vector(h)>Upper_limit)
            New_state_vector(h) = Upper_limit;
        elseif (New_state_vector(h) < Lower_limit)
            New_state_vector(h) = Lower_limit;
        end
    end
%     State_vector = New_state_vector;
end
  
% /*-----------------------------------------------------------------------
% This routine checks that New_state_vector-State_vector is properly
% normalized.  It prints a message if |New_state_vector-State_vector| > 1
% -----------------------------------------------------------------------*/
% void Convergence_test(float New_state_vector[]) {
    
% Convergence Test
% Subtract_vectors(New_state_vector, State_vector, Difference);
for i=1:Dimensionality    
    node_diff(i) = New_state_vector(i) - State_vector(i);
end

% Calculating vector length
Sum_of_Squares=0;
for i=1:Dimensionality
    Sum_of_Squares = Sum_of_Squares + (node_diff(i) * node_diff(i));
end

if(Sum_of_Squares >1.0)
	disp('Hooray, there is a convergence between the two vectors');
end
  
y2=Initial_state_vector;
x=1:1:80;
y=New_state_vector;
plot(y,x,'*',y2,x,'r+');

  

   