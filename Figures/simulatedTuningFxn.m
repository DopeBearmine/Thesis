function simulatedTuningFxn

% Assumptions
% 1.) Von-mises tuned
% 2.) Poisson Variable



%%
params = thesisParams;
x = [-180:0.1:180];
pref = 0; % degrees
% tuneVar = [1:5:180]'; % degrees
tuneVar = [0.001:0.5:10]'; % proportional to (1/sd)^2
peakFR = 100; % spk/s
baselineFR = 10; %spk/s

% Von mises tuning is actually a probability distrobution
tuneFun = @(x) exp(tuneVar .* cosd(x-pref))./ (2*pi.* besseli(0, tuneVar));
% different rescaling for VM and Gauss
y = (tuneFun(x)./max(tuneFun(x),[],'all') .*(peakFR-baselineFR) + baselineFR);

% % % Gaussian Tuning
% % tuneFun = @(x) 1./(tuneVar.*sqrt(2*pi)) .* exp(-0.5.* ((x-pref)./tuneVar).^2);
% rescale
% y = (tuneFun(x)-min(tuneFun(x),[],2))./max(tuneFun(x)-min(tuneFun(x),[],2),[],2 );
% y = y .* (peakFR-baselineFR) +baselineFR;


figure
plot(x, y); hold on

nTrials = 3000;
yData = zeros(numel(tuneVar), size(x,2), nTrials);
for trial = 1:nTrials
    yData(:,:,trial) = poissrnd(y, size(y,1), size(y,2));
end

for d = 1:numel(tuneVar)
    test = yData(d,:,:);
    mi(d) = mutualInformation(repmat(x', size(yData,3),1), test(:), 'xBins', [-180:45:135]-1);
    sampleData = squeeze(yData(d,ismember(x,samplePoints),:));
    subsampledMI(d) = mutualInformation(repmat(samplePoints',size(yData,3),1),sampleData(:));
end


% ideal tuning width = 66degrees
best = max(mi)==mi;

%%
samplePoints = -180:45:180;


h=figure;
subplot(1,2,2)
plot(tuneVar, mi, 'color', params.royalBlue, 'linewidth', 1); hold on
plot(tuneVar, subsampledMI, 'color', params.mahogany, 'linewidth', 1);
scatter(tuneVar(max(mi)==mi), mi(max(mi)==mi), 'filled', 'markerfaceColor', 'k')
scatter(tuneVar(max(subsampledMI)==subsampledMI), subsampledMI(max(subsampledMI)==subsampledMI), 'filled', 'markerfaceColor', 'k')
ylabel('Information (bits)')
xlabel('\kappa Parameter (concentration)')
boto
legend({'Fine Discrimination', 'Coarse Discrimination'}, 'location', 'best')
title('Information vs. Tuning Width')
axis square

subplot(1,2,1)
plot(x, y, 'color', params.gray, 'HandleVisibility','off'); hold on
plot(x, y(end,:), 'color', 'k', 'lineWidth', 1.5)
plot(x,y(max(mi)==mi,:), 'color', params.royalBlue, 'linewidth', 2.5)
plot(x,y(max(subsampledMI)==subsampledMI,:), 'color', params.mahogany, 'linewidth', 2.5)
xlabel(['Difference from Preferred direction (', char(176), ')'])
ylabel('Neuron Firing Rate (spk/s)')
xticks(samplePoints)
axis square
boto
h.WindowStyle = 'normal';
h.Units='centimeters';
h.Position=[1,1,17.2,8.6];
HSfigFonts;

coolLegend
exportgraphics(h, 'C:\Users\hscott\Documents\Thesis\Figures\tuningAndInfo.pdf')

%%
tuning = y(best,:);
sampleData = squeeze(yData(best,ismember(x,samplePoints),:));
subSampleData = sampleData(:,30:40);

h=figure;
subplot(1,2,1)
scatter(repelem(samplePoints',1,size(subSampleData,2)), subSampleData, 17,'filled',...
    'markerfacecolor', params.gray, 'HandleVisibility','off')
ylim([0,80])
hold on
plot(x, tuning, 'color', params.royalBlue, 'linestyle', '--')
xticks(samplePoints)
ylabel('Neuron Firing Rate (spk/s)')
xlabel(['\theta (', char(176), ')'])
boto
axis square

subplot(1,2,2)
shadedErrorBar(x, tuning, sqrt(tuning), 'lineprops', {'color', params.royalBlue})
xticks(samplePoints)
boto
xlabel(['\theta (', char(176), ')'])
ylabel('Neuron Firing Rate (spk/s)')
axis square
boto
h.WindowStyle = 'normal';
h.Units='centimeters';
h.Position=[1,1,17.2,8.6];
HSfigFonts;
exportgraphics(h, 'C:\Users\hscott\Documents\Thesis\Figures\tuningSamplingIntro.pdf')

%% 2D tuning
oriTune = y(best,:);
sf = linspace(0, 10, size(y,2));
sfTune = generateKernel('Gauss', 'length',size(y,2), 'sigma', 800)+ 0.2;

downSizeN = 10;
newTuning = downsample(transpose(downsample(sfTune'*oriTune,downSizeN)),downSizeN);
newOri = downsample(x,downSizeN);
newSF = downsample(sf,downSizeN);
oldTuningSF= 4.3; % self-selected based on result for visualization

h=figure;
% subplot(2,1,1)
% imagesc(newOri, newSF, newTuning)
% axis square
% boto
% xticks([-180:90:180])
% xlabel(['\theta (', char(176), ')'])
% ylabel('SF (a.u.)')

% subplot(2,1,2)
surf(newOri, newSF, newTuning,...
    'edgecolor','none'); hold on
patch([-200, 200,200,-200], [oldTuningSF,oldTuningSF,oldTuningSF,oldTuningSF],...
    [0,0,80,80], params.gray, 'facealpha',0.5, 'edgealpha',0)

xticks([-180:90:180])
xlabel(['\theta (', char(176), ')'])
ylabel('SF (a.u.)')
zlabel('Firing Rate (spk/s)')
axis square
colormap turbo
caxis([0,75])

h.WindowStyle = 'normal';
h.Units='centimeters';
h.Position=[1,1,8.6,8.6];

HSfigFonts
exportgraphics(h, 'C:\Users\hscott\Documents\Thesis\Figures\2Dtuning.pdf')









