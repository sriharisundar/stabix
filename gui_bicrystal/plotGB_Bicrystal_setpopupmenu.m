% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function plotGB_Bicrystal_setpopupmenu
%% Function to set the popup menu into the Bicrystal GUI
% authors: d.mercier@mpie.de / c.zambaldi@mpie.de

%% Setting of Material popupmenu from map interface
gui = guidata(gcf);

listmat_str = {'Al';'Au';'Be';'Cd';'Co';'Cu';'Fe';'Mg';'Mo';'Nb';'Ni';'Ta';'Ti';'Sn';'Zn';'Zr'};

for ii = 1:size(listmat_str,1)
    if strcmp (listmat_str(ii), gui.GB.Material_A) == 1
        matAnum = ii;
    end
end

for ii = 1:size(listmat_str,1)
    if strcmp (listmat_str(ii), gui.GB.Material_B) == 1
        matBnum = ii;
    end
end

set(gui.handles.pmMatA, 'Value', matAnum);
set(gui.handles.pmMatB, 'Value', matBnum);

%% Setting of Phase popupmenu from map interface
liststruct_str = {'hcp';'bcc';'fcc'};

for ii = 1:size(liststruct_str,1)
    if strcmp (liststruct_str(ii), gui.GB.Phase_A) == 1
        StructAnum = ii;
    end
end

for ii = 1:size(liststruct_str,1)
    if strcmp (liststruct_str(ii), gui.GB.Phase_B) == 1
        StructBnum = ii;
    end
end

set(gui.handles.pmStructA, 'Value', StructAnum);
set(gui.handles.pmStructB, 'Value', StructBnum);
listSlipsA = slip_systems_names(gui.GB.Phase_A);
listSlipsB = slip_systems_names(gui.GB.Phase_B);
set(gui.handles.pmlistslipsA, 'String', listSlipsA, 'Value', 1);
set(gui.handles.pmlistslipsB, 'String', listSlipsB, 'Value', 1);

guidata(gcf, gui);

end
