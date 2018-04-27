close all; clear; clc;


%%  Create and hide the UI
%
%
%

f = figure('Visible','off','Position',[0,0,1280,800]);


%%  Create figure 
%
%
%

ha = axes('Units','pixels','Position',[390,200,500,460]);



%% Preview and execute simulation
%
%
%

exX = 1000;
exY = 100;
exLen = 200;
exHeight = 50;

hsim    = uicontrol('Style','pushbutton',...
             'String','Simulate','Position',[exX,exY,exLen,exHeight],...
             'Callback',@simbutton_Callback); 

hpreview    = uicontrol('Style','pushbutton',...
             'String','Preview','Position',[exX,exY+100,exLen,exHeight],...
             'UserData',struct('plot',scatter(0,0),'envSize',[1,1]),...
             'Tag','prev_button',...
             'Callback',@previewbutton_Callback);
         



%% Simulation parameters
%
%
%

sliderX = 100;
sliderY = 600;
sliderLen = 200;

hm      = uicontrol('Style','slider',...
             'Tag', 'm_slide',...
             'SliderStep',[1/15 1/15],...
             'Position',[sliderX,sliderY,sliderLen,25],...
             'Min',5,'Max',20,'Value',5,...
             'Callback',@m_slide_Callback);
         
txtm    = uicontrol('Style','text',...
            'Position',[sliderX,sliderY-5,sliderLen,15],...
            'Tag','m_txt',...
            'String','5');
         
hn      = uicontrol('Style','slider',...
             'Tag', 'n_slide',...
             'SliderStep',[1/15 1/15],...
             'Position',[sliderX,sliderY-40,sliderLen,25],...
             'Min',5,'Max',20,'Value',5,...
             'Callback',@n_slide_Callback);

txtn    = uicontrol('Style','text',...
            'Position',[sliderX,sliderY-45,sliderLen,15],...
            'Tag','n_txt',...
            'String','5');
    
hrad    = uicontrol('Style','slider',...
             'Tag', 'radius_slide',...
             'SliderStep',[1/4 1/4],...
             'Position',[sliderX,sliderY-80,sliderLen,25],...
             'Min',2,'Max',6,'Value',2,...
             'Callback',@radius_slide_Callback);
         
txtrad  = uicontrol('Style','text',...
             'Position',[sliderX,sliderY-85,sliderLen,15],...
             'Tag','radius_txt',...
             'String','2');

         
%% Add Objects
%
%
%

arrowX = 150;
arrowY = 150;
arrowLen = 20;
arrowHgt = 20;


hAddObj    = uicontrol('Style','togglebutton',...
             'String','Add Object',...
             'Value',1,...
             'Position',[arrowX-50,arrowY+100,100,35],...
             'Callback',@addobj_button_Callback); 

hDown    = uicontrol('Style','pushbutton',...
             'String','\/',...
             'Position',[arrowX,arrowY,arrowLen,arrowHgt],...
             'Tag','down_button',...
             'Callback',@down_button_Callback); 
         
hLeft    = uicontrol('Style','pushbutton',...
             'String','<',...
             'Position',[arrowX-30,arrowY+30,arrowLen,arrowHgt],...
             'Tag','left_button',...
             'Callback',@left_button_Callback); 
         
hUp    = uicontrol('Style','pushbutton',...
             'String','^',...
             'Position',[arrowX,arrowY+60,arrowLen,arrowHgt],...
             'Tag','up_button',...
             'Callback',@up_button_Callback); 
         
hRgt    = uicontrol('Style','pushbutton',...
             'String','>',...
             'Position',[arrowX+30,arrowY+30,arrowLen,arrowHgt],...
             'Tag','rgt_button',...
             'Callback',@rgt_button_Callback); 
         
hSet    = uicontrol('Style','pushbutton',...
             'String','SET',...
             'Position',[arrowX,arrowY+30,arrowLen,arrowHgt],...
             'Tag','set_button',...
             'UserData',scatter(0,0),...
             'Callback',@set_button_Callback); 



%% Initialize the UI.
%
%
%

% Change units to normalized so components resize automatically.
f.Units = 'normalized';
ha.Units = 'normalized';
hpreview.Units = 'normalized';
hsim.Units = 'normalized';
hm.Units = 'normalized';
txtm.Units = 'normalized';
hn.Units = 'normalized';
txtn.Units = 'normalized';
hrad.Units = 'normalized';
txtrad.Units = 'normalized';

% Assign the a name to appear in the window title.
f.Name = 'Path Planning Simulation';

% Make the window visible.
f.Visible = 'on';


% simulate preview being pressed in order to generate empty field
h = findobj('Tag','prev_button');
previewbutton_Callback(h,0); 

