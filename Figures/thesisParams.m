function params = thesisParams


% list of colors to pull from for consistency
% Red
params.ddi         = [255, 170, 090]./255;
params.mahogany    = [180, 050, 030]./255; 
% Blue
params.active      = [123, 050, 148]./255;
params.lavender    = [190, 186, 218]./255;
params.royalBlue   = [016, 066, 122]./255; 
params.midBlue     = [31, 120, 180]./255;
params.idi         = [128, 177, 211]./255;
params.lightBlue   = [166, 206, 227]./255;
% Green
params.passive     = [000, 136, 055]./255;
params.lime = [178, 223, 138]./255;
params.springGreen = [196, 220, 110]./255; 
params.cyan = [0, 1, 1];
params.magenta = [1,0,1];

% Grays
params.gray        = [155, 156, 159]./255; 


alpha = linspace(1,0,100);
params.seq.greyBlue = params.royalBlue.*(1-alpha)' + [0.9 0.9 0.9].*(alpha)';
params.seq.greyRed = params.mahogany.*(1-alpha)' + [0.9 0.9 0.9].*(alpha)';

