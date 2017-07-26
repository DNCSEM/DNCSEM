function varargout = EM_Edit(varargin)
% EM_EDIT MATLAB code for EM_Edit.fig
%      EM_EDIT, by itself, creates a new EM_EDIT or raises the existing
%      singleton*.
%
%      H = EM_EDIT returns the handle to a new EM_EDIT or the handle to
%      the existing singleton*.
%
%      EM_EDIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EM_EDIT.M with the given input arguments.
%
%      EM_EDIT('Property','Value',...) creates a new EM_EDIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EM_Edit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EM_Edit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EM_Edit

% Last Modified by GUIDE v2.5 09-May-2016 10:46:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EM_Edit_OpeningFcn, ...
                   'gui_OutputFcn',  @EM_Edit_OutputFcn, ...
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


% --- Executes just before EM_Edit is made visible.
function EM_Edit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EM_Edit (see VARARGIN)

% Choose default command line output for EM_Edit

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axis([0 1 0 1]);

% UIWAIT makes EM_Edit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EM_Edit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function loaddata_Callback(hObject, eventdata, handles)
[Filename,Pathname]=uigetfile('*.dat','d:\samples\');
Infile=[Pathname,Filename];
data=load([Infile]);
newdata=[data(:,1) log10(data(:,2:3))];

pointrow=data(:,1);
pr=pointrow;

% create the point list
c=zeros(1,length(pr));
c(1)=0;
n=1;
for x=1:1:length(pr)-1
  b(x)=pr(x)-pr(x+1);
  if b(x)~=0
     n=n+1;
     c(n)=x;
  end
end
c(n+1)=length(pr);
c(n+2:end)=[];
for y=1:length(c)-1
    point_names{y}=num2str(data(c(y)+1,1));
    pp(y)=data(c(y)+1,1);
end 

set(handles.listbox1,'String',point_names,'Value',1)
set(handles.listbox1,'value',1)

plot(newdata(c(1)+1:c(1),2),newdata(c(1)+1:c(1),3));
hold on 
plot(newdata(c(1)+1:c(1),2),newdata(c(1)+1:c(1),3),'b*');
axis equal
set(gca,'XDir','rev')

% add a radion button to dicide whether to make the command 'axis equal';
handles.lastSelection=get(handles.listbox1,'Value');
handles.pathname=Pathname;
handles.newdata1=newdata;
handles.aa=newdata(:,2:3);
guidata(hObject,handles)
handles.c1=c;
handles.wheel=0;
handles.pp1=pp;
handles.pointnames1=point_names;
handles.data=data;
handles.n=0;
guidata(hObject,handles)

function listbox1_Callback(hObject, eventdata, handles)
handles = guidata(gcbo);
pointnames2=handles.pointnames1;
ls=handles.lastSelection;
if handles.n==0
  newdata2=handles.newdata1;
else
  newdata2=handles.newdata2;
end
cla(handles.axes1,'reset')
if strcmp(get(handles.figure1,'SelectionType'),'normal')
    index_selected = get(handles.listbox1,'Value');
    point=pointnames2{index_selected};
    c2=handles.c1;
    target=handles.newdata1(c2(index_selected)+1:c2(index_selected+1),:);
    axes(handles.axes1)
    plot(target(:,2),target(:,3),'linewidth',1.5);
    hold on
    plot(target(:,2),target(:,3),'b*','MarkerSize',12);
    axis equal
    set(gca,'XDir','rev')
    valuechange=abs(ls-get(handles.listbox1,'Value'));
end
handles.lastSelection=get(handles.listbox1,'Value');
if handles.n>=1
 if valuechange==0 && ls==1
    newdata2(c2(ls)+1:c2(ls+1),:)=handles.target2;
 elseif valuechange~=0
    newdata2(c2(ls)+1:c2(ls+1),:)=handles.target2;
 end
end

handles.newdata2=newdata2;
handles.target1=target;

if handles.n==0
  handles.target2=target;
else
    newmat=handles.newdata2-handles.newdata1;
    handles.target2=handles.newdata2(c2(index_selected)...
        +1:c2(index_selected+1),:); 
  if  any(newmat(c2(index_selected)+1:c2(index_selected+1),3))
    hold on
    plot(handles.target2(:,2),handles.target2(:,3),'r','linewidth',1);
    hold on
    plot(handles.target2(:,2),handles.target2(:,3),'r*','MarkerSize',10);
  else
    hold on
    plot(handles.target2(:,2),handles.target2(:,3),'linewidth',1.5);
    hold on
    plot(handles.target2(:,2),handles.target2(:,3),'b*','MarkerSize',12);
  end
end

handles.lastvalue=index_selected;
handles.n=handles.n+1;
guidata(hObject,handles);



function listbox1_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function savebutton_Callback(hObject, eventdata, handles)
mat2=handles.newdata2;
mat1=handles.newdata1;
[filename,pathname,filterindex] = uiputfile( ...
{'*.dat', 'data files (*.dat)';
'*.txt','text Files (*.txt)';...
 '*.*',  'All Files (*.*)'},...
 'Save as',handles.pathname);
mat3=[mat2(:,1) 10.^mat2(:,2:3)];
str=strcat(pathname,filename);
save(str,'mat3','-ascii')
save([str(1:end-4),'_log10',str(end-3:end)],'mat2','-ascii')

function clearbutton_Callback(hObject, eventdata, handles)
cla(handles.axes1,'reset');
set(handles.listbox1,'string',[]);


function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)

