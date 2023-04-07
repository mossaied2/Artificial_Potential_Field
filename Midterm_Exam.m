clear all
close all
%% Artifical Potential Field 1D example
% assume very simple example of one dimentional map (robot move in one directon, e.g. along X)

% The map is very simple with only 3 obstacles at x=30, x=60, x=90 
x = 1:1:100;  
goal = 55;
start = 35;

%% construct the map (Present for you)
map( --- ) = --- ; % 1D map, what a simple one! (4 points)
map( --- ) = ---; % 1D map, 1 obstacle at x=30 (4 points)
map( --- ) = ---; % 1D map, 1 obstacle at x=60 (4 points)
map( --- ) = ---; % 1D map, 1 obstacle at x=90 (4 points)

%% calculate distance between each point and its closest obstacle 
%d = bwdist(map); % run first with the matlab builtin bwdist
%d = bwdist_1D(map); % implement bwdist yourself (4 points)
d = [29    28    27    26    25    24    23    22    21    20    19    18    17    16    15    14    13    12    11    10     9     8 ...
     7     6     5     4     3     2     1     0     1     2     3     4     5     6     7     8     9    10    11    12    13    14 ...
    15    14    13    12    11    10     9     8     7     6     5     4     3     2     1     0     1     2     3     4     5     6 ...
     7     8     9    10    11    12    13    14    15    14    13    12    11    10     9     8     7     6     5     4     3     2 ...
     1     0     1     2     3     4     5     6     7     8     9    10];
%% attractive force desgin
zeta = 3;  
fa = -----;    % attraction force (2 points)

%% repulsive force design
d0 = 30;
Rho = -----; % 1 should be added to avoid possible division by zero later (2 points)
Eta = ---- ; % try value < 10000, finetune this parameter to get good precsion (2 points)
fr = Eta*((1./Rho - 1/d0).^2);
fr (------) = 0; % be sure fr = 0 for ditances > d0 (2 points)

%% Total force 
f = ------; % (2 points)

%% ploting forces
figure
plot(x,fr,'r-')
grid on
hold on
plot(x,fa,'b-')
hold on
plot(x,f,'k-')
hold off
legend('fr','fa','f','Fontsize',20)

%% algorithm starts here
iterations = 1000;
Tolerance = 1;
Speed = -----; % fine tune this paramter to get good precision  (2 points)
current_position = -------;  % current position of the robot along the route (2 points)
route = [--------------];  % this array will contain all points the robot will pass thorugh (2 points)

grad_x = -1 .* gradient(-------); % you need the gradient (2 points)

figure
hold on
plot (x,grad_x, 'b.');
hold off

hold on
plot (goal,0, 'go');
hold off
    
grid on

while (iterations > 0 && abs(current_position - goal) > Tolerance)
    
    delta_x = grad_x(----------); % dx (2 points)
     
    % we need only the directions (the speed can be created as another parameter)
    delta_Direction_x = delta_x/norm(delta_x); % only get the sign; either positive or negative 
    
    new_route_x = ----------- + ------- * -----------; % new position of the robot (6 points)
    
    current_position = ----------; % update current position of robot (2 points)
    
    hold on
    plot (new_route_x,0, 'r*');
    hold off
    
    route = ---------; % update the route (2 points)
    iterations = iterations - 1; 
end 

route

