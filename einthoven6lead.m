%% Einthoven's 6 lead ECG Generation using ECG SYN Models

% Version 1.0: 15th Sept
% L1 and L3 raw Data as input. 
% Model Fitting of L1 and L3 into (m1, m3)
% Derived (m2, maVR, maVL, maVF) 
% using Einthoven's Triangle and Augmented Lead theory.

%% Select Patient Record
% Retrieve 6 lead Data from PhysioBank Record
patient = 1;
startSample = 000; %defautls
endSample   = 799;

if (patient == 1)
    % for Patient1
    [vf] = plotATM('s0014lrem.mat','sc.info',[1 2 3 4 5 6]);
    startSample = 100;
    endSample = 899;
elseif (patient == 2)   
    % for Patient2
    [vf] = plotATM('s0015lrem.mat','s0015lrem.info',[1 2 3 4 5 6]);
    startSample = 400;
    endSample = 1099;
else
    warning('No Patient Record Selected! Exiting.');
    return;
end

close;

%% Retrieve Lead 1 and Lead 3 (1st heart beat; ~0.8 seconds)
t = startSample/1000:.001:endSample/1000;

l1 = vf(1,startSample:endSample); 
l3 = vf(3,startSample:endSample);

%% Model Fitting for lead1 and lead6
figure;
[cfun1, cfun3, gof1, gof3, out1, out3] = L1L3_PTB1_ParametricFit(t,l1,l3);
display(sprintf('Percentage Fit of Lead1 %2.2f%%',gof1.rsquare*100));
display(sprintf('Percentage Fit of Lead3 %2.2f%%',gof3.rsquare*100));

%% Derive Remaning Limb Leads
m1   = (feval(cfun1,t))';
m3   = (feval(cfun3,t))';
m2   = m1 + m3;
maVR = -(m1 + m2)/2;
maVL =  (m1 - m3)/2;
maVF =  (m2 + m3)/2;

%% Plot Comparative Charts
% figure; plot(t,vf(1,startSample:endSample),t,m1); title('lead 1 and its model fit');
% figure; plot(t,vf(2,startSample:endSample),t,m2); title('lead 2 and its derivation');
% figure; plot(t,vf(3,startSample:endSample),t,m3); title('lead 3 and its model fit');
% figure; plot(t,vf(4,startSample:endSample),t,maVR); title('lead aVR and its derivation');
% figure; plot(t,vf(5,startSample:endSample),t,maVL); title('lead aVL and its derivation');
% figure; plot(t,vf(6,startSample:endSample),t,maVF); title('lead aVF and its derivation');

% Consolidated View:
figure;
subplot(6,1,1); plot(t,vf(1,startSample:endSample),t,m1); title('lead 1 and its model fit');
subplot(6,1,2); plot(t,vf(2,startSample:endSample),t,m2); title('lead 2 and its derivation');
subplot(6,1,3); plot(t,vf(3,startSample:endSample),t,m3); title('lead 3 and its model fit');
subplot(6,1,4); plot(t,vf(4,startSample:endSample),t,maVR); title('lead aVR and its derivation');
subplot(6,1,5); plot(t,vf(5,startSample:endSample),t,maVL); title('lead aVL and its derivation');
subplot(6,1,6); plot(t,vf(6,startSample:endSample),t,maVF); title('lead aVF and its derivation');
