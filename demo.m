% Copyright 2013 Max-Planck-Institut f�r Eisenforschung GmbH
function gui_handle = demo
%% Function to create the main window of the GUI (to select map, bicrystal or meshing interface)
%% Initialization
format compact;
tabularasa;

%% Initialization
if isempty(getenv('SLIP_TRANSFER_TBX_ROOT')) == 1
    errordlg('Run the path_management.m script !', 'File Error');
    return
end

% Check if MTEX is installed
gui.flag.installation_mtex = MTEX_check_install;

[startdir, f, ext] = fileparts(mfilename('fullpath'));
cd(startdir);

%% Set Matlab
gui.config_Matlab = load_YAML_config_file;

%% Main Window Coordinates Configuration
scrsize = screenSize;   % Get screen size
WX = 0.05 * scrsize(3); % X Position (bottom)
WY = 0.30 * scrsize(4); % Y Position (left)
WW = 0.20 * scrsize(3); % Width
WH = 0.45 * scrsize(4); % Height

%% Main Window Configuration
gui.handles.MainWindow_title = ['Main Menu', ' (',mfilename,'.m)', ' - version_', num2str(gui.config_Matlab.version_toolbox)];
gui.handles.MainWindow = figure('Name', gui.handles.MainWindow_title,...
    'NumberTitle', 'off',...
    'PaperUnits', get(0,'defaultfigurePaperUnits'),...
    'Color', [0.9 0.9 0.9],...
    'Colormap', get(0,'defaultfigureColormap'),...
    'toolBar', 'figure',...
    'InvertHardcopy', get(0,'defaultfigureInvertHardcopy'),...
    'PaperPosition', [0 7 50 15],...
    'Position', [WX WY WW WH]);

%% Title of the GUI
gui.handles.title_GUI = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.3 0.95 0.4 0.05],...
    'String', 'MWN2 Project',...
    'FontWeight', 'bold',...
    'FontSize', 12,...
    'HorizontalAlignment', 'center',...
    'ForegroundColor', 'red');

%% Run map interface to plot a map of grains with data From TSL
gui.handles.strinterfaceTSL = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.05 0.85 0.9 0.05],...
    'String', 'Import Data from TSL',...
    'FontWeight', 'bold',...
    'FontSize', 12,...
    'HorizontalAlignment', 'center');

gui.handles.pbinterfaceTSL = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.05 0.75 0.9 0.1],...
    'BackgroundColor', [0.2 0.8 0],......
    'String', 'EBSD map interface',...
    'FontWeight', 'bold',...
    'FontSize', 10,...
    'HorizontalAlignment', 'center',...
    'Callback', 'A_gui_plotmap');

%% Run bicrystal interface
gui.handles.strinterfaceman = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.05 0.65 0.9 0.05],...
    'String', 'Bicrystal interface',...
    'FontWeight', 'bold',...
    'FontSize', 12,...
    'HorizontalAlignment', 'center');

gui.handles.pbGBManualInput_UCPlot = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.05 0.55 0.9 0.1],...
    'BackgroundColor', [0.2 0.8 1],...
    'String', 'Bicrystal => CPFEM',...
    'FontWeight', 'bold',...
    'FontSize', 10,...
    'HorizontalAlignment', 'center',...
    'Callback', 'A_gui_plotGB_Bicrystal');

%% FEM
gui.handles.strinterfaceman = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.05 0.45 0.9 0.05],...
    'String', 'CPFEM - Indentation setting + Sample Meshing',...
    'FontWeight', 'bold',...
    'FontSize', 12,...
    'HorizontalAlignment', 'center');

% SX set up
gui.handles.pbBX_meshing = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.05 0.35 0.4 0.1],...
    'BackgroundColor', [0.5 0.5 1],...
    'String', 'Single Crystal',...
    'FontWeight', 'bold',...
    'FontSize', 10,...
    'HorizontalAlignment', 'center',...
    'Callback', 'A_femproc_windows_indentation_setting_SX');

% BX set up
gui.handles.pbSX_meshing = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.55 0.35 0.4 0.1],...
    'BackgroundColor', [0.5 0.5 1],...
    'String', 'Bicrystal',...
    'FontWeight', 'bold',...
    'FontSize', 10,...
    'HorizontalAlignment', 'center',...
    'Callback', 'A_femproc_windows_indentation_setting_BX');

%% Clear all & Save & Quit & Help
gui.handles.pbhelp = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.05 0.2 0.3 0.1],...
    'String', 'HELP',...
    'Callback', 'gui = guidata(gcf); open_file_web(gui.config_Matlab.doc_path)');

gui.handles.pbfinishsav = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.05 0.1 0.3 0.1],...
    'String', 'CLOSE',...
    'Callback', 'close(gcf)');

%% Logos of MPIE & MSU
% Check if license for Image_Toolbox is available
if license('checkout','Image_Toolbox') == 1
    gui.handles.plotlogoMPIE_axes = axes('Parent', gui.handles.MainWindow,...
        'Position', [0.4 0.02 0.55 0.36],...
        'CameraPositionMode', get(0,'defaultaxesCameraPositionMode'),...
        'Color', get(0,'defaultaxesColor'),...
        'ColorOrder', get(0,'defaultaxesColorOrder'),...
        'LooseInset', [0.13 0.11 0.095 0.075],...
        'XColor', get(0,'defaultaxesXColor'),...
        'YColor', get(0,'defaultaxesYColor'),...
        'ZColor', get(0,'defaultaxesZColor'),...
        'Tag', 'axes1');
    
    [logo, map]  = imread('logo_MPIE_MSU.bmp');
    plotlogoMPIE = imshow(logo, map);
    axis off; % Remove axis ticks and numbers
    axis image; % Set aspect ratio to obtain square pixels
end

%% Version of the GUI & Contact
gui.version = 'Version 1.0';

gui.handles.str_version = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.05 0.03 0.3 0.04],...
    'HorizontalAlignment', 'center',...
    'String', gui.version,...
    'FontWeight', 'bold',...
    'FontSize', 10);

gui.handles.pb_contact        = uicontrol('Parent', gui.handles.MainWindow,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.5 0.03 0.35 0.08],...
    'String', 'Contact',...
    'FontWeight', 'bold',...
    'FontSize', 10,...
    'HorizontalAlignment', 'center',...
    'Callback', 'help_dlgbox(''zambaldi@mpie.de / d.mercier@mpie.de'',''Contact'')');

guidata(gcf, gui);

gui_handle = gui.handles.MainWindow;

end
