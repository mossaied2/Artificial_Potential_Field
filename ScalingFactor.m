clear all
close all
%% Why we should have scaling factor 

nrows = 400;
ncols = 600;

obstacle = false(nrows, ncols);

% get the x and y coordinate of each cell in obstacle
[x, y] = meshgrid (1:ncols, 1:nrows); % remember that x is corresponding to cols while y is corresponding to rows

t = ((x - ncols/2).^2 + (y - nrows/2).^2) < 25^2; % circular obstacle (XC, YC are in center, R=25)
obstacle(t) = true;

%% Compute distance transform (Reviewe the file DistanceFromObstacle.m to understand bwdist function)

d = bwdist(obstacle); % bwdist function in matlab that return distance from any "true" element in obstacle array

% Rescale and transform distances
K = 1; % user preference. At k=1 -> all Rho values = 1 so < d0. So K is used to control the range of the repulsive force effectivness  
Rho = d / K + 1;  % some values in d are zeros and will be problematic in caluclating the repulsive force so we need to add one to all values to avoid division by 0

d0 = 2; % user preference. If robot away from the obstacle by more than d0 then the repulsive force of that obstacle is considered 0

repulsive = true(nrows, ncols);
repulsive (Rho > d0) = 0;

%% Display repulsive potential

figure;
m = mesh (obstacle);
axis equal;
title ('Map');

figure;
m = mesh (repulsive);
axis equal;
title ('Repulsive Array (yellow < d0 and blue is > d0)');
