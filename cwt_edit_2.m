function varargout = cwt_edit_2(varargin)
% CWT_EDIT_2 MATLAB code for cwt_edit_2.fig
%      CWT_EDIT_2, by itself, creates a new CWT_EDIT_2 or raises the existing
%      singleton*.
%
%      H = CWT_EDIT_2 returns the handle to a new CWT_EDIT_2 or the handle to
%      the existing singleton*.
%
%      CWT_EDIT_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CWT_EDIT_2.M with the given input arguments.
%
%      CWT_EDIT_2('Property','Value',...) creates a new CWT_EDIT_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cwt_edit_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cwt_edit_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cwt_edit_2

% Last Modified by GUIDE v2.5 02-Mar-2017 21:08:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cwt_edit_2_OpeningFcn, ...
                   'gui_OutputFcn',  @cwt_edit_2_OutputFcn, ...
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

% --- Executes on button press in loaddata.
function loaddata_Callback(hObject, eventdata, handles)
% hObject    handle to loaddata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Filename,Pathname,FilterIndex]=uigetfile({'*.dat;*.txt','File format(*.dat,*.txt)';...
    '*.*','All Files (*.*)'},'d:\samples\'); 

if ~FilterIndex
    return
else


[Filename_fre,Pathname,FilterIndex]=uigetfile({'*.dat;*.txt','File format(*.dat,*.txt)';...
    '*.*','All Files (*.*)'}); 
fre_mat=load(Filename_fre);
Lowest=fre_mat(1,1);
contour_num=8;
multiple=2;

a1=load(Filename);
samplingF=8;
a=a1(2:samplingF:end,1);
Fs=a1(1,1)/samplingF;
t=linspace(1,length(a),length(a));

axes(handles.axes4)
plot(a);grid
xlim([0 length(a)])

axes(handles.axes1)
numOctave = 6;
numVoices = 2;
a0 = 2^(1/numVoices);
freq = Lowest/2*a0.^(1:numOctave*numVoices);

f0=centfrq('morl');
%f0=1.5;
dt=1/Fs;
%freq=[0.1:0.1:100];
m_fre=0;
vec_order=1:200;
cwta1 = cwtft(a,'wavelet','morl','scales',f0./freq*Fs); %f0./[1:1:100]*Fs

mat=abs(cwta1.cfs);
norm=diag(freq.^0.5);
[cs0, h0] = contour(t,freq,norm*mat,multiple*contour_num);%colorbar
    %clabel(cs, h, 'labelspacing', 10);
    grid
    xlabel({'Second/s';'(b)'},'fontsize',16);
    ylabel('Frequency/Hz','fontsize',16);
    set(gca,'LineWidth',2)

    set(handles.slider8,'value',freq(end));
    set(handles.slider8,'Max',freq(end))
    
handles.samplingF=samplingF;
handles.A=a1;
handles.Nmat=norm*mat;
n=0;
n0=0;
n1=0;
zoom_num=0;
pos1=zeros(10,4);
pos=zeros(100,4);
Axes_Limit=get(handles.axes1,'Ylim');
AxesX_Limit=get(handles.axes1,'Xlim');
V_w0=abs(Axes_Limit(2)-Axes_Limit(1));
handles.V_w0=V_w0;
w=AxesX_Limit(2)-AxesX_Limit(1);

handles.t=t;
handles.freq=freq;
handles.norm=norm;
handles.mat=mat;
handles.multiple=multiple;

handles.freq=freq;
handles.w0=w;
handles.t=t;
handles.w=w;
handles.n=n;
handles.n1=n1;
handles.n0=n0;
handles.zoom_num=zoom_num;
handles.pos1=pos1;
handles.pos=pos;
handles.L=length(a1);
guidata(hObject, handles);
end

% --- Executes just before cwt_edit_2 is made visible.
function cwt_edit_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cwt_edit_2 (see VARARGIN)

% Choose default command line output for cwt_edit_2
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
set(handles.slider_H,'value',0.5);
set(handles.slider_V,'value',0.5);

% UIWAIT makes cwt_edit_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cwt_edit_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in edit.
function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
axes(handles.axes1)
pos=handles.pos;
n=handles.n+1;
h=imrect();
setColor(h,'r')
pos(n,:)=getPosition(h);
handles.pos=pos;
handles.n=n;
handles.h=h;
% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in confirm.
function confirm_Callback(hObject, eventdata, handles)
% hObject    handle to confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
pos=handles.pos;
pos1=pos;
samplingF=handles.samplingF;
pos2=pos1;
pos2(:,1)=pos2(:,1)*samplingF;
pos2(:,3)=pos2(:,3)*samplingF;
pos_n=find(pos(:,1)==0);
pos(pos_n,:)=[];
%disp(pos)
num=size(pos);
for x=1:num(1)
    imrect(gca,pos(x,:));
end

save mdfy_point1.dat pos2 -ascii
guidata(hObject, handles);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axes(handles.axes1)
slider_value=get(hObject,'value');
num=slider_value;
a2=handles.A;
l=handles.L;
index=round(num*l);
w=handles.w;
if index+w<l;max_1=max(abs(a2(index:index+w)));xlim([index index+w]);
else max_1=max(abs(a2(l-w:l))); xlim([l-w l]);end
%ylim([-max_1-10 max_1+10]);
set(handles.slider1, 'SliderStep', [300/l 30/l]);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
% hObject    handle to delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.h)
n=handles.n-1;
handles.pos(n,:)=0;
handles.n=n;
guidata(hObject,handles);


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset')
cla(handles.axes2,'reset')
cla(handles.axes4,'reset')
%updates gui data
guidata(hObject, handles);

