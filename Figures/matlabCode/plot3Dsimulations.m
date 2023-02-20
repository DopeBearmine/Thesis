
%%
load('3neuronSimulationData.mat')



%%

figure
subplot(2,1,1)
errorbar(tanh(mean(atanh(R),1)), tanh(std(atanh(R),[],1)./sqrt(size(R,1)) ), 'color', 'k','linestyle','none' );
hold on
scatter([1:3], tanh(mean(atanh(R),1)),[],'filled');
% plot(R)
ylabel('Correlation')
xlabel('Canonical Variable Pair')
xlim([0.5 3.5])
xticks([1:3])
boto

subplot(2,1,2)
scatter(U{sim}(:,1), V{sim}(:,1), 5, 'filled')
title('Canonical Variable Pair 1')
ylabel('Response (a.u.)')
xlabel('Stimulus Value (a.u.)')

%%

% which neurons to plot
nOfInterest = [1,2];
stimDofInterest = [1,2];
cent = mean(stim);


%% Surf plotting

nOfInterest = [1,2];
stimDofInterest = [2,3];

sim = 1; % simulation number to plot
missingDimPlotValue = find(stimSpace>=0,1); % which value along the 3rd, unplotted dimension to use
cent = mean(simulationParameters.stim);
% surf.m is annoying so i have to transform stuff into a specific format
stimx= reshape(simulationParameters.stim(:,1), numel(stimSpace), numel(stimSpace), numel(stimSpace));
stimy= reshape(simulationParameters.stim(:,2), numel(stimSpace), numel(stimSpace), numel(stimSpace));
stimz= reshape(simulationParameters.stim(:,3), numel(stimSpace), numel(stimSpace), numel(stimSpace));


% controls axis labels and which data to pull based on which dimensions you
% want to plot
switch mat2str(stimDofInterest)
    case {'[1 2]', '[2 1]'}
        stimDimToPlot1 = squeeze(stimx(:,:,1));
        stimDimToPlot2 = squeeze(stimy(:,1,:));
        xLabel = 'Stimulus Dimension 1';
        yLabel = 'Stimulus Dimension 2';
    case {'[2 3]', '[3 2]'}
        stimDimToPlot1 = squeeze(stimx(:,:,1));
        stimDimToPlot2 = squeeze(stimy(:,1,:));
        xLabel = 'Stimulus Dimension 2';
        yLabel = 'Stimulus Dimension 3';
    case {'[1 3]', '[3 1]'}
        stimDimToPlot2 = squeeze(stimx(:,:,1));
        stimDimToPlot1 = squeeze(stimy(:,1,:));
        xLabel = 'Stimulus Dimension 1';
        yLabel = 'Stimulus Dimension 3';
end

zDimToIgnore=find(~ismember([1:3], stimDofInterest));


figure
z = reshape(y{sim}(:,nOfInterest(1)), numel(stimSpace), numel(stimSpace), numel(stimSpace));
switch mat2str(zDimToIgnore)
    case '1'
        newZ = squeeze(z(:,missingDimPlotValue,:));
    case '2'
        newZ = squeeze(z(missingDimPlotValue,:,:));
    case '3'
        newZ = squeeze(z(:,:,missingDimPlotValue));
end
surf(stimDimToPlot1, stimDimToPlot2, newZ)
hold on
colormap autumn
freezeColors;

z = reshape(y{sim}(:,nOfInterest(2)), numel(stimSpace), numel(stimSpace), numel(stimSpace));
switch mat2str(zDimToIgnore)
    case '1'
        newZ = squeeze(z(:,missingDimPlotValue,:));
    case '2'
        newZ = squeeze(z(missingDimPlotValue,:,:));
    case '3'
        newZ = squeeze(z(:,:,missingDimPlotValue));
end
surf(stimDimToPlot1, stimDimToPlot2, newZ)
colormap summer
xlabel(xLabel)
ylabel(yLabel)
quiver(cent(stimDofInterest(1)),cent(stimDofInterest(2)), A{sim}(stimDofInterest(1),1), A{sim}(stimDofInterest(2),1), 5, 'lineWidth', 2)


%% Re-calculate which dimension is irrelevant

for d = 1:3
    dcor(d,1) = distcorr(stim(:,d), y{sim});


