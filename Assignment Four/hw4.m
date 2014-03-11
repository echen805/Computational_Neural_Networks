% File appb.c, Program Lateral_inhibition */


%                              Appendix B
%               Lateral Inhibition Program from Chapter 4


%      This program simulates the simple lateral inhibition found
% in the eye of Limulus.  The program is designed to be easily modified,
% but is not very fast or efficient.  The basic program simulates a
% one-dimensional eye that wraps around, with 80 "receptors."  The initial
% pattern of excitation to the eye contains two step functions, as
% determined in Initialize_state_vector().  Inhibition from a unit to
% its neighbors is assumed to fall off exponentially with distance from
% the unit.  The program will prompt for the maximum strength of inhibition
% and the spatial extent of inhibition, which parameter determines  the
% space constant of the exponential fall off.  The program will also
% prompt for a parameter "epsilon" which controls the properties of the
% fixed point iteration used to compute the solution pattern for a given
% light distribution and system properties.  Epsilon determines speed of
% convergence of the numerical approximation used. If epsilon is too large,
% the system will become numerically unstable, will not converge and will
% "blow up."  If epsilon is too small, nothing bad will happen but the
% system may move very slowly toward the solution.  Only 50 iterations
% are used, so the solution may not be found.  A good initial value for
% epsilon is between 0.1 and 0.01.  It is obvious when things are not
% working right and this parameter is not critical.  In the Limulus the
% maximum inhibition observed experimentally is below 0.2; a reasonable
% length constant might lie between about 2 and 4.
% 
%      This version of the program uses self inhibition, that is, a
% unit inhibits itself, as is the case in the real animal.  For the
% simulations of Winner-Take-All (WTA) networks, the self-inhibition can be
% turned off by setting the self inhibition term in each unit to zero.  This
% is done by zeroing element [i] in the vector Inhibitory_weights[i] where
% i runs from 0 to Dimensionality-1, that is, Inhibitory_weights[i][i]=0.
% In the terminology of Chapter 5, the diagonal term of the connection
% matrix is set to zero.  For a good WTA network, both the space constant
% and the maximum value of the inhibition should be large.  The chapter
% uses some simple patterns, described there, as demonstrations.  */

Dimensionality = 80;
Number_of_iterations = 50;

% Prototypes for routines 
void Subtract_vectors(float Vector_1[], float Vector_2[], 
    float Vector_difference[]);
float Vector_length(float Vector_1[]);
float Inner_product(float Vector_1[], float Vector_2[]);
void Limit_state_vector(float Vector[]);
void Convergence_test(float New_state_vector[]);
void Initialize_parameters(void);
void Make_inhibitory_weights(void);
void Initialize_state_vector(void);
void Initialize_display(void);
void Display_state_vector(float Displayed_vector[], int Starting_element,
		    char Display_character);
void Compute_inhibited_state_vector(void);


% /*--------------------------------------------------------------------------
% Returns the length of a vector.
Argument
    float Vector_1[]            Vector, input
Returns
    float length                Magnitude of Vector_1
% --------------------------------------------------------------------------*/
float Vector_length(float Vector_1[]) {
    float Sum_of_Squares;       %/* Name says it all */
    int i;                      %/* loop index */

    Sum_of_Squares=0;
    for(i=0; i<Dimensionality; i++)
	Sum_of_Squares += Vector_1[i]*Vector_1[i];
    return (float)sqrt(Sum_of_Squares);
% }   /* Vector_length */



% /*--------------------------------------------------------------------------
% Forms the inner product of two vectors.
Arguments
    float Vector_1[]            One vector, input
    float Vector_2[]            Other vector, input
Returns
    float Inner_product         Vector_1 . Vector_2
% --------------------------------------------------------------------------*/
float Inner_product(float Vector_1[], float Vector_2[]) {
    float Sum_of_products;      /* Name says it all */
    int i;                      /* loop index */

    Sum_of_products=0;
    for(i=0; i<Dimensionality; i++)
	Sum_of_products += Vector_1[i]*Vector_2[i];
    return Sum_of_products;
% }   /* Inner_product */



% /*--------------------------------------------------------------------------
% Takes a vector, and constrains components to the range Lower_limit..
% Upper_limit.  The vector is modified.

Argument
    float Vector[]              Vector, input and output
% --------------------------------------------------------------------------*/
void Limit_state_vector(float Vector[]) {
    int i;                      /* loop index */

    for(i=0; i<Dimensionality; i++) {
	if(Vector[i]>Upper_limit) Vector[i]=Upper_limit;
	if(Vector[i]<Lower_limit) Vector[i]=Lower_limit;
    }
}   % Limit_state_vector 


% /*-----------------------------------------------------------------------
% This routine checks that New_state_vector-State_vector is properly
% normalized.  It prints a message if |New_state_vector-State_vector| > 1
% -----------------------------------------------------------------------*/
void Convergence_test(float New_state_vector[]) {
    float Difference[Dimensionality];

    Subtract_vectors(New_state_vector, State_vector, Difference);
    if(Vector_length(Difference)>1.0f) {
	GoToXY(1,1);
	printf("\nConverge_test: Convergence Problem\a\n");
	printf("Length difference between last iterations is %.2f\n",
		Vector_length(Difference));
    }
}   % Convergence_test 

