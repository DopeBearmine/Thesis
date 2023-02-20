function nNeuronTuning


params = thesisParams;
x = [-180:0.5:180];
pref = [-135:45:180]; % degrees

% tuneVar = [0.001:0.5:10]'; % proportional to (1/sd)^2
tuneVar = 1;
peakFR = 100; % spk/s
baselineFR = 10; %spk/s

% Von mises tuning is actually a probability distrobution
tuneFun = @(x,pref) exp(tuneVar .* cosd(x-pref))./ (2*pi.* besseli(0, tuneVar));
% different rescaling for VM and Gauss
for n = 1:numel(pref)
    neuron(n,:) = (tuneFun(x,pref(n))./max(tuneFun(x,pref(n)),[],'all') .*(peakFR-baselineFR) + baselineFR);
end


nTrials = 2000;
yData = zeros(numel(pref), size(x,2), nTrials);
for trial = 1:nTrials
    yData(:,:,trial) = poissrnd(neuron, size(neuron,1), size(neuron,2));
end


cmap = cbrewer2('Greens', numel(x));
h=figure;
subplot(1,2,1)
plot(x, neuron, 'color', params.gray); hold on
plot(x, neuron([1,4],:), 'color', 'k', 'linewidth', 1.5);
scatter(x, 10.*ones(1,numel(x)), 10, cmap, 'filled')
boto
ylim([0,120])
xticks([-180:90:180])
xlabel(['\theta (', char(176), ')'])
ylabel('Firing Rate (spk/s)')
axis square
title('Population Tuning Curves')

subplot(1,2,2)
scatter(neuron(1,:), neuron(4,:), 10, cmap, 'filled')
boto
xlabel('Neuron 1 FR (spk/s)')
ylabel('Neuron 2 FR (spk/s)')
axis square
title('State Space')

h.WindowStyle = 'normal';
h.Units='centimeters';
h.Position=[1,1,17.2,8.6];


% % [x, y, width, height]
% annotation('textbox',[0.3, 0.5  0.1 0.1],'String','n1','FitBoxToText','on',...
%                'EdgeColor', 'none',...
%                'FontName', 'Helvetica',...
%                'FontSize', 8);


