% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function preCPFE_load_mesh(interface)
%% Function to load CPFE model mesh as a YAML file
% See in http://code.google.com/p/yamlmatlab/
% interface: type of interface (1 for SX or 2 for BX meshing interface)

% author: d.mercier@mpie.de

[YAML_mesh_config_file, YAML_mesh_config_path] = ...
    uigetfile('*.yaml', 'Load mesh in a YAML config. file as');

YAML_MESH = fullfile(YAML_mesh_config_path, YAML_mesh_config_file);

% Handle canceled file selection
if YAML_mesh_config_file == 0
    YAML_MESH = '';
end

if isequal(YAML_mesh_config_file, 0) ...
        || strcmp(YAML_mesh_config_file, '') == 1
    disp('User selected Cancel');
else
    disp(['User selected :', YAML_MESH]);
    
    mesh_variables = ReadYaml(YAML_MESH);
    
    gui = guidata(gcf);
    set(gui.handles.other_setting.mesh_quality_lvl_val, ...
        'String', mesh_variables.mesh_quality_lvl);
    
    fem_software = gui.config.CPFEM.fem_solver_used(1:3);
    
    if interface == 1 %SX
        
        set(gui.handles.mesh.D_sample_val, ...
            'String', mesh_variables.D_sample);
        set(gui.handles.mesh.h_sample_val, ...
            'String', mesh_variables.h_sample);
        set(gui.handles.mesh.r_center_frac_val, ...
            'String', mesh_variables.r_center_frac);
        set(gui.handles.mesh.box_xfrac_val, ...
            'String', mesh_variables.box_xfrac);
        set(gui.handles.mesh.box_zfrac_val, ...
            'String', mesh_variables.box_zfrac);
        set(gui.handles.mesh.sample_rep_val, ...
            'String', mesh_variables.sample_rep);
        set(gui.handles.mesh.box_elm_nx_val, ...
            'String', mesh_variables.box_elm_nx);
        set(gui.handles.mesh.box_elm_nz_val, ...
            'String', mesh_variables.box_elm_nz);
        set(gui.handles.mesh.radial_divi_val, ...
            'String', mesh_variables.radial_divi);
        
        if strfind(fem_software, 'Aba')
            set(gui.handles.mesh.box_bias_x_val, ...
                'String', mesh_variables.box_bias_x_abaqus);
            set(gui.handles.mesh.box_bias_z_val, ...
                'String', mesh_variables.box_bias_z_abaqus);
            set(gui.handles.mesh.box_bias_conv_x_val, ...
                'String', mesh_variables.box_bias_conv_x_abaqus);
        elseif strfind(fem_software, 'Men ')
            set(gui.handles.mesh.box_bias_x_val, ...
                'String', mesh_variables.box_bias_x_mentat);
            set(gui.handles.mesh.box_bias_z_val, ...
                'String', mesh_variables.box_bias_z_mentat);
            set(gui.handles.mesh.box_bias_y1_val, ...
                'String', mesh_variables.box_bias_conv_x_mentat);
        end
        
        preCPFE_indentation_setting_SX;
        
    elseif interface == 2 %BX
        set(gui.handles.mesh.w_sample_val, ...
            'String', mesh_variables.w_sample);
        set(gui.handles.mesh.h_sample_val, ...
            'String', mesh_variables.h_sample);
        set(gui.handles.mesh.len_sample_val, ...
            'String', mesh_variables.len_sample);
        set(gui.handles.mesh.ind_dist_val, ...
            'String', mesh_variables.ind_dist);
        set(gui.handles.mesh.box_elm_nx_val, ...
            'String', mesh_variables.box_elm_nx);
        set(gui.handles.mesh.box_elm_nz_val, ...
            'String', mesh_variables.box_elm_nz);
        set(gui.handles.mesh.box_elm_ny1_val, ...
            'String', mesh_variables.box_elm_ny1);
        set(gui.handles.mesh.box_elm_ny2_val, ...
            'String', mesh_variables.box_elm_ny2);
        set(gui.handles.mesh.box_elm_ny3_val, ...
            'String', mesh_variables.box_elm_ny3);
        
        if strfind(fem_software, 'Aba')
            set(gui.handles.mesh.box_bias_x_val, ...
                'String', mesh_variables.box_bias_x_abaqus);
            set(gui.handles.mesh.box_bias_z_val, ...
                'String', mesh_variables.box_bias_z_abaqus);
            set(gui.handles.mesh.box_bias_y1_val, ...
                'String', mesh_variables.box_bias_y1_abaqus);
            set(gui.handles.mesh.box_bias_y2_val, ...
                'String', mesh_variables.box_bias_y2_abaqus);
            set(gui.handles.mesh.box_bias_y3_val, ...
                'String', mesh_variables.box_bias_y3_abaqus);
        elseif strfind(fem_software, 'Men ')
            set(gui.handles.mesh.box_bias_x_val, ...
                'String', mesh_variables.box_bias_x_mentat);
            set(gui.handles.mesh.box_bias_z_val, ...
                'String', mesh_variables.box_bias_z_mentat);
            set(gui.handles.mesh.box_bias_y1_val, ...
                'String', mesh_variables.box_bias_y1_mentat);
            set(gui.handles.mesh.box_bias_y2_val, ...
                'String', mesh_variables.box_bias_y2_mentat);
            set(gui.handles.mesh.box_bias_y3_val, ...
                'String', mesh_variables.box_bias_y3_mentat);
        end

        preCPFE_indentation_setting_BX;
    end
    
end

end