% initialize obj marker
SetAddObjGlobal([1,1],[1,1]);
[coord, dim] = GetAddObjGlobal();
UpdateObj(coord,dim);




%% Callback functions

function simbutton_Callback(hObject,eventdata) 
    
    h = findobj('Tag','n_slide');
    n = h.Value

    h = findobj('Tag','m_slide');
    m = h.Value

    %simulate(16,16)
    disp('SIMULATE');

end

function previewbutton_Callback(hObject,eventdata) 
    

    delete(hObject.UserData.plot)

    h = findobj('Tag','n_slide');
    n = h.Value;

    h = findobj('Tag','m_slide');
    m = h.Value;
    
    E1 = CreateEnv2D(m,n);
    G = MakeGraph(E1);
    
    hObject.UserData.plot = PlotCellDecomp(E1);
    hObject.UserData.envSize = [m,n];
    
    
end
  

% slider call backs

function m_slide_Callback(hObject, eventdata)

    % round to whole number
    newval = hObject.Value;
    newval = round(newval);
    set(hObject, 'Value', newval); 

    % update text box
    h = findobj('Tag','m_txt');
	h.String = hObject.Value;
end

function n_slide_Callback(hObject, eventdata)

    % round to whole number
    newval = hObject.Value;
    newval = round(newval);
    set(hObject, 'Value', newval); 
    
    % update text box
    h = findobj('Tag','n_txt');
	h.String = hObject.Value;
end

function radius_slide_Callback(hObject, eventdata)

    % round to whole number
    newval = hObject.Value;
    newval = round(newval);
    set(hObject, 'Value', newval); 
    
    % update text box
    h = findobj('Tag','radius_txt');
	h.String = hObject.Value;
end


function addobj_button_Callback(hObject, eventdata)
    
    % find all objs
    h1 = findobj('Tag','down_button');
    h2 = findobj('Tag','left_button');
    h3 = findobj('Tag','up_button');
    h4 = findobj('Tag','rgt_button');
    h5 = findobj('Tag','set_button');

    % enable/disable based on toggle button value
	if(hObject.Value)
        set(h1,'Enable','on');
        set(h2,'Enable','on');
        set(h3,'Enable','on');
        set(h4,'Enable','on');
        set(h5,'Enable','on');
    else
        set(h1,'Enable','off');
        set(h2,'Enable','off');
        set(h3,'Enable','off');
        set(h4,'Enable','off');
        set(h5,'Enable','off');
    end
end

function down_button_Callback(hObject, eventdata)
    [coord, dim] = GetAddObjGlobal();
    
    if(coord(2)-1 >= 1)
        SetAddObjGlobal([coord(1),coord(2)-1],dim);
        [coord, dim] = GetAddObjGlobal();
        UpdateObj(coord,dim);
    end
end

function left_button_Callback(hObject, eventdata)
    [coord, dim] = GetAddObjGlobal();
    
    if(coord(1)-1 >= 1)
        SetAddObjGlobal([coord(1)-1,coord(2)],dim);
        [coord, dim] = GetAddObjGlobal();
        UpdateObj(coord,dim);
    end
end

function up_button_Callback(hObject, eventdata)
    [coord, dim] = GetAddObjGlobal();
    
    h = findobj('Tag','prev_button');
    envSize = h.UserData.envSize;
    
    % diff indices because env size is heigh by length
    if(coord(2)+1 <= envSize(1))
        SetAddObjGlobal([coord(1),coord(2)+1],dim);
        [coord, dim] = GetAddObjGlobal();
        UpdateObj(coord,dim);
    end
    
end

function rgt_button_Callback(hObject, eventdata)
    [coord, dim] = GetAddObjGlobal();
    
    h = findobj('Tag','prev_button');
    envSize = h.UserData.envSize;
    
    % diff indices because env size is heigh by length
    if(coord(1)+1 <= envSize(2))
        SetAddObjGlobal([coord(1)+1,coord(2)],dim);
        [coord, dim] = GetAddObjGlobal();
        UpdateObj(coord,dim);

    end
end

%% Helper functions

function UpdateObj(coord, dim)

    h = findobj('Tag','set_button');
    delete(h.UserData);
    
    squareCount = 0;
    for i = 1:dim(1)
        for j = 1:dim(2)
            squareCount = squareCount + 1;
            h.UserData = PlotSquare([i+coord(1)-1,j+coord(2)-1],'red',0.80);
        end
    end

end


%% global variables

function SetAddObjGlobal(coord, dim)
    global objCoord;
    global objDim;
    objCoord = coord;
    objDim = dim;
end

function [coord, dim] = GetAddObjGlobal()
    global objCoord;
    global objDim;
    coord = objCoord;
    dim = objDim;
end