function figure1_WindowButtonDownFcn(hObject, eventdata, handles)


% --- Executes on button press in zoomin.
function zoomin_Callback(hObject, eventdata, handles)
% hObject    handle to zoomin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A1=handles.A;
axes(handles.axes1)
if handles.zoom_num>1
 delete(handles.zoomH)
end
zoomH=imrect;
setColor(zoomH,'g')
zoom_num=2;
handles.zoom_num=zoom_num;
pos2=getPosition(zoomH);
axes(handles.axes2)
zb1=ceil(pos2(1,1));
zb2=floor(pos2(1,1)+pos2(1,3));
zzb1=pos2(1,2);
zzb2=pos2(1,2)+pos2(1,4);
freq=handles.freq;
[r1,c1]=min(abs(zzb1-freq));
[r2,c2]=min(abs(zzb2-freq));
normMat=handles.Nmat;
t=handles.t;
[cs1, h1] = contour(t(zb1:zb2),freq(c1:c2),normMat(c1:c2,zb1:zb2),20);
handles.zoomH=zoomH;
guidata(hObject, handles);
% --- Executes on button press in zoom_conf.

% --- Executes on button press in zoomin_edit.
function zoomin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to zoomin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2)
pos=handles.pos;
pos1=handles.pos1;
zoom_e=imrect();
setColor(zoom_e,'r')
n=handles.n+1;
n1=handles.n1+1;
pos(n,:)=getPosition(zoom_e);
pos1(n1,:)=getPosition(zoom_e);
handles.pos=pos;
handles.pos1=pos1;
handles.n=n;
handles.n1=n1;
guidata(hObject, handles);



function zoom_conf_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_conf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

num=handles.n1;
pos1=handles.pos1;
axes(handles.axes1)

for x=1:num
    h=imrect(gca,pos1(x,:));
    setColor(h,'r')
end
delete(handles.zoomH);

cla(handles.axes2,'reset')
handles.n1=0;
pos1=zeros(100,4);
handles.pos1=pos1;
guidata(hObject, handles);

% --- Executes on button press in zoom_delete.
function zoom_delete_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.zoom_e)
n=handles.n-1;
handles.pos(n,:)=0;
handles.n=n;
guidata(hObject,handles);

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider_value2=get(hObject,'value');
num2=slider_value2;

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_H_Callback(hObject, eventdata, handles)
% hObject    handle to slider_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w0=handles.w0;
Axes_Limit=get(handles.axes1,'Xlim');%x???
Mid_coord=(Axes_Limit(1)+Axes_Limit(2))/2;
slider_H_value=get(hObject,'value');
w=floor(w0*2^((slider_H_value-0.5)*20));
half_w=ceil(w/2);
xlim([Mid_coord-half_w Mid_coord+half_w])
handles.w=w;
guidata(hObject, handles);


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_V_Callback(hObject, eventdata, handles)
% hObject    handle to slider_V (see GCBO) 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
V_w0=handles.V_w0;
Axes_Limit=get(handles.axes1,'Ylim');%x???
Mid_coord=(Axes_Limit(1)+Axes_Limit(2))/2;
slider_v_value=get(hObject,'value');
w=V_w0*(slider_v_value-0.5)*20;
half_w=w/2;
ylim([Mid_coord-half_w Mid_coord+half_w])
guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_V_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
slider_value7=get(hObject,'value');
slider_value8=get(handles.slider8,'value');
t=handles.t;
freq=handles.freq;
norm=handles.norm;
mat=handles.mat;
multiple=handles.multiple;
[cs1, h1]=contour(t,freq,norm*mat,multiple*slider_value7);%colorbar
set(handles.axes1,'ylim',[freq(1) slider_value8]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
freq=handles.freq;
slider_value8=get(hObject,'value');
set(handles.axes1,'ylim',[freq(1) slider_value8]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
