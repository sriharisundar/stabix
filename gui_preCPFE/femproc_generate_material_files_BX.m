% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function femproc_generate_material_files_BX
%% Generation of material config file (GENMAT OR DAMASK) for BX indentation
% authors: d.mercier@mpie.de / c.zambaldi@mpie.de

gui_BX = guidata(gcf);

%% Material config file for GENMAT
if strcmp(gui_BX.config_CPFEM.simulation_code, 'GENMAT') == 1
    %% Creation of the material.mpie file with Euler angles (for GENMAT)
    % Add no comment in the material.mpie file !!! ==> Error
    % You have to remove the end of the name of the material file in order to set the
    % name of this file as "material.mpie"...(only for GENMAT)
    scriptname_material = sprintf('material.mpie');
    
    fid = fopen(scriptname_material,'w+');
    fprintf(fid, 'material.mpie, generated by %s.m for indent %s\n', mfilename, gui_BX.GB.Titlegbdatacompl);
    fprintf(fid, '2,1,18\n');
    fprintf(fid, '#1 Data for Grain %s\n', num2str(gui_BX.GB.GrainA));
    fprintf(fid, '6, 6, 18, 1, 0 \n');
    fprintf(fid, '1, %s, %s, %s, 0, 0.50, 1\n', num2str(gui_BX.GB.eulerA(1)), num2str(gui_BX.GB.eulerA(2)), num2str(gui_BX.GB.eulerA(3)));
    fprintf(fid, '#2 Data for Grain %s\n', num2str(gui_BX.GB.GrainB));
    fprintf(fid, '6, 6, 18, 1, 0\n');
    fprintf(fid, '1, %s, %s, %s, 0, 0.50, 1\n',  num2str(gui_BX.GB.eulerB(1)), num2str(gui_BX.GB.eulerB(2)), num2str(gui_BX.GB.eulerB(3)));
    fclose(fid);
    
    try
        movefile(scriptname_material, gui_BX.path_config_file);
    catch err
        errordlg(err.message);
    end
    
    %% Copy material_<structure>.mpie (for GENMAT)
    genmat = struct();
    genmat.material_fname = struct;
    genmat.material_fname.fcc = 'material_fcc.mpie';
    genmat.material_fname.bcc = 'material_bcc.mpie';
    genmat.material_fname.hcp = 'material_hcp.mpie';
    genmat_material_dir = fullfile(getenv('SLIP_TRANSFER_TBX_ROOT'),'gui_preCPFE','genmat','');
    phaseA = gui_BX.GB.Phase_A;
    if iscell(phaseA)
        phaseA = phaseA{1};
    end
    fnameA = fullfile(genmat_material_dir, genmat.material_fname.(phaseA));
    copyfile(fnameA, gui_BX.path_config_file)
    phaseB = gui_BX.GB.Phase_B;
    if iscell(phaseB)
        phaseB = phaseB{1}
    end
    fnameB = fullfile(genmat_material_dir, genmat.material_fname.(phaseB));
    copyfile(fnameB, gui_BX.path_config_file)

    
    %% Material config file for DAMASK
elseif strcmp(gui_BX.config_CPFEM.simulation_code, 'DAMASK') == 1
    %% Creation of the material.config file with Euler angles (for DAMASK)
    scriptname_DAMASK_materialconfig = sprintf('%s_DAMASK_materialconfig.py', gui_BX.GB.Titlegbdatacompl);
    
    fid = fopen(scriptname_DAMASK_materialconfig,'w+');
    fprintf(fid, '# Generated by matlab/gui/femproc_generate_material_files.m --- DO NOT EDIT\n');
    fprintf(fid, 'import sys\n');
    fprintf(fid, 'p=''%s'' \n', gui_BX.config_CPFEM.msc_module_path);
    fprintf(fid, 'if p not in sys.path: sys.path.insert(0,p) \n');
    fprintf(fid, 'import scipy.io\n');
    fprintf(fid, 'gb_data = scipy.io.loadmat(''%s'')\n', gui_BX.GB.Titlegbdata);
    fprintf(fid, 'import msc\n');
    fprintf(fid, 'import msc.generate_material_config_file as damask_mat\n');
    if ismac || isunix
        fprintf(fid, 'damask_mat.mat_config(gb_data, proc_path=r''%s/%s'')\n', gui_BX.config_CPFEM.proc_file_path, gui_BX.GB.Titlegbdata);
    else
        fprintf(fid, 'damask_mat.mat_config(gb_data, proc_path=r''%s\\%s'')\n', gui_BX.config_CPFEM.proc_file_path, gui_BX.GB.Titlegbdata);
    end
    fclose(fid);
    % execute the python code that we just generated
    %cmd = sprintf('%s %s"',config.python_executable, scriptname);
    cmd = sprintf('%s %s', gui_BX.config_CPFEM.python_executable, fullfile(pwd, scriptname_DAMASK_materialconfig));
    commandwindow;
    system(cmd);
    
    try
        movefile(scriptname_DAMASK_materialconfig, gui_BX.path_config_file);
    catch err
        errordlg(err.message);
    end
    
    %% Move of material.config in the corresponding modeling folder (for DAMASK)
    %titlegbdata=sprintf('%s.MaterialConfig', gui_BX.GB.titlegbdata);
    %try
    %movefile(titlegbdata, path_config_file);
    %catch err
    %errordlg(err.message);
    %end
    
    try
        movefile('material.config', gui_BX.path_config_file);
    catch err
        errordlg(err.message);
    end
    
end

guidata(gcf, gui_BX);

end

