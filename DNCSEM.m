function varargout = DNCSEM(varargin)
% DNCSEM MATLAB code for DNCSEM.fig
%      DNCSEM, by itself, creates a new DNCSEM or raises the existing
%      singleton*.
%
%      H = DNCSEM returns the handle to a new DNCSEM or the handle to
%      the existing singleton*.
%
%      DNCSEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DNCSEM.M with the given input arguments.
%
%      DNCSEM('Property','Value',...) creates a new DNCSEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DNCSEM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DNCSEM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DNCSEM

% Last Modified by GUIDE v2.5 22-Jul-2017 08:58:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DNCSEM_OpeningFcn, ...
                   'gui_OutputFcn',  @DNCSEM_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before DNCSEM is made visible.
function DNCSEM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DNCSEM (see VARARGIN)

% Choose default command line output for DNCSEM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DNCSEM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DNCSEM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function process_Callback(hObject, eventdata, handles)
% hObject    handle to process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tools_Callback(hObject, eventdata, handles)
% hObject    handle to tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function intro_Callback(hObject, eventdata, handles)
% hObject    handle to intro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function grid_Callback(hObject, eventdata, handles)
% hObject    handle to grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function contents_Callback(hObject, eventdata, handles)
% hObject    handle to contents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents
% --------------------------------------------------------------------
function tutorial_Callback(hObject, eventdata, handles)
% hObject    handle to tutorial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tutorial

% --------------------------------------------------------------------
function aboutEM_pro_Callback(hObject, eventdata, handles)
% hObject    handle to aboutEM_pro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
aboutempro

% --------------------------------------------------------------------
function fourier_Callback(hObject, eventdata, handles)
% hObject    handle to fourier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('https://en.wikipedia.org/wiki/Fourier_transform');

% --------------------------------------------------------------------
function wavelet_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('https://en.wikipedia.org/wiki/Wavelet');

% --------------------------------------------------------------------
function ode_Callback(hObject, eventdata, handles)
% hObject    handle to ode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('https://en.wikipedia.org/wiki/Overdetermined_system');

% --------------------------------------------------------------------
function interpolate_Callback(hObject, eventdata, handles)
% hObject    handle to interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function filters_Callback(hObject, eventdata, handles)
% hObject    handle to filters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function statistic_Callback(hObject, eventdata, handles)
% hObject    handle to statistic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fourier_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to fourier_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function wavelet_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to wavelet_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cwt_edit_1
%cwt_analysis_6

% --------------------------------------------------------------------
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
WFEM_view

% --------------------------------------------------------------------
function fre_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fre_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function time_edit_Callback(hObject, eventdata, handles)
% hObject    handle to time_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function load_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
readfile3
handles.data=data;
guidata(hObject, handles);

% --------------------------------------------------------------------
function save_data_Callback(hObject, eventdata, handles)
% hObject    handle to save_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save datas

% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('Are you sure ?','Close or not','yes','no','yes');
if strcmp(button,'yes')
    close(gcf)
else
    return;
end

% --------------------------------------------------------------------
function read_file_Callback(hObject, eventdata, handles)
% hObject    handle to read_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resize_WFEMdata_2
%readfile3

% --------------------------------------------------------------------
function read_data_Callback(hObject, eventdata, handles)
% hObject    handle to read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
read_data_3

handles.Y=Y;
handles.f=f;
handles.L=L;
handles.filename0=filename0;
handles.Y3=Y3;
handles.Y2=Y2;
handles.T=T;
handles.T=T;
handles.kk1=kk1;
handles.fre=fre;
guidata(hObject, handles);

% --------------------------------------------------------------------
function resize_data_Callback(hObject, eventdata, handles)
% hObject    handle to resize_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Y=handles.Y;
f=handles.f;
L=handles.L;
Y3=handles.Y3;
kk1=handles.kk1;
filename0=handles.filename0;
T=handles.T;
fre=handles.fre;
figure(2);
%resize_data_1
resize_data_2_1
handles.Fs2=Fs2;
handles.Y3=Y3;
guidata(hObject, handles);

% --------------------------------------------------------------------
function rect_1_Callback(hObject, eventdata, handles)
% hObject    handle to rect_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rectangle_plot_1

