%
% PotentialFieldScript.m
%
clear all
close all
%% Generate some points

nrows = 400;
ncols = 600;

obstacle = false(nrows, ncols);

[x, y] = meshgrid (1:ncols, 1:nrows); % remember that x is corresponding to cols while y is corresponding to rows

%% Generate some obstacle (Reviewe the file CircularObstacle.m to understand this section)

obstacle (300:end, 100:250) = true; % rectangular obstacle
obstacle (150:200, 400:500) = true; % rectangular obstacle

t = ((x - 200).^2 + (y - 50).^2) < 50^2; % circular obstacle (XC=200, YC=50, R=50)
obstacle(t) = true;

t = ((x - 400).^2 + (y - 300).^2) < 100^2; % circular obstacle (XC=400, YC=300, R=50)
obstacle(t) = true;

%% Compute distance transform 
%Reviewe the file DistanceFromObstacle.m to understand bwdist function
%Reviewe the file ScalingFactor.m to understand why we neeed a scaling factor K

d = bwdist(obstacle); % bwdist function in matlab that return distance from any "true" element in obstacle array

% Rescale and transform distances
K = 100; % user preference   
Rho = d / K + 1;  % some values in d are zeros and will be problematic in caluclating the repulsive force so we need to add one to all values to avoid division by 0

d0 = 2; % user preference. If robot away from the obstacle by more than d0 then the repulsive force of that obstacle is considered 0
Eta = 1200; % user preference - Fine tuning parameter - Used to control streb=ngth of repulsive force  
            % If Eta = 1 max(repulsive) = 0.25 and max(attractive) = 400
            % Large Eta will create some balance between repuylsive and attaractive force value 
            % we need to make repulsive large otherwise the robot will not avoid the obstacles becuase repulsive force might be neglibile  

repulsive = Eta*((1./Rho - 1/d0).^2); % same equation in the slides 

repulsive (Rho > d0) = 0;
max(max(repulsive))

%% Display repulsive potential

figure;
m = mesh (repulsive);
m.FaceLighting = 'phong';
axis equal;

title ('Repulsive Potential');

%% Compute attractive force
% Reviewe the file QuadraticEquations.m to understand why we use quadratic function to play as attractive force

goal = [400, 50];

zeta = 1/700; % user preference - Fine tuning parameter - Used to control strength of attractive force 
            % For example, if zeta = 1/10000, the robot will not reach its
            % goal because the attractive force is very weak
            % for zeta = 1/10, the robot will cross over obstacles 

attractive = zeta * ( (x - goal(1)).^2 + (y - goal(2)).^2 );

figure;
m = mesh (attractive);
m.FaceLighting = 'phong';
axis equal;

title ('Attractive Potential');
max(max(attractive))

%% Display 2D configuration space

figure;
imshow(~obstacle);

hold on;
plot (goal(1), goal(2), 'g.', 'MarkerSize', 25);
hold off;

axis ([0 ncols 0 nrows]);
axis xy; % xy — Default direction. For axes in a 2-D view, the y-axis is vertical with values increasing from bottom to top.
         % if this line is commented, y axis start will be at the top and increases downward 
         % Ref: https://www.mathworks.com/help/matlab/ref/axis.html
axis on;

xlabel ('x');
ylabel ('y');

title ('Configuration Space');

%% Combine terms

f = attractive + repulsive;

figure;
m = mesh (f);
m.FaceLighting = 'phong';
axis equal;

title ('Total Potential');

%% Plan route
start = [50, 350];

route = GradientBasedPlanner (f, start, goal, 1000); % route has all points that the robot will pass through from start to goal

%% Plot the energy surface

figure;
m = mesh (f);
axis equal;

%% Plot ball sliding down hill (the ball is actually our robot)
% Reviewe the file SphereMatlab.m to learn how matlab can plot sphere (ball)

[sx, sy, sz] = sphere();

R = 20;
sx = R*sx;
sy = R*sy;
sz = R*sz+R; % To make the ball above the surface, we must left it by R.                
             % if sz=R*sz, the lower half of the ball will be under the
             % surface the upper half will be visible above the map

hold on;
p = mesh(sx, sy, sz); % this will plot a ball at 0,0,0
p.FaceColor = 'red';
p.EdgeColor = 'none';
p.FaceLighting = 'phong';
hold off;

hold on
% mark goal location with a big green star *
plot(goal(1), goal(2), 'g*', 'MarkerSize', 25);
hold off

% plot the ball at each point in route from start to goal
for i = 1:size(route,1)
    P = round(route(i,:)); % P = [x, y]
    z = f(P(2), P(1)); % z = f(x,y)
    
    % draw the ball shifted at the new location of P
    p.XData = sx + P(1); 
    p.YData = sy + P(2);
    p.ZData = sz + f(P(2), P(1));
    
    drawnow; 
    
    pause(0.05)
end

%% quiver plot
[gx, gy] = gradient (-f);
skip = 20;

figure;

xidx = 1:skip:ncols;
yidx = 1:skip:nrows;

quiver (x(yidx,xidx), y(yidx,xidx), gx(yidx,xidx), gy(yidx,xidx), 0.4);

axis ([1 ncols 1 nrows]);

hold on;

ps = plot(start(1), start(2), 'r.', 'MarkerSize', 30);
pg = plot(goal(1), goal(2), 'g.', 'MarkerSize', 30);
p3 = plot (route(:,1), route(:,2), 'r', 'LineWidth', 2);

