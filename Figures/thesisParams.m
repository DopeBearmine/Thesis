function params = thesisParams


% list of colors to pull from for consistency
params.royalBlue   = [16, 66, 122]./255; % Title 'RoyalBlue'
params.mahogany    = [180, 50, 30]./255; % Mahogany
params.springGreen = [196, 220, 110]./255; 
params.gray        = [155, 156, 159]./255; 
% params.cyclic;


alpha = linspace(1,0,100);
params.seq.greyBlue = params.royalBlue.*(1-alpha)' + [0.9 0.9 0.9].*(alpha)';
params.seq.greyRed = params.mahogany.*(1-alpha)' + [0.9 0.9 0.9].*(alpha)';

