function plotInvariantDimensionsSimulation

%% Load the Simulation Data
% model 1 = 0 untuned stimulus dimensions
model{1,1} = load('C:\Users\dopeb\Documents\GitHub\Thesis\Figures\matlabCode\simulationData\3neuronSimulationData0Invariant.mat');
% model 2 = 1 untuned stimulus dimension
model{2,1} = load('C:\Users\dopeb\Documents\GitHub\Thesis\Figures\matlabCode\simulationData\3neuronSimulationData1Invariant.mat');
% model 3 = 2 untuned stimulus dimensions
model{3,1} = load('C:\Users\dopeb\Documents\GitHub\Thesis\Figures\matlabCode\simulationData\3neuronSimulationData2Invariant.mat');

%% Do the plotting

% simulation to visualize [int 1:100]
sim = 4; 
 % which random subset of points to plot (there are too many so just pick some)
randsamp = randi(size(model{1}.U{sim},1), 1, 10000);


figure
for modelToPlot = 1:size(model,1)
    % subplot 1: top CCA pair
    subplot(3,3,1+(modelToPlot-1))
    scatter(model{modelToPlot}.U{sim}(randsamp,1), model{modelToPlot}.V{sim}(randsamp,1), 2, 'filled')
    title(sprintf('Canonical Variable Pair 1; R^2 = %.3f', model{modelToPlot}.R(sim,1)))
    ylabel('Response (a.u.)')
    xlabel('Stimulus Value (a.u.)')

    subplot(3,3,4+(modelToPlot-1))
    scatter(model{modelToPlot}.U{sim}(randsamp,2), model{modelToPlot}.V{sim}(randsamp,2), 2, 'filled')
    title(sprintf('Canonical Variable Pair 2; R^2 = %.3f', model{modelToPlot}.R(sim,2)))
    ylabel('Response (a.u.)')
    xlabel('Stimulus Value (a.u.)')

    subplot(3,3,7+(modelToPlot-1))
    scatter(model{modelToPlot}.U{sim}(randsamp,3), model{modelToPlot}.V{sim}(randsamp,3), 2, 'filled')
    title(sprintf('Canonical Variable Pair 3; R^2 = %.3f', model{modelToPlot}.R(sim,3)))
    ylabel('Response (a.u.)')
    xlabel('Stimulus Value (a.u.)')

end

% helper functions that make the X and Y axes of all subplots have the same
% boundaries
equalizeY
equalizeX

