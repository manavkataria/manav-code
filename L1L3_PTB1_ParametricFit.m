function [cfun1, cfun3, gof1, gof3, out1, out3] =  L1L3_PTB1_ParametricFit(t,l1,l3)
%L1L3_PTB1_PARAMETRICFIT    Create plot of datasets and fits
%   L1L3_PTB1_PARAMETRICFIT(T,L1,L3)
%   Creates a plot, similar to the plot in the main curve fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with cftool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  2
%   Number of fits:  3
% Data from dataset "l1 vs. t (smooth) (MA)":
%    X = t:
%    Y = l1:
%    Unweighted
% Data from dataset "l3 vs. t":
%    X = t:
%    Y = l3:
%    Unweighted
%
% This function was automatically generated on 15-Sep-2010 16:44:35

%% Set up figure to receive datasets and fits
f_ = clf;
figure(f_);
set(f_,'Units','Pixels','Position',[445 105 688 536]);
legh_ = []; legt_ = {};   % handles and text for legend
xlim_ = [Inf -Inf];       % limits of x axis
ax_ = axes;
set(ax_,'Units','normalized','OuterPosition',[0 .5 1 .5]);
ax2_ = axes;
set(ax2_,'Units','normalized','OuterPosition',[0 0 1 .5]);
set(ax2_,'Box','on');
legrh_ = []; legrt_ = {};
set(ax_,'Box','on');
axes(ax_); hold on;
 
%% --- Plot data originally in dataset "l1 vs. t (smooth) (MA)"
t = t(:);
l1 = l1(:);
sm_.y1 = smooth(t,l1,5,'moving',0);
h_ = line(t,sm_.y1,'Parent',ax_,'Color',[0.333333 1 0.666667],...
     'LineStyle','none', 'LineWidth',1,...
     'Marker','.', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(t));
xlim_(2) = max(xlim_(2),max(t));
legh_(end+1) = h_;
legt_{end+1} = 'l1 vs. t (smooth) (MA)';
 
%% --- Plot data originally in dataset "l3 vs. t"
l3 = l3(:);
h_ = line(t,l3,'Parent',ax_,'Color',[0.333333 0.666667 1],...
     'LineStyle','none', 'LineWidth',1,...
     'Marker','.', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(t));
xlim_(2) = max(xlim_(2),max(t));
legh_(end+1) = h_;
legt_{end+1} = 'l3 vs. t';

% Nudge axis limits beyond data limits
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_,'XLim',xlim_)
   set(ax2_,'XLim',xlim_)
else
    set(ax_, 'XLim',[0.092010000000000008, 0.90699000000000007]);
    set(ax2_,'XLim',[0.092010000000000008, 0.90699000000000007]);
end

%% --- Create fit "Manual Fit"
% This Manual fit does not appear on the plot
if 0 
fo_ = fitoptions('method','NonlinearLeastSquares','Lower',-1,'Upper',1);
ok_ = isfinite(t) & isfinite(sm_.y1);
if ~all( ok_ )
    warning( 'GenerateMFile:IgnoringNansAndInfs', ...
        'Ignoring NaNs and Infs in data' );
end
st_ = [0.58704095966334569 ];
set(fo_,'Startpoint',st_);
ft_ = fittype('0.1*exp(-((t-.227)/.037).^2) - 0.345*exp(-((t-.347)/.015).^2) + 0.63*exp(-((t-.375)/.015).^2) - 0.47*exp(-((t-.435)/.025).^2)+ 0.197*exp(-((t-.647)/.07).^2) + 0.04*exp(-((t-.89)/.05).^2) - z',...
     'dependent',{'y'},'independent',{'t'},...
     'coefficients',{'z'});

% Fit this model using new data
cf_ = fit(t(ok_),sm_.y1(ok_),ft_,fo_);

% Or use coefficients from the original fit:
if 0
   cv_ = { 0.00065661679694952466};
   cf_ = cfit(ft_,cv_{:});
end

end

%% --- Create fit "Parametric Fit for L1"
fo_ = fitoptions('method','NonlinearLeastSquares', ...
    'Lower',[-3   -3   -3   -3   -3   -3   -1   -1   -1   -1   -1 -Inf -Inf -Inf -Inf -Inf -Inf -Inf   -1], ...
    'Upper',[3   3   3   3   3   3   1   1   1   1   1 Inf   1   1   1   1   1 Inf   1], ...
    'MaxFunEvals',10000);
ok_ = isfinite(t) & isfinite(sm_.y1);
if ~all( ok_ )
    warning( 'GenerateMFile:IgnoringNansAndInfs', ...
        'Ignoring NaNs and Infs in data' );
