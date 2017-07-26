function varargout = WFEM_view(varargin)
% WFEM_view MATLAB code for WFEM_view.fig
%      WFEM_view, by itself, creates a new WFEM_view or raises the existing
%      singleton*.
%
%      H = WFEM_view returns the handle to a new WFEM_view or the handle to
%      the existing singleton*.
%
%      WFEM_view('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WFEM_view.M with the given input arguments.
%
%      WFEM_view('Property','Value',...) creates a new WFEM_view or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WFEM_view_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WFEM_view_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WFEM_view

% Last Modified by GUIDE v2.5 03-Feb-2017 08:35:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WFEM_view_OpeningFcn, ...
                   'gui_OutputFcn',  @WFEM_view_OutputFcn, ...
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


% --- Executes just before WFEM_view is made visible.
function WFEM_view_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WFEM_view (see VARARGIN)

% Choose default command line output for WFEM_view
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WFEM_view wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WFEM_view_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in input_data.
function input_data_Callback(hObject, eventdata, handles)
% hObject    handle to input_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Filename,Pathname]=uigetfile({'*.dat;*.txt','File format(*.dat,*.txt)';...
    '*.*','All Files (*.*)'},'d:\samples\'); 
if isempty(Filename)
    return
end
Infile=[Pathname,Filename];
if Filename(end-3:end)=='.dat'
    a1=load([Infile]);
elseif Filename(end-3:end)=='.txt'
    [a b]=textread([Infile],'%n%n','headerlines',18);
    a1=[a b];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
InfoMat=load('SignalInfo.dat');
rowNum=str2double(Filename(end-25))+1;
Fs=InfoMat(rowNum,3); 
Lowf=InfoMat(rowNum,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.Fs=Fs;
handles.Lowf=Lowf;
a2=a1;
c1=a2(:,1)/Fs;
newA=[c1 a2(:,2)];


axes(handles.axes2)
Fs=handles.Fs;
L=length(c1);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
YY = fft(a2(:,2),NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
semilogx(f,2*abs(YY(1:NFFT/2+1)))  
handles.AAmat=[f' 2*abs(YY(1:NFFT/2+1))];
xlabel('Frequency/Hz')
ylabel('Amplitude')
grid

axes(handles.axes1)
plot(newA(1:handles.Fs/handles.Lowf*2,1),newA(1:handles.Fs/handles.Lowf*2,2));
xlim([min(newA(1:handles.Fs/handles.Lowf*2,1)) max(newA(1:handles.Fs/handles.Lowf*2,1))]);
xlabel('Time/s');
ylabel('voltage/');
Matrix=[f' 2*abs(YY(1:NFFT/2+1))];
[aId bId]=max(Matrix(:,2));
yBand1=20*Matrix(bId,2);
ylim([-yBand1 yBand1])

handles.yBand=yBand1;
handles.aa=newA;
handles.aa0=newA;
handles.aa1=newA;
handles.a2=a2;
handles.c1=c1;
handles.wheel=0;
guidata(hObject,handles);


% --- Executes on slider movement.
function time_slider_Callback(hObject, eventdata, handles)
% hObject    handle to time_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider_value=get(hObject,'value');
set(handles.time_slider, 'SliderStep', [1.5/1000 15/1000]);
hsttext = uicontrol('style','text','BackgroundColor','white',...
          'string',num2str(round(slider_value)),'position',[100,300,40,15]);
num=slider_value;

A=handles.aa;
r=size(A,1);
window=handles.Fs/handles.Lowf*2;
AA=A(round(num*(r-window)/500+1):round(num*(r-window)/500+window),:);
axes(handles.axes1)
plot(AA(1:length(AA),1),AA(1:length(AA),2))
handles.aa1=AA;
guidata(hObject,handles);
xlim([min(AA(1:length(AA),1)) max(AA(1:length(AA),1))]);
yB=handles.yBand;
ylim([-yB yB])
xlabel('Time/s');
ylabel('Electric field/mv');

axes(handles.axes2)
Fs=handles.Fs;
L=length(AA(:,1));
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
YY = fft(AA(:,2),NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
semilogx(f,2*abs(YY(1:NFFT/2+1)))
handles.AAmat=[f' 2*abs(YY(1:NFFT/2+1))];
xlabel('Frequency/Hz')
ylabel('Amplitude')
grid
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function time_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Frequency_slinder_Callback(hObject, eventdata, handles)
% hObject    handle to Frequency_slinder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Frequency_slinder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frequency_slinder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function clearbutton_Callback(hObject, eventdata, handles)
cla(handles.axes1,'reset')
cla(handles.axes2,'reset')
handles.aa=handles.aa0;
%updates gui data
guidata(hObject, handles);


% There is still a small problem of this function!!!
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)

a1=handles.aa1;
minX=min(a1(:,1));
maxX=max(a1(:,1));
minY=min(a1(:,2));
maxY=max(a1(:,2));
MousePosition=get(handles.axes1,'currentpoint');
a=MousePosition;
if a(1,1)>=minX && a(1,1)<=maxX && a(1,2)>=minY && a(1,2)<maxY
    wheelValue=-eventdata.VerticalScrollCount;
else
    wheelValue=0;
end
wheel1=handles.wheel;
wheel1=wheel1+wheelValue;
if wheel1<0
    wheel1 = 0;
end
handles.wheel=wheel1;
set(handles.text2,'string',num2str(wheel1));
guidata(hObject,handles);
MousePosition=get(gca,'currentpoint');
a=MousePosition;
spaceX=maxX-minX;
spaceY=maxY-minY;
x=a(1,1);
y=a(1,2);
axes(handles.axes1)
if wheel1~=0
 if (x-spaceX/2/(wheel1+1))>=minX && (x+spaceX/2/(wheel1+1))<=maxX
    
   if (y-spaceY/2/(wheel1+1))<=minY 
       axis([x-spaceX/2/(wheel1) x+spaceX/2/(wheel1) minY y+spaceY/2/(wheel1)]);
   elseif (y+spaceY/2/(wheel1+1))>=maxY
       axis([x-spaceX/2/(wheel1) x+spaceX/2/(wheel1) y-spaceY/2/(wheel1) maxY]);
   else
       axis([x-spaceX/2/(wheel1) x+spaceX/2/(wheel1) ...
           y-spaceY/2/(wheel1) y+spaceY/2/(wheel1)]);
   end
   
 elseif (x-spaceX/2/(wheel1+1))<minX
    
    if (y-spaceY/2/(wheel1+1))<=minY
        axis([minX x+spaceX/2/(wheel1) minY y+spaceY/2/(wheel1)]);
    elseif (y+spaceY/2/(wheel1+1))>=maxY
        axis([minX x+spaceX/2/(wheel1) y-spaceY/2/(wheel1) maxY]);
    else
        axis([minX x+spaceX/2/(wheel1)  y-spaceY/2/(wheel1) y+spaceY/2/(wheel1)]);
    end
    
 elseif (x+spaceX/2/(wheel1+1))>maxX
    
    if (y-spaceY/2/(wheel1+1))<=minY
        axis([x-spaceX/2/(wheel1) maxX minY y+spaceY/2/(wheel1)]); 
    elseif (y+spaceY/2/(wheel1+1))>=maxY
        axis([x-spaceX/2/(wheel1) maxX y-spaceY/2/(wheel1) maxY]);
    else
        axis([x-spaceX/2/(wheel1) maxX y-spaceY/2/(wheel1) y+spaceY/2/(wheel1)]);
    end
 end
else
    axis([minX maxX minY maxY]);
end