a1=handles.aa;
minX=min(a1(:,1));
maxX=max(a1(:,1));
minY=min(a1(:,2));
maxY=max(a1(:,2));
MousePosition=get(gca,'currentpoint');
a=MousePosition;
Xb=get(handles.axes1,'xlim');
Yb=get(handles.axes1,'ylim');
if a(1,1)>Xb(1) && a(1,1)<Xb(2) && a(1,2)>Yb(1) && a(1,2)<Yb(2)
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
        axis([minX x+spaceX/2/(wheel1)  y-spaceY/2/(wheel1) ...
            y+spaceY/2/(wheel1)]);
    end
    
 elseif (x+spaceX/2/(wheel1+1))>maxX
    
    if (y-spaceY/2/(wheel1+1))<=minY
        axis([x-spaceX/2/(wheel1) maxX minY y+spaceY/2/(wheel1)]); 
    elseif (y+spaceY/2/(wheel1+1))>=maxY
        axis([x-spaceX/2/(wheel1) maxX y-spaceY/2/(wheel1) maxY]);
    else
        axis([x-spaceX/2/(wheel1) maxX y-spaceY/2/(wheel1) ...
            y+spaceY/2/(wheel1)]);
    end
 end
else
    axis([minX maxX minY maxY]);
end

function pointedit(hObject,eventdata,handles)

function figure1_ButtonDownFcn(hObject, eventdata, handles)

function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
handles = guidata(gcbo);
MousePosition=get(gca,'currentpoint');
a=MousePosition;
Xb=get(handles.axes1,'xlim');
Yb=get(handles.axes1,'ylim');
if Xb(1)==0 && Xb(2)==1 && Yb(1)==0 && Yb(2)==1
    return
else 
 if a(1,1)>Xb(1) && a(1,1)<Xb(2) && a(1,2)>Yb(1) && a(1,2)<Yb(2)
   target2=handles.target2;
   target3=handles.target1;
   if strcmp(get(handles.figure1,'SelectionType'),'open')
      [minT minNum]=min(abs(a(1,1)-target2(:,2)));
      target2(minNum,3)=a(1,2);
      axis([Xb(1) Xb(2) Yb(1) Yb(2)])
      cla(handles.axes1,'reset');
      plot(target2(:,2),target2(:,3),'r','linewidth',1.5)
      hold on 
      plot(target2(:,2),target2(:,3),'r*','MarkerSize',12)
      hold on
      plot(target3(:,2),target3(:,3),'linewidth',1);
      hold on
      plot(target3(:,2),target3(:,3),'b*','MarkerSize',10);
      axis equal
      set(gca,'XDir','rev') 
   end
    if strcmp(get(handles.figure1,'SelectionType'),'open')
          handles.target2=target2;
          guidata(hObject,handles);
    end
 end
end
     

function figure1_WindowKeyPressFcn(hObject, eventdata, handles)


function figure1_CreateFcn(hObject, eventdata, handles)
