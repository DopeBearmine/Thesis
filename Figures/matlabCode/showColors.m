function showColors

curdur = cd;
cd('C:\Users\dopeb\Documents\GitHub\Thesis\Figures')
params = thesisParams;

cd(curdur)

%% Names and color data from params struct
fields = fieldnames(params);
isColor = false(size(fields));
for fi = 1:numel(fields)
    % if this field is a color field
    if isnumeric(params.(fields{fi})) && numel(params.(fields{fi}))==3
        colors.(fields{fi}) = params.(fields{fi});
        isColor(fi) = true;
    end
end
colorNames = fields(isColor);


%% Plot Colors
% if it is a perfect square, plot as square
if mod(sqrt(size(colorNames,1)),1)==0
    plotSize = [sqrt(size(colorNames,1)),sqrt(size(colorNames,1))];
else
    if round(sqrt(size(colorNames,1))) == floor(sqrt(size(colorNames,1)))
        plotSize = [round(sqrt(size(colorNames,1)))+1, round(sqrt(size(colorNames,1)))];
    else
        plotSize = [round(sqrt(size(colorNames,1)))  , round(sqrt(size(colorNames,1)))];
    end
end


figure
for col = 1:size(colorNames,1)
    subplot(plotSize(1), plotSize(2), col)
    set(gca, 'color', colors.(colorNames{col}))
    set(gca().XAxis, 'TickLength', [0,0])
    set(gca().XAxis, 'TickValues', [])
    set(gca().XAxis, 'Color', colors.(colorNames{col}))
    xlabel(sprintf('%s', colorNames{col}), 'Color', 'k')
    % Y Axis
    set(gca().YAxis, 'TickLength', [0,0])
    set(gca().YAxis, 'TickValues', [])
    set(gca().YAxis, 'Color', colors.(colorNames{col}))
    xlabel(colorNames{col})
end




