clear all
close all
%% moving a long -gradient(f)
% assume very simple example of one dimentional map (robot move in one directon, e.g. along X)

x = 1:1:100;
goal = 50;
f = (x - goal).^2;
plot(x,f,'r-')

iterations = 1000;
Tolerance = 1; % abs(x - xg) must be < Tolerance to terminate the loop

Speed = 10; % Try multiple values of this parameter and notice how the solution will approach the goal each time 
            % generally higher values will lead the robot fster toward the goal but may bounce around with very high error 
            % smaller values however will lead the robot slowely but would reach the goal with less erros with smaller bouncing
            % For example if speed is 35, the robot will just bounce with very high error 

start = 80;  % To understand more the physics try once with start on right of the goal,
            % e.g. start = 90, and another time with start on the left of the goal.
            % e.g. start = 1. Notice each time the direction of the motion and compare
            % it to grad(-f)

hold on
plot (start,0, 'r*');
hold off

current_position = start;
route = [current_position];

grad_x = -1 .* gradient(f); % grad_x = -2 * (x-50)

hold on
plot (x,grad_x, 'b.');
hold off

hold on
plot (goal,0, 'go');
hold off
    
grid on

while (iterations > 0)
    
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
    
    if(abs(current_position - goal) <= Tolerance)
        break
    end
end 

route

