function varargout = entry(varargin)
% ENTRY MATLAB code for entry.fig
%      ENTRY, by itself, creates a new ENTRY or raises the existing
%      singleton*.
%
%      H = ENTRY returns the handle to a new ENTRY or the handle to
%      the existing singleton*.
%
%      ENTRY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENTRY.M with the given input arguments.
%
%      ENTRY('Property','Value',...) creates a new ENTRY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before entry_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to entry_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help entry

% Last Modified by GUIDE v2.5 10-Jan-2016 15:31:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @entry_OpeningFcn, ...
                   'gui_OutputFcn',  @entry_OutputFcn, ...
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


% --- Executes just before entry is made visible.
function entry_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to entry (see VARARGIN)

% Choose default command line output for entry
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load enterauth.mat;
load bluePrint.mat;
global bpw1;
global bpw2;
global bpw3;
global bpw4;
bpw1 = sampleOne;
bpw2 = sampleTwo;
bpw3 = sampleThree;
bpw4 = sampleFour;
global m2;
m2=y;

% UIWAIT makes entry wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = entry_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m2;
global bpw1;
global bpw2;
global bpw3;
global bpw4;
Auth = false;
%wr = [bpw1 bpw2 bpw3 bpw4];
set(handles.pushbutton2, 'visible', 'off');
set(handles.pushbutton1, 'visible', 'off');
set(handles.text3, 'visible', 'off');
set(handles.uipanel1, 'visible', 'off');
set(handles.uipanel2, 'visible', 'on');
m = audioplayer(m2, 48000);
playblocking(m,2);
wavarr = speak(true);
set(handles.text4, 'string', 'Wait...');
[silence, words]=WordSplicer(wavarr);
if ~(isequal(silence,5))
    word = int2str(silence-1);
    msgbox(['The Word count failed. Expecting 4 words ', word, ' words was spliced'], 'Func WordSplice exception','error','modal');
else
    set(handles.axes2,'visible','on');
    axes(handles.axes2);
     [war, wbr, wcr, wdr] = WordPuller(2,words,wavarr);
     k = 1;
     values = ones(1,4);
     while k <= 4
         if isequal(k,1);
             original = bpw1;
             testvar = war;
         elseif isequal(k,2)
             original = bpw2;
             testvar = wbr;
         elseif isequal(k,3)
             original = bpw3;
             testvar = wcr;
         elseif isequal(k,4)
             original = bpw4;
             testvar = wdr;
         end
         jix = fAlgo(original,testvar);
         nxt = k+4;
         subplot(2,4,k); plot(original);
         title('Original : 100%')
         subplot(2,4,nxt); plot(testvar);
         title(['Test : ', num2str(jix),' % match'])
         values(1,k) = jix;
         k = k+1;
     end
     if values(1,1) < 40 || values(1,2) < 40 || values(1,3) < 40 || values(1,4) < 40
         msgbox('Authorization failed. Word does not match', 'Access Credential error', 'error', 'modal');
         set(handles.pushbutton3,'string','Try Again');
     else
         msgbox('Authorization succesful', 'Access granted', 'help', 'modal');
     end
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
