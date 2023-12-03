%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Penalty method for minimizing
%
% (x1-1)^2 + 2(x2-2)^2, s.t.
%
% x1^2 + x2^2 - 1 <= 0.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The values below are suggestions - you may experiment with
% other values of eta and other (increasing) sequences of the
% µ parameter (muValues).
clear
clc

muValues = [1 10 100 500 1000];
eta = 0.0001;
xStart =  [1,2];
gradientTolerance = 1E-6;


xForPlot1 = [];
xForPlot2 = [];
muForPlot = [];

for i = 1:length(muValues)
 mu = muValues(i);
 x = RunGradientDescent(xStart,mu,eta,gradientTolerance);
 sprintf('x(1) = %3f, x(2) = %3f mu = %d',x(1),x(2),mu)
 
 xForPlot1(end+1) = x(1);
 xForPlot2(end+1) = x(2);
 muForPlot(end+1) = muValues(i);

end


 % 
 % figure
 % t = tiledlayout(2,1,'TileSpacing','compact');
 % bgAx = axes(t,'XTick',[],'YTick',[],'Box','on');
 % bgAx.Layout.TileSpan = [2 1];
 % ax1 = axes(t);
 % 
 % plot(ax1,muForPlot,xForPlot1,'ro',muForPlot,xForPlot2,'kx','linewidth',1)
 % yline(ax1,0.9,':');
 % ax1.Box = 'off';
 % ylim(ax1,[0.9 1.25])
 % legend({'x^*_1','x^*_2'},'Location','northeast')
 % 
 % % Create second plot
 % ax2 = axes(t);
 % ax2.Layout.Tile = 2;
 % plot(ax2,muForPlot,xForPlot1,'ro',muForPlot,xForPlot2,'kx','linewidth',1)
 % yline(ax2,0.45,':');
 % ax2.Box = 'off';
 % ax1.XAxis.Visible = 'off';
 % ylim(ax2,[0.25 0.45])
 % % Link the axes
 % linkaxes([ax1 ax2],'x')
 % title(t,'Convergens of x^*_1 and x^*_2')
 % 
 % xlabel(t,'Parameter \mu')
 % ylabel(t,'Minima coordinates (x_1,x_2)')
    
 %saveas(gcf,'HW1_1.svg')