clear all
close all
%% Circular Obstacle

nrows = 600;
ncols = 600;

obstacle = false(nrows, ncols);

% get the x and y coordinate of each cell in obstacle
[x, y] = meshgrid (1:ncols, 1:nrows); % remember that x is corresponding to cols while y is corresponding to rows

%% Generate circular obstacle centered in the map
%  The general circle equation in geomtery is (X-XC)^2 + (Y-YC)^2 = R^2                
%  Where (XC,YC) are the coordinates of circle center and R is the circle radius               
%  In this example if the circle is required to be in the center then: XC = ncols/2 and YC = nrows/2 
%  Since all points inside the circle is part of the obstacle, then the equation would be (X-XC)^2 + (Y-YC)^2 < R^2 

%XC = ncols/2;
%YC = nrows/2;
XC = 200;
YC = 300;
R = 100;

t = ((x - XC).^2 + (y - YC).^2) < R^2;
obstacle(t) = true;

%t = ((x - 300).^2 + (y - 200).^2) == 25^2; % this will highlight only the perimeter of the circle 
%obstacle(t) = true;

figure;
m = mesh (obstacle);
axis equal; % set max tic on x and y axises = max range of x = ncols and y = nrows, respectively

title ('Cicular Obstacle');