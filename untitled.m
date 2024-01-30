function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 07-Jul-2022 18:17:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in addPhoto.
function addPhoto_Callback(hObject, eventdata, handles)
% hObject    handle to addPhoto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=imread('flower.jpg')
axes(handles.axes1);
imshow(a);
title('Orginal Image');


% --- Executes on button press in imgNegative.
function imgNegative_Callback(hObject, eventdata, handles)
% hObject    handle to imgNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% reading the RGB file into the Matlab environment
sKi = imread('flower.jpg');
subplot(1, 2, 1),

% displaying the RGB image
imshow(sKi);
title("Original image");

% levels of the 8-bit image
L = 2 ^ 8;  

% finding the negative        
neg = (L - 1) - sKi;
subplot(1, 2, 2),

% displaying the negative image

imshow(neg);
title("Negative Image")


% --- Executes on button press in grayscale.
function grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
low = 100;
high = 150;
new_Intensity = 200;
I = imread('flower.jpg');
I_Gray = rgb2gray(I);
[row, col]=size(I_Gray);
I_GLS_Preserve = uint8(zeros(row, col));
for x=1:row
 for y=1:col
 if I_Gray(x,y)<=high && I_Gray(x,y)>=low
 I_GLS_Preserve(x,y) = new_Intensity;
 else
 I_GLS_Preserve(x,y) = I_Gray(x,y);
 end
 end
end
subplot(1,2,1), imshow(I_Gray), title('Grayscale Image');
subplot(1,2,2), imshow(I_GLS_Preserve), title('Gray Level Sliced Image');



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc; clear;

A=imread('flower.jpg');
[row,col]=size(A);
subplot(3,3,1), imshow(A), title('Original Image');
C=zeros(row,col,8);
for k=1:8
    for i=1:row
        for j=1:col
            C(i,j,k)=bitget(A(i,j),k);        %Bit slicing
        end
    end
    subplot(3,3,k+1), imshow(C(:,:,k)), title(['Bit Plane ',num2str(k-1)]);
end


% --- Executes on button press in avg.
function avg_Callback(hObject, eventdata, handles)
% hObject    handle to avg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgbImage = imread('flower.jpg');
windowWidth = 21;
kernel = ones(windowWidth) / windowWidth .^ 2;
subplot(2, 1, 1);
imshow(rgbImage);
drawnow;
blurryImage = imfilter(rgbImage, kernel, 'replicate');
subplot(2, 1, 2);
imshow(blurryImage);


% --- Executes on button press in min.
function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Original=imread('flower.jpg');         %Read in image
BW = im2bw(Original,0.6);           %Convert into black and white image

minf=@(x) min(x(:));                %set 'min()' filter                
min_Image=nlfilter(BW,[3 3],minf);  %Apply over 3 x 3 neighbourhood

subplot(2,2,2), imshow(min_Image), title('Min'); %Display min image


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A = imread('flower.jpg');
A = rgb2gray(A(1:300,1:300,:));
figure,imshow(A),title('ORIGINAL IMAGE');
B=zeros(size(A));

%PAD THE MATRIX A WITH ZEROS
modifyA=padarray(A,[1 1]);

        x=[1:3]';
        y=[1:3]';
       
for i= 1:size(modifyA,1)-2
    for j=1:size(modifyA,2)-2
      
       window=reshape(modifyA(i+x-1,j+y-1),[],1);

        
       B(i,j)=max(window);
   
    end
end
B=uint8(B);
figure,imshow(B),title('IMAGE AFTER MAX FILTERING');


 


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in openi.
function openi_Callback(hObject, eventdata, handles)
% hObject    handle to openi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I_Gray=imread('flower.jpg');
SE1 = strel('square', 30);
I_Open1 = imopen(I_Gray,SE1);
I_Open2 = imdilate((imerode(I_Gray, SE1)),SE1);
subplot(1,3,1), imshow(I_Gray), title('Grayscale Image');
subplot(1,3,2), imshow(I_Open1), title('Open() function - Square 30');
subplot(1,3,3), imshow(I_Open2), title('Manual Open - Square 30');


% --- Executes on button press in closing.
function closing_Callback(hObject, eventdata, handles)
% hObject    handle to closing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I_Gray=imread('flower.jpg');
SE1 = strel('square', 30);
I_Close1 = imclose(I_Gray,SE1);
I_Close2 = imerode((imdilate(I_Gray, SE1)),SE1);
subplot(1,3,1), imshow(I_Gray), title('Grayscale Image');
subplot(1,3,2), imshow(I_Close1), title('Close() function - Square 30');
subplot(1,3,3), imshow(I_Close2), title('Manual Close - Square 30');


% --- Executes on button press in histogram.
function histogram_Callback(hObject, eventdata, handles)
% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


I = imread('flower.jpg');
I_Gray = rgb2gray(I);
subplot(1,2,2),
axes(handles.axes4);
imhist(I_Gray), title('Histogram');
