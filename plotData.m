function plotData(ax, Outputs)
% Simple data to plot
x = [0.03 0.05 0.075 0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4];
y = Outputs(8:25);

% Clear previous plot and draw new one
cla(ax);
loglog(ax, x, y, 'b-', 'LineWidth', 2);
% title(ax, 'Psa (cm/s^2)');
xlabel(ax, '$T\:(s)$','FontSize',22, 'Interpreter','latex');
ylabel(ax, '$PSa\:(cm/s^2)$','FontSize',22, 'Interpreter','latex');
ax.XLim = [0.03 4]; ax.YLim = [0 inf];
ax.FontName='Times';
ax.FontSize=20;
ax.YTick = [0 1 10 100 1000];
ax.XTick = [0.03 0.1 1 4 ];
grid(ax, 'on');
end
