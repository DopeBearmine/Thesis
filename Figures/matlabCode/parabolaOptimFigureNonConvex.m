function parabolaOptimFigureNonConvex

thesisOptions = thesisParams;
x = -10:0.01:10;
y = @(x) 10.*sin(x) + 0.5.*x.^2; % 
fontSize = 10;
font = 'helvetica';

%%
h =figure;
set(h, 'windowstyle', 'normal')
plot(x, y(x),...
    "Color",thesisOptions.royalBlue,...
    'lineWidth', 2); hold on

% actual optimization for numbers and wording
[res,~,~,test, grad, hess] = fminunc(y, -5, optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton', 'Diagnostics', 'on'));


examplePoints = [-5,6,6.5, 3, 2.5, 5, 4];

line(examplePoints, [y(examplePoints)],...
    'color', thesisOptions.gray,...
    'handlevisibility', 'off')

scatter(examplePoints, [y(examplePoints)], 40,...
    'filled', 'markerfacecolor', thesisOptions.gray)
axis square
boto

% annotations
% [x, y, width, height]
annotation('textbox',[0.5, 0.4  0.1 0.1],'String','\Delta f(x)','FitBoxToText','on',...
               'EdgeColor', 'none',...
               'FontName', font,...
               'FontSize', fontSize);

annotation('textbox',[0.35, 0.44,  0.1, 0.1],'String',1,'FitBoxToText','on',...
               'EdgeColor', 'none',...
               'FontName', font,...
               'FontSize', fontSize);
annotation('textbox',[0.61, 0.14  0.1 0.1],'String',6,'FitBoxToText','on',...
               'EdgeColor', 'none',...
               'FontName', font,...
               'FontSize', fontSize);



set(h, 'PaperUnits', 'centimeters');
set(h, 'PaperPosition', [0 0 8.6 8.6]);
set(h, 'PaperSize', [8.6 8.6]);
exportgraphics(h, 'C:\Users\dopeb\Documents\GitHub\Thesis\Figures\nonConvexGradient.pdf')
