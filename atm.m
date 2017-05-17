function varargout = atm(varargin)
% ATM MATLAB code for atm.fig
%      ATM, by itself, creates a new ATM or raises the existing
%      singleton*.
%
%      H = ATM returns the handle to a new ATM or the handle to
%      the existing singleton*.
%
%      ATM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATM.M with the given input arguments.
%
%      ATM('Property','Value',...) creates a new ATM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before atm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to atm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help atm

% Last Modified by GUIDE v2.5 15-Mar-2016 11:18:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @atm_OpeningFcn, ...
                   'gui_OutputFcn',  @atm_OutputFcn, ...
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


% --- Executes just before atm is made visible.
function atm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to atm (see VARARGIN)

% Choose default command line output for atm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1);
imshow('h.fw.png');
global dataf;
dataf = load('userbase.mat');
%  msgbox(dataf, 'try again','Input Error','error','modal');
set(handles.uipanel2,'visible','off');
set(handles.text4,'visible','off');
set(handles.pushbutton3,'visible','off');
set(handles.pushbutton4,'visible','off');
set(handles.pushbutton5,'visible','off');
set(handles.pushbutton6,'visible','off');
set(handles.uipanel3,'visible','off');
global accn;

% UIWAIT makes atm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = atm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataf;
global accn;
accn = get(handles.edit1,'string');
if isempty(accn) || length(accn) < 5
    msgbox('Account Number is invalid!','Input Error','error','modal');
else 
     accn = str2num(accn);
    if ~isnumeric(accn) || isempty(accn)
        msgbox('Account Number string handle is invalid! It should be all numeric','Input Error','error','modal');
    else
        if (numel(dataf.f) < accn)
            msgbox('Sorry, your account number was not found!, try again','Input Error','error','modal');
        else
            choice = questdlg('Which Authorization method would you like to choose?','Choose an authorization method','PIN','Voice','Cancel','PIN');
            switch choice
                case 'PIN'
                    set(handles.uipanel2,'visible','on');
                case 'Voice'
                    set(handles.uipanel3,'visible','on')
%                     axes(handles.axes3);
%                     imshow('mic.png');
                    drawnow;
%                     Auth = false;
                    %wr = [bpw1 bpw2 bpw3 bpw4];
%                     set(handles.pushbutton2, 'visible', 'off');
%                     set(handles.pushbutton1, 'visible', 'off');
%                     set(handles.text3, 'visible', 'off');
%                     set(handles.uipanel1, 'visible', 'off');
%                     set(handles.uipanel2, 'visible', 'on');
%                     m = audioplayer(m2, 48000);
%                     playblocking(m,2);
                case 'No thank you'
            end
        end
    end
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataf;
global accn;
passw= dataf.f{accn}{1,2};
pass = get(handles.edit2,'string');
fullname = dataf.f{1,accn}{1,1};
if strcmp(pass,passw)
    set(handles.text4,'visible','on');
    set(handles.uipanel2,'visible','off');
    set(handles.text4,'string',['Welcome, dear ',fullname]);
    set(handles.pushbutton3,'visible','on');
    set(handles.pushbutton4,'visible','on');
    set(handles.pushbutton5,'visible','on');
    set(handles.pushbutton6,'visible','on');
else
     msgbox('Sorry, password is incorrect','Input Error','error','modal');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataf;
global accn;
set(handles.text5,'string','Speak now');
drawnow;
wavarr = speak(true);
fullname = dataf.f{accn}{1,1};
userdat = dataf.f{accn}{1,4};
[~,vw] = WordSplicer(userdat);
[bpw1, bpw2, bpw3, bpw4] = WordPuller(2,vw,userdat);
% set(handles.text4, 'string', 'Wait...');
[silence, words]=WordSplicer(wavarr);
set(handles.text5,'string','Acquisition Completed, please wait...');
drawnow;
if ~(isequal(silence,5))
word = int2str(silence-1);
msgbox(['The Word count failed. Expecting 4 words ', word, ' words was spliced'], 'Func WordSplice exception','error','modal');
else
% set(handles.axes2,'visible','on');
% axes(handles.axes2);
 [war, wbr, wcr, wdr] = WordPuller(2,words,wavarr);
 k = 1;
%  values = ones(1,4);
figure;
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
%      jix = fAlgo(original,testvar);
     nxt = k+4;
     subplot(2,4,k); plot(original);
%      title('Original : 100%')
     subplot(2,4,nxt); plot(testvar);
%      title(['Test : ', num2str(jix),' % match'])
%      values(1,k) = jix;
     k = k+1;
 end
 value = codestack(wavarr, userdat, 11025)
 if value > 100
     msgbox('word match failed. Try again! ','Authorization error','error','modal');
     set(handles.text5,'string','Click to try again');
 else
     set(handles.text4,'visible','on');
    set(handles.uipanel2,'visible','off');
    set(handles.text4,'string',['Welcome, dear ',fullname]);
    set(handles.pushbutton3,'visible','on');
    set(handles.pushbutton4,'visible','on');
    set(handles.pushbutton5,'visible','on');
    set(handles.pushbutton6,'visible','on')
    set(handles.uipanel3,'visible','off');
 end
end
