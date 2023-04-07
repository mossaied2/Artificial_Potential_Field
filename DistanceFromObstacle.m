%% Generate some points

nrows = 400;
ncols = 600;

obstacle = false(nrows, ncols);

%% Generate rectangular obstacle 

obstacle (150:250, 1:end) = true; % rectangular obstacle

figure;
m = mesh (obstacle);
axis equal; % set max tic on x and y axises = max range of x = ncols and y = nrows, respectively

%% Compute distance transform

d = bwdist(obstacle); % bwdist function in matlab that return distance from any "true" element in obstacle array

'd(1,1)='
d(1,1)

'd(400,100)='
d(400,100)

'd(350,10)='
d(350,10)

'd(50,100)=' 
d(50,100)
