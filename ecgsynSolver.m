%% Ecgsyn Solver

%  Version 0.6 Move to Global Variables
%  Version 0.5 pqrst wave iterator
%  Version 0.4 update variable names; 17th March
%  Version 0.3 baseline drift; 15-16th March
%  Version 0.2 3d Version, 9th March 
%  Version 0.1 2d Version, 8th March
function dy = ecgsynSolver(t,y)

global thetai
global heighti
global widthi

F = 1;          w = 2*pi*F;
A = 0.15;       F2 = 0.01;

dy        = zeros(3,1);       
deviation = 1 - sqrt(y(1)*y(1) + y(2)*y(2)); %from radius

theta     = atan2(y(2),y(1));

    dy(1) = deviation*y(1) -         w*y(2); 
    dy(2) =         w*y(1) + deviation*y(2); 
    dy(3) = 0;
for i=1:5
    dtheta = theta - thetai(i);
    dy(3)  = dy(3) - heighti(i)*dtheta* ... 
                     2^(-dtheta*dtheta/ ...
                    (2*widthi(i)*widthi(i))) ...
                  - (y(3) - A*sin(2*pi*F2*t));
end
