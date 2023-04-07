clear all
close all
%% Artifical Potential Field 1D example
% assume very simple example of one dimentional map (robot move in one directon, e.g. along X)

% The map is very simple with only 3 obstacles at x=30, x=60, x=90 
x = 1:1:100;  
goal = 55;
start = 35;


% construct the map 
map(x)=false; % 1D map, what a simple one!
map(30)=true; % 1D map, 1 obstacle at x=1
map(60)=true; % 1D map, 1 obstacle at x=1
map(90)=true; % 1D map, 1 obstacle at x=1
%d = bwdist(map);
%d = bwdist_1D_Solution(map)
d = [29    28    27    26    25    24    23    22    21    20    19    18    17    16    15    14    13    12    11    10     9     8 ...
     7     6     5     4     3     2     1     0     1     2     3     4     5     6     7     8     9    10    11    12    13    14 ...
    15    14    13    12    11    10     9     8     7     6     5     4     3     2     1     0     1     2     3     4     5     6 ...
     7     8     9    10    11    12    13    14    15    14    13    12    11    10     9     8     7     6     5     4     3     2 ...
     1     0     1     2     3     4     5     6     7     8     9    10];
     
zeta = 3;
fa = zeta*(x - goal).^2;
max(max(fa))

d0 = 30;
Rho = d + 1; % 1 is added to avoid possible division by zero later
Eta = 3000; % try it with 1, you will find that fr is neglible so we need to fine tune that paramter
fr = Eta*((1./Rho - 1/d0).^2);
fr (Rho > d0) = 0;
max(max(fr))

f = fr + fa;
figure
plot(x,fr,'r-')
grid on
hold on
plot(x,fa,'b-')
hold on
plot(x,f,'k-')
hold off
legend('fr','fa','f','Fontsize',20)


iterations = 1000;
Tolerance = 1;
Speed = 1; % if speed is 35, the robot will just bounce with very high error 
current_position = start;
route = [current_position];

grad_x = -1 .* gradient(f);

figure
hold on
plot (x,grad_x, 'b.');
hold off

hold on
plot (goal,0, 'go');
hold off
    
grid on

while (iterations > 0 && abs(current_position - goal) > Tolerance)
    
    delta_x = grad_x(floor(current_position));
     
    % we need only the directions (the speed can be created as another parameter)
    delta_Direction_x = delta_x/norm(delta_x); % only get the sign; either positive or negative 
    
    new_route_x = current_position + Speed * delta_Direction_x;
    
    current_position = new_route_x
    
    hold on
    plot (new_route_x,0, 'r*');
    hold off
    
    
    route = [route; current_position];
    iterations = iterations - 1;
end 

route

