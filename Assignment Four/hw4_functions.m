% HW 4 

% Global Variables
Upper_limit = 75;             %Maximum firing rate of model neuron
Lower_limit = 0;              %Minimum firing rate of model neuron
Length_constant = 2;          %Length constant of inhibition
Epsilon = 1e -2;               %Constant
Max_strength = abs(0.1);           %Maximum value of inhibition
Dimensionality = 80;


% /*-----------------------------------------------------------------------
% The initial input is a rectangular pattern, changing from 10 to 40
% at neuron 20 and 40 to 10 at neuron 60.
% -----------------------------------------------------------------------*/
% void Initialize_state_vector(void) 
% i;              % loop index 

for i=0:Dimensionality
   State_vector[:,i]=Initial_state_vector[i];
end
   % Initialize_state_vector 





%Initialize_parameters(void)
disp('Lateral Inhibition Demonstration\n');
disp('Using a One Dimensional Circular Eye, with wraparound\n');
disp('Enter Parameters of Lateral Inhibition\n\n');
disp('Inhibitory Maximum Strength (0.1 .. 2) : '); 
%     scanf("%f",&Max_strength);
% Max_strength= fabs(Max_strength);
disp('Inhibitory Length Constant (2..4) : '); 
disp('Epsilon  (0.01..0.1) : ');        
   
   
   
% Initialize_display 
% -----------------------------------------------------------------------
% This writes a four line header at the top of the screen.
% -----------------------------------------------------------------------
    disp('Initial state: +.  Final state: *\n');
    disp('Parameters: Length Constant: %4.2f Maximum Inhibition: %4.2f\n');
    disp(Length_constant,Max_strength);
    disp('Neuron  |  Firing Rate: Spikes/Second |         |         |\n');
    disp('        0........10........20........30........40........50\n');






% /*--------------------------------------------------------------------------
% Plots values of 19 successive elements of a vector, one per line.  Each
% element is the firing rate of a neuron.
% 
% Arguments
%     float Displayed_vector[]    Vector, input
%     int Starting_element        First element to be displayed
%     char Display_Character      Character used in plotting
% Returns
%     float Inner_product         Vector_1 . Vector_2
% --------------------------------------------------------------------------*/
% void Display_state_vector(float Displayed_vector[], int Starting_element,
% 		    char Display_character) {
%     i;               % loop index 
    Row,Column;      % plot location, 1..25, 1..80 
    Displayed_vector[];

    for i=Starting_element:Starting_element + 18
        Row=5+i-Starting_element;
%         GoToXY(1,Row); printf("%5d",i+1);
        Display_vector[1,Row];
        Column=(Displayed_vector[i]+0.5) + 9;
        GoToXY(Column,Row); 
        disp('%c",Display_character');
    end
%  }   /% Display_state_vector %/






% /*-----------------------------------------------------------------------
% This routine checks that New_state_vector-State_vector is properly
% normalized.  It prints a message if |New_state_vector-State_vector| > 1
% -----------------------------------------------------------------------*/
% void Convergence_test(float New_state_vector[]) {
    Difference[Dimensionality];

    Subtract_vectors(New_state_vector, State_vector, Difference);
    if(Vector_length(Difference)>1.0f) {
	GoToXY(1,1);
	printf("\nConverge_test: Convergence Problem\a\n");
	printf("Length difference between last iterations is %.2f\n",
		Vector_length(Difference));
    }
}   % Convergence_test 








% /*-----------------------------------------------------------------------
% See pp 105-125.
% -----------------------------------------------------------------------*/
% void Compute_inhibited_state_vector(void) {
%     i;      %/* iteration number */
%     j;      %/* element, 0..Dimensionality-1 */
    New_state_vector[Dimensionality];
    Error;  %/* Difference between init_state+(weights.state) and state */

    for i=0:Number_of_iterations
        for j= 0:Dimensionality
            Error=Initial_state_vector[j] + Inhibitory_weights[j]'*State_vector -State_vector[j];
            New_state_vector[j]=State_vector[j] + Epsilon*Error;
        end
        Limit_state_vector(New_state_vector);
        if i==Number_of_iterations 
            Convergence_test(New_state_vector);
        end
        for j=0:Dimensionality
                State_vector[j]=New_state_vector[j];
            
        end
    end
  %/* Compute_inhibited_state_vector */
  
  
  
  
  
% /*-----------------------------------------------------------------------
% Each row of the N x N weight matrix should contain an exponential
% distribution that falls off in both directions from a value of
% <Max_strength>.  Each row is considered circular, and in the first
% the peak occurs at position 0, in the second at position 1 etc.
% -----------------------------------------------------------------------*/
% void Make_inhibitory_weights(void) {
%     i,j;            % loop indices 
    Half_dimensionality;    % Dimensionality/2 

    % Make first vector 
    Half_dimensionality=Dimensionality/2;
    for i=0:Half_dimensionality
        Inhibitory_weights[0,i]=(-1)Max_strength * exp((-1)i/Length_constant);
    end
    for i=0:Dimensionality
        Inhibitory_weights[0,i]=(-1)Max_strength * exp((-1)(Dimensionality-i)/Length_constant);
    end
    % Shift elements right in each successive row of weights 
    for i=0:Dimensionality-1
        for j=0:Dimensionality-1
            Inhibitory_weights[i+1,j+1]=Inhibitory_weights[i,j];
        end
	Inhibitory_weights[i+1,:]=Inhibitory_weights[i][Dimensionality-1];
    end
    
   % Make_inhibitory_weights
   