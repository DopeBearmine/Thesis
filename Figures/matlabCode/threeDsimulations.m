
simulationParameters.

simulationParameters.nNeurons = 3;
simulationParameters.nDims = 3;
simulationParameters.tuningWidth = 50;
simulationParameters.peak = ones(nNeurons,1).*100;
simulationParameters.nInvariantDims=1;

simulationParameters.stimSpace = linspace(-6, 6, 50);
[stimx, stimy, stimz] = meshgrid(stimSpace);
simulationParameters.stim = [stimx(:),stimy(:), stimz(:)];
nSimulations = 100;

for sim = 1:nSimulations
    disp(sim)
    [pref{sim}, tuning{sim}, groundTruth{sim}] = generateArtificialPopulation(simulationParameters.nNeurons,...
                                    'nInvariantDims', simulationParameters.nInvariantDims,...
                                    'distribution', 'groundTruth',...
                                    'nDims', simulationParameters.nDims,...
                                    'tuningWidth', simulationParameters.tuningWidth);
    
    for s = 1:size(stim,1)
        y{sim}(s,:) = artificialResponse(pref{sim}, tuning{sim}, peak , stim(s,:)');
    end
    [A{sim},B{sim},R(sim,:),U{sim},V{sim}] = canoncorr(stim, y{sim});

end
save('3neuronSimulationData', 'simulationParameters','pref','tuning','groundTruth','y','A','B','R','U','V')

