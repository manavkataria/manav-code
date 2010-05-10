%% Ecgsyn Solver
%  Version 0.1 2d Version
function dy = ecgsynSolver(t,y)

radius = 1 - sqrt(y(1)*y(1) + y(2)*y(2));
w = 1; dy = zeros(2,1);     % a column vector

dy(1) = radius*y(1) -      w*y(2);
dy(2) =      w*y(1) + radius*y(2);
