% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function [hprop, valprop] = plotGB_Bicrystal_gbind_prop(prop_str, prop_val, pos, callback, varargin)
%% Function to create txt boxes and editable txt boxes
% authors: d.mercier@mpie.de / c.zambaldi@mpie.de

if nargin == 0
    prop_str = 'test';
    prop_val = 2;
    pos = [0.1 0.1 0.2 0.2];
    callback = '';
    figure;
end

parent = gcf;

hprop = uicontrol('Parent', parent,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', pos,...
    'HorizontalAlignment', 'center',...
    'String', prop_str);

valprop = uicontrol('Parent', parent,...
    'Units','normalized',...
    'Style', 'edit',...
    'Position', [pos(1)+0.23 pos(2) pos(3)-0.12 pos(4)],...
    'BackgroundColor', [0.9 0.9 0.9],...
    'String', prop_val,...
    'Callback', callback);

end