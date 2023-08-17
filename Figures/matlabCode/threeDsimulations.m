

tic
simulationParameters.nNeurons = 3;
simulationParameters.nDims = 3;
simulationParameters.tuningWidth = 5;
simulationParameters.peak = ones(simulationParameters.nNeurons,1).*100;
simulationParameters.nInvariantDims=0;

simulationParameters.stimSpace = linspace(-6, 6, 20);
[stimx, stimy, stimz] = meshgrid(simulationParameters.stimSpace);
simulationParameters.stim = [stimx(:),stimy(:), stimz(:)];
nSimulations = 100;

% load existing simulation parameters for consistency if they exist
if exist("3neuronSimulationData0Invariant.mat", "file")
    mod = load("3neuronSimulationData0Invariant.mat");
end

for sim = 1:nSimulations
    fprintf('Simulation number %d of %d\n', sim, nSimulations)
    [pref{sim}, tuning{sim}, groundTruth{sim}] = generateArtificialPopulation(simulationParameters.nNeurons,...
                                    'nInvariantDims', simulationParameters.nInvariantDims,...
                                    'distribution', 'groundTruth',...
                                    'nDims', simulationParameters.nDims,...
                                    'tuningWidth', simulationParameters.tuningWidth);
    % make the latent tuning covary by adding an off-diagonal element
%     tuning{sim}(2,1,:) = tuning{sim}(1,1,:);
%     tuning{sim}(1,2,:) = tuning{sim}(1,1,:);
%     tuning{sim}(3,1,:) = tuning{sim}(1,1,:);
%     tuning{sim}(1,3,:) = tuning{sim}(1,1,:);
%     tuning{sim}(2,3,:) = tuning{sim}(1,1,:);
%     tuning{sim}(3,2,:) = tuning{sim}(1,1,:);
    if exist("3neuronSimulationData0Invariant.mat", "file")
        pref{sim} = mod.pref{sim};
        groundTruth{sim} = mod.groundTruth{sim};
    end

    for s = 1:size(simulationParameters.stim,1)
        y{sim}(s,:) = artificialResponse(pref{sim}, tuning{sim}, simulationParameters.peak , simulationParameters.stim(s,:)', true);
    end
    [A{sim},B{sim},R(sim,:),U{sim},V{sim}, stats{sim}] = canoncorr(simulationParameters.stim, y{sim});
end
toc

save('3neuronSimulationData_0Invariant_5Tuning_PoissVar', 'simulationParameters','pref','tuning','groundTruth','y','A','B','R','U','V', 'stats')

