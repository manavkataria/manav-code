%% Ecgsyn Solver
%  Version 0.3 baseline drift;
%  Version 0.2 3d Version, 9th March 
%  Version 0.1 2d Version, 8th March
function dy = ecgsynSolver(t,y)

radius = 1 - sqrt(y(1)*y(1) + y(2)*y(2)); %limit cycle
w = 1;       dy = zeros(3,1);       
a = 30.0;    b  = 0.1;
A = 0.15;    f2 = 0.01;  

dy(1) = radius*y(1) -      w*y(2); 
dy(2) =      w*y(1) + radius*y(2); 
dy(3) =  a*mod( atan2(y(2),y(1)), 2*pi)* ... 
      exp(-mod( atan2(y(2),y(1)), 2*pi)* ... 
           mod( atan2(y(2),y(1)), 2*pi)/ ... 
           (2*b*b)) - (y(3) - A*sin(2*pi*f2*t));

% dy(3) =  a*mod( atan2(y(2),y(1)), 2*pi)* ... 
%       exp(-mod( atan2(y(2),y(1)), 2*pi)* ... 
%            mod( atan2(y(2),y(1)), 2*pi)/ ... 
%            (2*b*b)) - (y(3) - A*sin(2*pi*f2*t));