% ALREADY MODIFIED IN HW4_FUNCTIONS
% /*-----------------------------------------------------------------------
% This routine initializes the following five global variabls.
% float Upper_limit;                   %Maximum firing rate of model neuron
% float Lower_limit;                   %Minimum firing rate of model neuron
% float Length_constant;               %Length constant of inhibition
% float Epsilon;                       %Constant
% float Max_strength;                  %Maximum value of inhibition
% % -----------------------------------------------------------------------*/
% void Initialize_parameters(void) {
%     ClrScr();
%     GoToXY(1,1);
%     printf("Lateral Inhibition Demonstration\n");
%     printf("Using a One Dimensional Circular Eye, with wraparound\n");
% 
%     printf("Enter Parameters of Lateral Inhibition\n\n");
%     printf("Inhibitory Maximum Strength (0.1 .. 2) : "); 
%     scanf("%f",&Max_strength);
%     Max_strength=(float)fabs(Max_strength);
%     printf("Inhibitory Length Constant (2..4) : "); 
%     scanf("%f",&Length_constant);
%     printf("Epsilon  (0.01..0.1) : ");        
%     scanf("%f",&Epsilon);
% 
%     Upper_limit=75;      % Neuron discharge is limited above and below 
%     Lower_limit=0;
% }   % Initialize_parameters 


% /*-----------------------------------------------------------------------
% Each row of the N x N weight matrix should contain an exponential
% distribution that falls off in both directions from a value of
% <Max_strength>.  Each row is considered circular, and in the first
% the peak occurs at position 0, in the second at position 1 etc.
% -----------------------------------------------------------------------*/
void Make_inhibitory_weights(void) {
    int i,j;            % loop indices 
    int Half_dimensionality;    % Dimensionality/2 

    % Make first vector 
    Half_dimensionality=Dimensionality/2;
    for(i=0; i<Half_dimensionality; i++)
	Inhibitory_weights[0][i]=-Max_strength * exp(-i/Length_constant);
    for(;i<Dimensionality; i++)
	Inhibitory_weights[0][i]=
	       -Max_strength * exp(-(Dimensionality-i)/Length_constant);

    % Shift elements right in each successive row of weights 
    for(i=0; i<Dimensionality-1; i++) {
	for(j=0; j<Dimensionality-1; j++)
	    Inhibitory_weights[i+1][j+1]=Inhibitory_weights[i][j];
	Inhibitory_weights[i+1][0]=Inhibitory_weights[i][Dimensionality-1];
    }
}   % Make_inhibitory_weights


% % /*-----------------------------------------------------------------------
% % The initial input is a rectangular pattern, changing from 10 to 40
% % at neuron 20 and 40 to 10 at neuron 60.
% % -----------------------------------------------------------------------*/
% void Initialize_state_vector(void) {
%     int i;              % loop index 
% 
%     for(i=0; i<Dimensionality/4; i++) Initial_state_vector[i]=10;
%     for(; i<3*Dimensionality/4; i++)  Initial_state_vector[i]=40;
%     for(; i<Dimensionality; i++)      Initial_state_vector[i]=10;
% 
%     for(i=0; i<Dimensionality; i++)
% 	State_vector[i]=Initial_state_vector[i];
% }   % Initialize_state_vector 

% ALREADY MODIFIED IN HW4_FUNCTIONS
% -----------------------------------------------------------------------
% This writes a four line header at the top of the screen.
% -----------------------------------------------------------------------
% void Initialize_display(void) {
%     ClrScr();
%     GoToXY(1,1);                 % Goes to upper left corner of screen 
%     printf("Initial state: +.  Final state: *\n");
%     printf("Parameters: Length Constant: %4.2f Maximum Inhibition: %4.2f\n",
% 	Length_constant,Max_strength);
%     printf("Neuron  |  Firing Rate: Spikes/Second |         |         |\n");
%     printf("        0........10........20........30........40........50\n");
% }   % Initialize_display 





% % /*-----------------------------------------------------------------------
% % See pp 105-125.
% % -----------------------------------------------------------------------*/
% void Compute_inhibited_state_vector(void) {
%     int i;      /* iteration number */
%     int j;      /* element, 0..Dimensionality-1 */
%     float New_state_vector[Dimensionality];
%     float Error; /* Difference between init_state+(weights.state) and state */
% 
%     for(i=0; i<Number_of_iterations; i++) {
% 	for(j=0; j<Dimensionality; j++) {
% 	    Error=Initial_state_vector[j] +
% 		Inner_product(Inhibitory_weights[j],State_vector) -
% 		State_vector[j];
% 	    New_state_vector[j]=State_vector[j] + Epsilon*Error;
% 	}
% 	Limit_state_vector(New_state_vector);
% 	if(i==Number_of_iterations) Convergence_test(New_state_vector);
% 	for(j=0; j<Dimensionality; j++)
% 	    State_vector[j]=New_state_vector[j];
%     }
% }   /* Compute_inhibited_state_vector */


