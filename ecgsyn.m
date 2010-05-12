% ECGSYN

% Version 0.7: ECG Validation: Attemtps 
%	       using datafile: ecg_normal.gif
% Version 0.6: 3 Vector CardioGram: Polar & Time Series
%              Also explored; lead2 derived from lead1.
% Version 0.5: 3 Lead ECG (realistic); Polar Plot; 
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
datapts = 500;
tspan   = [t0:tf/(datapts-1):tf];

global thetai
global heighti
global widthi

configEcgSyn(1); 
[T1,Y1] = ode45(@ecgsynSolver, tspan, [x0 y0 z0], options);

configEcgSyn(2); 
[T2,Y2] = ode45(@ecgsynSolver, tspan, [x0 y0 z0], options);

subplot(3,1,1);  
plot(T1, Y1(:,3));
legend('Lead 1','Location','SouthWest');
xlabel('Time \rightarrow '); ylabel('milivolts (mv) \rightarrow ');
grid on; grid minor; title('Lead 1'); ylim([-0.5 0.5]);

subplot(3,1,2); 
plot(T2, Y2(:,3), T1, Y1(:,3));
legend('Lead 2', 'Lead 1','Location','SouthWest');
xlabel('Time \rightarrow '); ylabel('milivolts (mv) \rightarrow ');
grid on; grid minor; title('Lead 2'); ylim([-0.5 0.5]);

%% calculate Lead 3

T3 = T1;
% To determine whether angle subtended by dipole wrt horizontal is positive
% or negative; Cos(60-angle) is the lead2 value at horizontal 
% zeroComponentonY2 = cos (pi/3); 
% for i=1:length(T3) 
%     if (Y2(i,3) > zeroComponentonY2*Y1(i,3))
%         Y3(i) = cos (2*pi/3 + acos(Y1(i,3)));
%     else
%         Y3(i) = cos (2*pi/3 - acos(Y1(i,3)));
%     end
% end
% plot(T3, Y3, T2, Y2(:,3), T1, Y1(:,3));

%%

display 'Derive Lead 3';
subplot(3,1,3); 
% from Lead 2:
plot(T2, cos (pi/3 - acos(Y2(:,3)))-0.866, T2, Y2(:,3), T1, Y1(:,3));

% from Lead 1:
% plot(T1, cos (2*pi/3 - acos(Y1(:,3)))-0.866, T2, Y2(:,3), T1, Y1(:,3));

% figure;
% Lead 3 theta should be derived from either Y1 or Y2 or a mix of both?
% plot(T1,cos (2*pi/3 - acos(Y1(:,3))), T1, cos (pi/3 - acos(Y2(:,3))), 
% T1,(cos (2*pi/3 - acos(Y1(:,3)))+cos (pi/3 - acos(Y2(:,3))))/2);
legend('Lead 3 derived','Lead 2','Lead 1','Location','SouthWest');
xlabel('Time \rightarrow '); ylabel('milivolts (mv) \rightarrow ');
grid on; grid minor; title('Lead 3'); ylim([-0.5 0.5]);


%% Vector CardioGram
figure; subplot(2,1,1);
display 'Vector CardioGram: Polar';
polar(pi/3 - acos(Y2(:,3)),Y2(:,3),'--r');

% polar(acos(Y1(:,3)),Y1(:,3),'--r');
grid on; title('Vector CardioGram: Polar'); 

subplot(2,1,2);
plot(T2, pi/3 - acos(Y2(:,3)),'.-');
%plot(T1, acos(Y1(:,3)),'.-');
display 'Vector CardioGram: Time Series';
grid on; title('Vector CardioGram: Time Series'); 
xlabel('Time \rightarrow '); ylabel('angle (radian) \rightarrow ');
