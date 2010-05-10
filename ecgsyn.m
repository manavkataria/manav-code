% ECGSYN
% Version 0.1: Crude Simulation
% X,Y Phase and State Trajectories plot; No Z.

clear all;
clc;

%%
t0 = 0; tf = 12;
x0 = -0.2; y0 = 2;
options = odeset('OutputFcn',@odephas2);

figure;
[T,Y] = ode45(@ecgsynSolver, [t0 tf], [x0 y0], options);

figure;
plot(T,Y(:,1),'-',T,Y(:,2),'-'); %,T,Y(:,3),'.')
title('State Trajectories as a function of Time');
legend('state x','state y'); grid on;
xlabel('Time \rightarrow '); ylabel('x(t) & y(t) \rightarrow ');
% text(-pi/4,sin(-pi/4),'\leftarrow sin(-\pi\div4)','HorizontalAlignment','left')

