clear all
close all
%% moving a long -gradient(f)
% assume very simple example of one dimentional map (robot move in one directon, e.g. along X)

x = 1:1:100;
goal = 50;
zeta = 1;
fa = zeta*(x - goal).^2;
max(max(fa))

map(x)=false; % 1D map, what a simple one!
map(1)=true; % 1D map, 1 obstacle at x=1
map(90)=true; % 1D map, 1 obstacle at x=1
%d = bwdist(map);
d = bwdist_1D(map);
d0 = 30;
Rho = d + 1; % 1 is added to avoid possible division by zero later
Eta = 10000; % try it with 1, you will find that fr is neglible so we need to fine tune that paramter
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


iterations = 1000
Tolerance = 1;
Speed = 1; % if speed is 35, the robot will just bounce with very high error 
start = 2;
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

