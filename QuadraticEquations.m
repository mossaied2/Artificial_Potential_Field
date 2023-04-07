clear all
close all
%% Why we should have quadratic equation y = x^2 
% simple answer: it is convex shape

%% 1D case
x = -100:0.1:100;
goal = 0;
attractive_1D = (x - goal).^2 ;

figure;
plot(x,attractive_1D);
title ('1D convex quadratic function');

%% 2D
nrows = 600;
ncols = 600;
[x, y] = meshgrid (1:ncols, 1:nrows);
goal = [1, 1]; % here x_g = goal(2), y_goal = goal(1)
attractive_2D = (x - goal(2)).^2 + (y - goal(1)).^2 ;
[min, id] = min(attractive_2D(:))
[Ymin, Xmin] = ind2sub(size(attractive_2D),id)
figure;
m = mesh (attractive_2D);
title ('2D convex quadratic function');