% --------------------------------------------------------------------
function odes_1_Callback(hObject, eventdata, handles)
% hObject    handle to odes_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ODE_1st_1_3_LegendrePoly_1228
ODE_1st_1_4_forAllFre_3
handles.fre_mat=fre_mat;
handles.f0=f0;
handles.f=f;
handles.Fre_index=Fre_index;
handles.magn1=magn1;
handles.Amplifier=Amplifier;
handles.col_num1=col_num1;
handles.m1=m1;
handles.Filename=Filename;
handles.Pathname=Pathname;
handles.const_mat=const_mat;
handles.X1=X1;
handles.NewMatA1=NewMatA1;
handles.MatA=MatA;
handles.Y=Y;
handles.chosen_col=chosen_col;
handles.magn=magn;
handles.x_nums=x_nums;
save data1 balance balance1 m bb L Fs c accuracy X3
%save data1
guidata(hObject, handles);



% --------------------------------------------------------------------
function rect_2_Callback(hObject, eventdata, handles)
% hObject    handle to rect_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rectangle_plot_2

% --------------------------------------------------------------------
function odes_2_Callback(hObject, eventdata, handles)
% hObject    handle to odes_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
col_num1=handles.col_num1;
f0=handles.f0;
m1=handles.m1;
const_mat=handles.const_mat;
NewMatA1=handles.NewMatA1;
X1=handles.X1;
Y=handles.Y;
chosen_col=handles.chosen_col;
x_nums=handles.x_nums;
Fre_index=handles.Fre_index;
magn=handles.magn;
MatA=handles.MatA;
load data1
data0=load(handles.Filename);
%ODE_2nd_1_3_LegendrePoly_1228
ODE_2nd_1_4_forAllFre
handles.col_num1=col_num1;
handles.m1=m1;
handles.const_mat=const_mat;
handles.NewMatA1=NewMatA1;

handles.magn1=magn1;
handles.Amplifier=Amplifier;
%save data1
guidata(hObject, handles);




% --------------------------------------------------------------------
function noiseFreEdit_Callback(hObject, eventdata, handles)
% hObject    handle to noiseFreEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function SpectrumEdit_Callback(hObject, eventdata, handles)
% hObject    handle to SpectrumEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
spectrum_edit

% --------------------------------------------------------------------
function NoiseFreToZero_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseFreToZero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Y3=handles.Y3;
filename0=handles.filename0;
T=handles.T;
Fs2=handles.Fs2;
%PutNoiseFreToZero_1
PutNoiseFreToZero_2


% --------------------------------------------------------------------
function extractInfo_Callback(hObject, eventdata, handles)
% hObject    handle to extractInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run([pwd,'\extract_info\NoiseLevelEstimateForCSEM_2.m'])
run([pwd,'\extract_info\DrawNormalizedExField_2.m'])


% --------------------------------------------------------------------
function pointedit_Callback(hObject, eventdata, handles)
% hObject    handle to pointedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function lineedit_Callback(hObject, eventdata, handles)
% hObject    handle to lineedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EM_Edit

% --------------------------------------------------------------------
function extract_pro_info_Callback(hObject, eventdata, handles)
% hObject    handle to extract_pro_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=handles.f;
f0=handles.f0;
X3=handles.X3;
Fre_index=handles.Fre_index;
magn1=handles.magn1;
col_num=handles.col_num;
Amplifier=handles.Amplifier;
Filename=handles.Filename;
Pathname=handles.Pathname;
fre_mat=handles.fre_mat;
magn=handles.magn;
data0=load(handles.Filename);
data=data0(2:end,1);
extract_infoAfterODEs
guidata(hObject, handles);


% --------------------------------------------------------------------
function cwt_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to cwt_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cwt_edit_2


% --------------------------------------------------------------------
function automatic_locations_choosing_Callback(hObject, eventdata, handles)
% hObject    handle to automatic_locations_choosing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PointsChosenAutomatic_0_1
ODE_1st_1_4_forAllFre_4_ForAuto
handles.fre_mat=fre_mat;
handles.col_num=col_num;
handles.f0=f0;
handles.f=f;
handles.Fre_index=Fre_index;
handles.magn1=magn1;
handles.Amplifier=Amplifier;
handles.col_num1=col_num1;
handles.m1=m1;
handles.Filename=Filename;
handles.Pathname=Pathname;
handles.const_mat=const_mat;
handles.X1=X1;
handles.NewMatA1=NewMatA1;
handles.MatA=MatA;
handles.Y=Y;
handles.chosen_col=chosen_col;
handles.magn=magn;
handles.x_nums=x_nums;
handles.X3=X3;
save data1 balance balance1 m bb L Fs c accuracy
%save data1
guidata(hObject, handles);
