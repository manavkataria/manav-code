% ECGSYN

% Version 0.4: 2 Lead ECG
% Version 0.3: Baseline drift 
% Version 0.2: X,Y,Z phase Sim
% Version 0.1: Crude Simulation
% X,Y Phase and State Trajectories plot; No Z.

clear all;
clc;

%%
t0 = 0; tf = 1;
x0 = -0.1; y0 = 0; z0 = 0;
options = odeset('OutputFcn',@odephas3);

global thetai
global heighti
global widthi

configEcgSyn(1); 
[T1,Y1] = ode45(@ecgsynSolver, [t0 tf], [x0 y0 z0], options);

configEcgSyn(2); 
[T2,Y2] = ode45(@ecgsynSolver, [t0 tf], [x0 y0 z0], options);

subplot(2,1,1);  
plot(T1, Y1(:,3),'.-');
grid on; title('Lead 1');
xlabel('Time \rightarrow '); ylabel('z(t) \rightarrow ');

subplot(2,1,2); 
plot(T2, Y2(:,3),'.-');
grid on; title('Lead 2'); 
xlabel('Time \rightarrow '); ylabel('z(t) \rightarrow ');

% legend('state x','state y', 'state z'); 
% text(-pi/4,sin(-pi/4),'\leftarrow
% sin(-\pi\div4)','HorizontalAlignment','left')
