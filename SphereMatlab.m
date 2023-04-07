clear all
close all
%% How to plot sphere (ball) in matlab 

%% Unit shpere at (0,0,0) with 20 faces resolution
[X,Y,Z] = sphere % [X,Y,Z] = sphere returns the x-, y-, and z- coordinates of a sphere without drawing it. 
                 % The returned sphere has a radius equal to 1 and consists of 20-by-20 faces.
                 % The center of the sphere is at (0,0,0)
surf(X,Y,Z);
axis equal
title('Unit shpere at (0,0,0) with 20x20 faces resolution (Default)')
xlabel ('x');
ylabel ('y');
zlabel ('z');

%% Unit shpere at (0,0,0) with 50x50 faces resolution 
figure;
% higher resolution sphere means more faces (50x50)
[X,Y,Z] = sphere(50);
surf(X,Y,Z);
axis equal
title('Unit shpere at (0,0,0) with 50x50 faces resolution')
xlabel ('x');
ylabel ('y');
zlabel ('z');

%% Unit shpere at (0,0,0) with 100x100 faces resolution 
figure;
% higher resolution sphere means more faces (100x100)
[X,Y,Z] = sphere(100);
surf(X,Y,Z);
axis equal
title('Unit shpere at (0,0,0) with 100-by-100 faces resolution')
xlabel ('x');
ylabel ('y');
zlabel ('z');

%% Radius 5 shpere at (0,0,0) with 100x100 faces resolution 
figure;
% higher resolution sphere means more faces (100x100)
[X,Y,Z] = sphere(100);
R = 5; % radius 
surf(R*X,R*Y,R*Z);
axis equal
title('Radius 5 shpere at (0,0,0) with 100-by-100 faces resolution')
xlabel ('x');
ylabel ('y');
zlabel ('z');

%% Radius 5 shpere at (2,2,0) with 100x100 faces resolution
figure;
% higher resolution sphere means more faces (100x100)
[X,Y,Z] = sphere(100);
R = 5; % radius 
surf(R*X - 2, R*Y - 2, R*Z);
axis equal
title('Radius 5 shpere at (2,2,0) with 100-by-100 faces resolution')
xlabel ('x');
ylabel ('y');
zlabel ('z');