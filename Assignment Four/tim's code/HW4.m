% DEFINITIONS
dim=80;
iterations=50;
% starting pattern
initial_state_vector=zeros(dim,1);
% current state of system
current_state_vector=zeros(dim,1); 
% weight of inhibition from a neuron some distance away from a target neuron
% inhibitory_weights=zeros(dim,1); 
% neuronal discharge is limited above and below
upper_limit=75;
lower_limit=0;
length_constant=2.00;
epsilon=1e-2;
% maximum inhibition, must absolute value to ensure it's always negative???
max_strength=abs(0.10);
inhibitory_weights=Make_inhibitory_weights(dim,max_strength,length_constant);
inhibited_state_vector=Compute_inhibited_state_vector(dim, iterations, inhibitory_weights, epsilon);

plot(y,x,r);