end
st_ = [0.10000000000000001 -0.34499999999999997 0.63 -0.46999999999999997 0.19700000000000001 0.12886282262171445 0.036999999999999998 0.014999999999999999 0.014999999999999999 0.025000000000000001 0.070000000000000007 0.52874620843273579 0.22700000000000001 0.34699999999999998 0.375 0.435 0.64700000000000002 0.48202263733214601 0.58704095966334569 ];
set(fo_,'Startpoint',st_);
ft_ = fittype('a1*exp(-((t-c1)/b1).^2) + a2*exp(-((t-c2)/b2).^2) + a3*exp(-((t-c3)/b3).^2) + a4*exp(-((t-c4)/b4).^2)+ a5*exp(-((t-c5)/b5).^2) + a6*exp(-((t-c6)/b6).^2) - z',...
     'dependent',{'y'},'independent',{'t'},...
     'coefficients',{'a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'b1', 'b2', 'b3', 'b4', 'b5', 'b6', 'c1', 'c2', 'c3', 'c4', 'c5', 'c6', 'z'});

% Fit this model using new data
[cf_,gof1,out1] = fit(t(ok_),sm_.y1(ok_),ft_,fo_);
cfun1 = cf_;

% Or use coefficients from the original fit:
if 0
   cv_ = { 0.099381817551034229, -0.71538240444950696, 0.77894552456507893, -0.45811391306030746, 0.18495586916749046, 0.43642196627300334, 0.031500874654939885, 0.016395386329907991, 0.022224750010898731, 0.026647483901905512, 0.066368739385882239, -17021.790047762468, 0.22760623594517476, 0.35160844364953187, 0.36704009649242403, 0.43459645914263911, 0.64936142060827251, -1168.398183654946, 0.42960620716014902};
   cf_ = cfit(ft_,cv_{:});
end

%% Plot this L1 fit
h_ = plot(cf_,'fit',0.95);
legend off;  % turn off legend from plot method call
set(h_(1),'Color',[0.666667 0.333333 0],...
     'LineStyle','-', 'LineWidth',2,...
     'Marker','none', 'MarkerSize',6);
legh_(end+1) = h_(1);
legt_{end+1} = 'Parametric Fit for L1';
res_ = sm_.y1 - cf_(t);
[x_,i_] = sort(t);
axes(ax2_); hold on;
h_ = line(x_,res_(i_),'Parent',ax2_,'Color',[0.666667 0.333333 0],...
     'LineStyle','-', 'LineWidth',1,...
     'Marker','.', 'MarkerSize',6);
axes(ax_); hold on;
legrh_(end+1) = h_;
legrt_{end+1} = 'Parametric Fit for L1';

%% --- Create fit "Parametric Fit for L3"
fo_ = fitoptions('method','NonlinearLeastSquares', ...
    'Lower',[-3   -3   -3   -3   -3   -3   -1   -1   -1   -1   -1 -Inf -Inf -Inf -Inf -Inf -Inf -Inf   -1], ...
    'Upper',[3   3   3   3   3   3   1   1   1   1   1 Inf   1   1   1   1   1 Inf   1], ...
    'MaxFunEvals',10000, 'MaxIter', 1000);
ok_ = isfinite(t) & isfinite(l3);
if ~all( ok_ )
    warning( 'GenerateMFile:IgnoringNansAndInfs', ...
        'Ignoring NaNs and Infs in data' );
end
st_ = [0.10000000000000001 -0.34499999999999997 0.63 -0.46999999999999997 0.19700000000000001 0.12886282262171445 0.036999999999999998 0.014999999999999999 0.014999999999999999 0.025000000000000001 0.070000000000000007 0.52874620843273579 0.22700000000000001 0.34699999999999998 0.375 0.435 0.64700000000000002 0.48202263733214601 0.58704095966334569 ];
set(fo_,'Startpoint',st_);
ft_ = fittype('a1*exp(-((t-c1)/b1).^2) + a2*exp(-((t-c2)/b2).^2) + a3*exp(-((t-c3)/b3).^2) + a4*exp(-((t-c4)/b4).^2)+ a5*exp(-((t-c5)/b5).^2) + a6*exp(-((t-c6)/b6).^2) - z',...
     'dependent',{'y'},'independent',{'t'},...
     'coefficients',{'a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'b1', 'b2', 'b3', 'b4', 'b5', 'b6', 'c1', 'c2', 'c3', 'c4', 'c5', 'c6', 'z'});

% Fit this model using new data
[cf_,gof3,out3] = fit(t(ok_),l3(ok_),ft_,fo_);
cfun3 = cf_;

% Or use coefficients from the original fit:
if 0
   cv_ = { -0.45295461557159938, -0.20446336819056607, -1.4365922594823206, 0.20784806367443576, -0.36546911299869489, 0.65940835386800556, 0.13500509594464868, 0.065073110290191971, -0.025228836415072949, 0.022684690380298165, 0.066966704672200325, 0.38144458991187064, 0.10913260242684203, 0.28812528787342867, 0.38227831393482015, 0.43002720713387171, 0.65732384745167616, -0.03744882807673898, 0.09638916106331652};
   cf_ = cfit(ft_,cv_{:});
end

%% Plot this L3 fit 
h_ = plot(cf_,'fit',0.95);
legend off;  % turn off legend from plot method call
set(h_(1),'Color',[0.333333 0.333333 0.333333],...
     'LineStyle','-', 'LineWidth',2,...
     'Marker','none', 'MarkerSize',6);
legh_(end+1) = h_(1);
legt_{end+1} = 'Parametric Fit for L3';
res_ = l3 - cf_(t);
[x_,i_] = sort(t);
axes(ax2_); hold on;
h_ = line(x_,res_(i_),'Parent',ax2_,'Color',[0.333333 0.333333 0.333333],...
     'LineStyle','-', 'LineWidth',1,...
     'Marker','.', 'MarkerSize',6);
axes(ax_); hold on;
legrh_(end+1) = h_;
legrt_{end+1} = 'Parametric Fit for L3';

%% Done plotting data and fits.  Now finish up loose ends.
hold off;
leginfo_ = {'Orientation', 'vertical'}; 
h_ = legend(ax_,legh_,legt_,leginfo_{:}); % create and reposition legend
set(h_,'Units','normalized');
t_ = get(h_,'Position');
t_(1:2) = [0.583333,0.570896];
set(h_,'Interpreter','none','Position',t_);
xlabel(ax_,'');               % remove x label
ylabel(ax_,'');               % remove y label
leginfo_ = {'Orientation', 'vertical', 'Location', 'NorthEast'}; 
h_ = legend(ax2_,legrh_,legrt_,leginfo_{:});
set(h_,'Interpreter','none');
xlabel(ax2_,'');
ylabel(ax2_,'');
title(ax_,'Data and Fits');
title(ax2_,'Residuals');
