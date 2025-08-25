clear;clc;close;close all;format compact;format short g
load('GMM_Turkie_2025.mat')
% Create a figure
fig = uifigure('Name', 'ground motion model (GMM)', 'Position', [10 100 750 550]);

% Add components
uilabel(fig, 'Text', 'Inputs', 'Position', [15 520 130 25],...
    'FontSize',16,'FontWeight','bold','FontColor','red');

uilabel(fig, 'Text', 'Outputs', 'Position', [390 520 130 25],...
    'FontSize',16,'FontWeight','bold','FontColor','blue');

uilabel(fig, 'Text', '$M_w$','Interpreter','latex', 'Position', [15 490 60 20]);
Mw = uieditfield(fig, 'numeric', 'Position', [80 490 40 20], 'Limits', [4 7.8],...
                      'LowerLimitInclusive','on',...
                      'UpperLimitInclusive','on',...
                      'Value', 4);

uilabel(fig, 'Text', '$R_{JB}\:(km)$','Interpreter','latex', 'Position', [15 465 60 20]);
RJB = uieditfield(fig, 'numeric', 'Position', [80 465 40 20], 'Limits', [0.1 200],...
                      'LowerLimitInclusive','on',...
                      'UpperLimitInclusive','on',...
                      'Value', 0.1);

uilabel(fig, 'Text', '$V_{S30}\:(m/s)$','Interpreter','latex', 'Position', [15 440 60 20]);
VS30 = uieditfield(fig, 'numeric', 'Position', [80 440 40 20], 'Limits', [131 1380],...
                      'LowerLimitInclusive','on',...
                      'UpperLimitInclusive','on',...
                      'Value', 131);

uilabel(fig, 'Text', '$FD\:(km)$','Interpreter','latex', 'Position', [15 415 60 20]);
FD = uieditfield(fig, 'numeric', 'Position', [80 415 40 20], 'Limits', [0 35],...
                      'LowerLimitInclusive','on',...
                      'UpperLimitInclusive','on',...
                      'Value', 0);

uilabel(fig, 'Text', '$FM$','Interpreter','latex', 'Position', [15 390 60 20]);
FM = uidropdown(fig, 'Position', [80 390 90 20],...
    'Items', {'Normal', 'Reverse', 'Strike Slip'},...
    'ItemsData',[1 2 3],'Value',1);

% Create plot area (axes)
ax = uiaxes(fig);
ax.Position = [20 20 700 350];  % [left bottom width height]


uibutton(fig, 'Position', [130 440 40 40], 'Text', 'Run',...
    'FontSize',15,'FontName','times','FontWeight','bold', ...
    'ButtonPushedFcn', @(src,event) Call_Back(Mw.Value, VS30.Value, RJB.Value, FM.Value, FD.Value, ...
    ax, Param_Max, Param_Min, Net_Save, fig));

uilabel(fig, 'Text', '$PSa\;_{T=0.2\;s}\;(cm/s^2)$','Interpreter','latex', 'HorizontalAlignment','right','Position', [215 490 110 20]);
uieditfield(fig, 'numeric', 'Position', [325 490 50 20],'Value',0);

uilabel(fig, 'Text', '$PSa\;_{T=0.5\;s}\;(cm/s^2)$','Interpreter','latex','HorizontalAlignment','right', 'Position', [215 465 110 20]);
uieditfield(fig, 'numeric', 'Position', [325 465 50 20], 'Value', 0);

uilabel(fig, 'Text', '$PSa\;_{T=1.0\;s}\;(cm/s^2)$','Interpreter','latex','HorizontalAlignment','right', 'Position', [215 440 110 20]);
uieditfield(fig, 'numeric', 'Position', [325 440 50 20], 'Value', 0);

 uilabel(fig, 'Text', '$PSa\;_{T=2.0\;s}\;(cm/s^2)$','Interpreter','latex','HorizontalAlignment','right', 'Position', [215 415 110 20]);
 uieditfield(fig, 'numeric', 'Position', [325 415 50 20], 'Value', 0);

 uilabel(fig, 'Text', '$PSa\;_{T=4.0\;s}\;(cm/s^2)$','Interpreter','latex','HorizontalAlignment','right', 'Position', [390 490 110 20]);
 uieditfield(fig, 'numeric', 'Position', [500 490 50 20], 'Value', 0);

   uilabel(fig, 'Text', '$PGA\;(cm/s^2)$','Interpreter','latex','HorizontalAlignment','right','Position', [390 465 110 20]);
 uieditfield(fig, 'numeric', 'Position', [500 465 50 20], 'Value', 0);

   uilabel(fig, 'Text', '$PGV\;(cm/s)$','Interpreter','latex', 'HorizontalAlignment','right','Position', [390 440 110 20]);
 uieditfield(fig, 'numeric', 'Position', [500 440 50 20], 'Value', 0);

   uilabel(fig, 'Text', '$CAV\;(cm/s)$','Interpreter','latex','HorizontalAlignment','right', 'Position', [390 415 110 20]);
 uieditfield(fig, 'numeric', 'Position', [500 415 50 20], 'Value', 0);

  uilabel(fig, 'Text', '$I_a\;(cm/s)$','Interpreter','latex','HorizontalAlignment','right', 'Position', [565 490 110 20]);
 uieditfield(fig, 'numeric', 'Position', [675 490 50 20], 'Value', 0);

   uilabel(fig, 'Text', '$T_m\;(s)$','Interpreter','latex', 'HorizontalAlignment','right','Position', [565 465 110 20]);
 uieditfield(fig, 'numeric', 'Position', [675 465 50 20], 'Value', 0);

    uilabel(fig, 'Text', '$D_{5\%-75\%}\;(s)$','Interpreter','latex', 'HorizontalAlignment','right','Position', [565 440 110 20]);
 uieditfield(fig, 'numeric', 'Position', [675 440 50 20], 'Value', 0);

    uilabel(fig, 'Text', '$D_{5\%-95\%}\;(s)$','Interpreter','latex', 'HorizontalAlignment','right','Position', [565 415 110 20]);
 uieditfield(fig, 'numeric', 'Position', [675 415 50 20], 'Value', 0);
