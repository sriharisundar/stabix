% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function plotGB_Bicrystal_gbax_title_and_text(no_slip, ...
    shiftXYZA, shiftXYZB)
%% Function to set the title for the bicrystal plot
% no_slip: 1 if no slip to plot and 0 if slipA or slipB defined after calculations
% shiftXYZA: Shift the unit cell in the center of grain A
% shiftXYZB: Shift the unit cell in the center of grain B

% authors: d.mercier@mpie.de / c.zambaldi@mpie.de

%% Set the encapsulation of data
gui = guidata(gcf);

idgb  = sprintf('GB #%i', gui.GB.GB_Number);
idgra = sprintf('gr.A #%i', gui.GB.GrainA);
idgrb = sprintf('gr.B #%i', gui.GB.GrainB);
idmis = sprintf('mis = %.1f�', gui.GB.misorientation);
idcaxis_mis = sprintf('c-mis = %.1f�', gui.GB.caxis_misor);

%% Selection of m' value
valcase = get(gui.handles.pmchoicecase, 'Value');

if no_slip == 0
    switch(valcase)
        case{1}
            idm = sprintf('m'' = %.2f', gui.GB.results.mp_max1);
        case{2}
            idm = sprintf('m'' = %.2f', gui.GB.results.mp_max2);
        case{3}
            idm = sprintf('m'' = %.2f', gui.GB.results.mp_max3);
        case{4}
            idm = sprintf('m'' = %.2f', gui.GB.results.mp_min1);
        case{5}
            idm = sprintf('m'' = %.2f', gui.GB.results.mp_min2);
        case{6}
            idm = sprintf('m'' = %.2f', gui.GB.results.mp_min3);
        case{7}
            idm = sprintf('m''(SF) = %.2f', gui.GB.results.mp_SFmax);
        case{8}
            idm = sprintf('RBV = %.2f', gui.GB.results.rbv_max1);
        case{9}
            idm = sprintf('RBV = %.2fa', gui.GB.results.rbv_max2);
        case{10}
            idm = sprintf('RBV = %.2f', gui.GB.results.rbv_max3);
        case{11}
            idm = sprintf('RBV = %.2f', gui.GB.results.rbv_min1);
        case{12}
            idm = sprintf('RBV = %.2f', gui.GB.results.rbv_min2);
        case{13}
            idm = sprintf('RBV = %.2f', gui.GB.results.rbv_min3);
        case{14}
            idm = sprintf('RBV(SF) = %.2f', gui.GB.results.rbv_SFmax);
        case{15}
            idm = sprintf('N-fact = %.2f', gui.GB.results.nfact_max1);
        case{16}
            idm = sprintf('N-fact = %.2f', gui.GB.results.nfact_max2);
        case{17}
            idm = sprintf('N-fact = %.2f', gui.GB.results.nfact_max3);
        case{18}
            idm = sprintf('N-fact = %.2f', gui.GB.results.nfact_min1);
        case{19}
            idm = sprintf('N-fact = %.2f', gui.GB.results.nfact_min2);
        case{20}
            idm = sprintf('N-fact = %.2f', gui.GB.results.nfact_min3);
        case{21}
            idm = sprintf('N-fact(SF) = %.2f', gui.GB.results.nfact_SFmax);
        case{22}
            idm = sprintf('LRB-fact = %.2f', gui.GB.results.LRBfact_max1);
        case{23}
            idm = sprintf('LRB-fact = %.2f', gui.GB.results.LRBfact_max2);
        case{24}
            idm = sprintf('LRB-fact = %.2f', gui.GB.results.LRBfact_max3);
        case{25}
            idm = sprintf('LRB-fact = %.2f', gui.GB.results.LRBfact_min1);
        case{26}
            idm = sprintf('LRB-fact = %.2f', gui.GB.results.LRBfact_min2);
        case{27}
            idm = sprintf('LRB-fact = %.2f', gui.GB.results.LRBfact_min3);
        case{28}
            idm = sprintf('LRB-fact(SF) = %.2f', ...
                gui.GB.results.LRBfact_SFmax);
        case{29}
            idm = sprintf('SF(GB) = %.2f', ...
                gui.GB.results.GB_Schmid_Factor_max);
        case{30}
            idm = sprintf(['m'' = %.2f | RBV = %.2f | ', ...
                'N-fact = %.2f | LRB-fact = %.2f'], ...
                gui.GB.mprime_specific, gui.GB.rbv_specific, ...
                gui.GB.nfact_specific, gui.GB.LRBfact_specific);
    end
    
elseif no_slip == 1
    idm = sprintf('m'' = %s','NaN');
end

%% New title of the plot
if valcase ~= 30
    title(sprintf('%s | %s | %s | %s | %s | %s ', ...
        idgb, idgra, idgrb, idmis, idcaxis_mis, idm),...
        'color', [0 0 0],'BackgroundColor', [1 1 1]);
else
    title(sprintf('%s | %s | %s | %s ', ...
        idgb, idmis, idcaxis_mis, idm),...
        'color', [0 0 0],'BackgroundColor', [1 1 1]);
end

del_if_handle({'h_lblA', 'h_lblB'})

text(shiftXYZA(1)-gui.GB_geometry.gb_vec(1), ...
    shiftXYZA(2)-gui.GB_geometry.gb_vec(2), -2.5,...
    idgra, 'HorizontalAlignment', 'center');

text(shiftXYZB(1)-gui.GB_geometry.gb_vec(1), ...
    shiftXYZB(2)-gui.GB_geometry.gb_vec(2), -2.5,...
    idgrb, 'HorizontalAlignment', 'center');

end