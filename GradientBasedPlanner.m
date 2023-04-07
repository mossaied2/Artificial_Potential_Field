% Reviewe the file MovingAlongNegativeGradient.m to learn how move in the direction of grad(-f)

function route = GradientBasedPlanner (f, start_coords, end_coords, iterations)
% GradientBasedPlanner : This function plans a path through a 2D
% environment from a start to a destination based on the gradient of the
% function f which is passed in as a 2D array. The two arguments
% start_coords and end_coords denote the coordinates of the start and end
% positions respectively in the array while max_its indicates an upper
% bound on the number of iterations that the system can use before giving
% up.
% The output, route, is an array with 2 columns and n rows where the rows
% correspond to the coordinates of the robot as it moves along the route.
% The first column corresponds to the x coordinate and the second to the y coordinate

[gx, gy] = gradient (-f); 

%%% All of your code should be between the two lines of stars.
% *******************************************************************
route = start_coords;
Point_on_route = start_coords;
Speed = 3; % user selection - big value night lead the robot quickly to the goal but might lead to some bouncing (overshoot) as well
Tolerance = 1; % user selection - measures how close the robot from goal node - lower values means higher accuracy but slow solution 
while(iterations > 0)
    if(norm(end_coords - Point_on_route) < Tolerance)
        break;
    end
    delta_x = gx(floor(Point_on_route(2)), floor(Point_on_route(1)));
    delta_y = gy(floor(Point_on_route(2)), floor(Point_on_route(1)));
    
    % delta vector is both value and directions 
    delta = [delta_x, delta_y];
    
    % we need only the directions (the speed can be created as another parameter)
    delta_Direction_x = delta_x/norm(delta);
    delta_Direction_y = delta_y/norm(delta);
    
    new_route_x = Point_on_route(1) + Speed * delta_Direction_x ;
    new_route_y = Point_on_route(2) + Speed * delta_Direction_y;
    
    Point_on_route = [new_route_x, new_route_y];
    
    route = [route; Point_on_route];
    iterations = iterations - 1;
end
% *******************************************************************
end

