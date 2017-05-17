function varargout = register(varargin)
% REGISTER MATLAB code for register.fig
%      REGISTER, by itself, creates a new REGISTER or raises the existing
%      singleton*.
%
%      H = REGISTER returns the handle to a new REGISTER or the handle to
%      the existing singleton*.
%
%      REGISTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTER.M with the given input arguments.
%
%      REGISTER('Property','Value',...) creates a new REGISTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before register_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to register_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help register

% Last Modified by GUIDE v2.5 04-Mar-2016 16:10:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @register_OpeningFcn, ...
                   'gui_OutputFcn',  @register_OutputFcn, ...
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


% --- Executes just before register is made visible.
function register_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to register (see VARARGIN)

% Choose default command line output for register
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1);
global sample1;
global sample2;
sample1 = 0;
sample2 = 0;
global recordingto;
recordingto = 1;
axes(handles.axes1);
imshow('mic2.png');
%set(handles.axes1,'visible','off');

% UIWAIT makes register wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = register_OutputFcn(hObject, eventdata, handles) 
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
datum = load('userbase.mat');
thisuser = numel(datum.f) + 1;
global sample1;
global sample2;
sna = get(handles.edit2,'string');
fna = get(handles.edit3,'string');
othern = get(handles.edit4,'string');
pin1 = get(handles.edit6,'string');
pin2 = get(handles.edit7,'string');
if (isempty(sna) || isempty(fna) || isempty(othern) || isempty(pin1) || isempty(pin2) || isequal(sample1,0) || isequal(sample2,0))
    msgbox('You cant leave the fields empty','Empty fields','error','modal');
else
    if ~strcmp(pin1,pin2) || ~isequal(length(pin1),length(pin2),4)
        msgbox('The PIN fields are not in correct format. It should be four characters long','PIN Mismatch','error','modal');
    else
        [~, word1] = WordSplicer(sample1);
        [~, word2] = WordSplicer(sample2);
         [war, wbr, wcr, wdr] = WordPuller(2,word1,sample1);
         [bpw1, bpw2, bpw3, bpw4] = WordPuller(2,word2,sample2);
         k = 1;
         values = ones(1,4);
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
             %jix = fAlgo(original,testvar);
             [a b] = vpadd(original,testvar);
%              badMatrix = xcorr(a,b,'coeff');
%              v = (numel(badMatrix) - 1)/2;
%              jix = (badMatrix(v+1))*100;
             nxt = k+4;
             subplot(2,4,k); plot(original);
             title('Original Wave')
             subplot(2,4,nxt); plot(testvar);
              title('Test wave');
             values(1,k) = 2;
             k = k+1;
         end
         value = codestack(sample1, sample2, 11025);
         if value > 100
             msgbox(['word match failed. Kindly try again! ',num2str(value) ],'error','error','modal');
         else
             accn = ['0000',num2str(thisuser)];
             %accn = num2str(accn);
             set(handles.edit5,'string',accn);
             names = [sna,' ',fna,' ',othern];
             profileCell = {names,pin1,sample1,sample2};
%              datum.f{thisuser} = profileCell;
             f = datum.f;
             f{thisuser} = profileCell;
             save('userbase.mat','f');
             msgbox(['Thank you! Your account number is: ', accn ],'Great','help','modal');
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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
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
global recordingto;
global sample1;
global sample2;
if isequal(recordingto,1) || strcmp(recordingto,'Sample 1')
    if isequal(sample1,0)
        axes(handles.axes1);
        imshow('mic.png');
        drawnow;
        sample1 = speak(true);
        [silence, words]=WordSplicer(sample1);
        if ~isequal(silence,5)
            msgbox('Four distinct words are expected, please try again','Word Count error','error','modal');
            sample1 = 0;
        else
            set(handles.text7,'ForegroundColor','black');
        end
        axes(handles.axes1);
        imshow('mic2.png');
        drawnow;
    else
        choice = questdlg('Sample 1 was previously recorded to, do you wish to overwrite this?','Confirm action','Yes','No','No');
        switch choice
            case 'Yes'
                axes(handles.axes1);
                imshow('mic.png');
                drawnow;
                sample1 = speak(true);
                [silence, words]=WordSplicer(sample1);
                if ~isequal(silence,5)
                    msgbox('Four distinct words are expected, please try again','Word Count error','error','modal');
                    sample1 = 0;
                else
                    set(handles.text7,'ForegroundColor','black');
                end
                axes(handles.axes1);
                imshow('mic2.png');
                drawnow
            case 'No'
        end
    end
else
    if isequal(sample2,0)
        axes(handles.axes1);
        imshow('mic.png');
        drawnow;
        sample2 = speak(true);
        [silence, words]=WordSplicer(sample2);
        if ~isequal(silence,5)
            msgbox('Four distinct words are expected, please try again','Word Count error','error','modal');
            sample2 = 0;
        else
            set(handles.text8,'ForegroundColor','black');
        end
        axes(handles.axes1);
        imshow('mic2.png');
        drawnow
    else
        choice = questdlg('Sample 2 was previously recorded to, do you wish to overwrite this?','Confirm action','Yes','No','No');
        switch choice
            case 'Yes'
                axes(handles.axes1);
                imshow('mic.png');
                drawnow;
                sample2 = speak(true);
                [silence, words]=WordSplicer(sample2);
                if ~isequal(silence,5)
                    msgbox('Four distinct words are expected, please try again','Word Count error','error','modal');
                    sample2 = 0;
                else
                    set(handles.text8,'ForegroundColor','black');
                end
                axes(handles.axes1);
                imshow('mic2.png');
                drawnow;
            case 'No'
        end
    end
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global recordingto;
contents = cellstr(get(hObject,'String'));
recordingto = contents{get(hObject,'Value')};


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
