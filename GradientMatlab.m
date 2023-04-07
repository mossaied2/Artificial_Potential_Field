clear all
close all
%% Gradient coding
% assume very simple example of one dimentional map (robot move in one directon, e.g. along X)

x = 1:1:100;
goal = 50;
f = (x - goal).^2;
plot(x,f,'r-o')

K = 100; % just a scaling scaling factor
gx = K*gradient (f);
hold on
plot(x,gx,'b--')

K = 100; % just a scaling scaling factor
gx = -K*gradient (f);
hold on
plot(x,gx,'g--')

