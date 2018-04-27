close all; clear; clc;


%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[0,0,1280,800]);

ha = axes('Units','pixels','Position',[50,60,500,460]);

% Construct the components.

exX = 600;
exY = 100;
exLen = 200;
exHeight = 50;

hpreview    = uicontrol('Style','pushbutton',...
             'String','Preview','Position',[exX,exY,exLen,exHeight],...
             'UserData',struct('cell',scatter(0,0),'obj',0),...
             'Callback',@previewbutton_Callback);
         
hsim    = uicontrol('Style','pushbutton',...
             'String','Simulate','Position',[exX+300,exY,exLen,exHeight],...
             'Callback',@simbutton_Callback); 
         
         
         
sliderX = 600;
sliderY = 600;
sliderLen = 200;
         
% Construct the components.
hm    = uicontrol('Style','slider',...
             'Tag', 'm_slide',...
             'SliderStep',[1/15 1/15],...
             'Position',[sliderX,sliderY,sliderLen,25],...
             'Min',5,'Max',20,'Value',5,...
             'Callback',@m_slide_Callback);
         
txtm = uicontrol('Style','text',...
        'Position',[sliderX,sliderY-5,sliderLen,15],...
        'Tag','m_txt',...
        'String','5');
         
hn    = uicontrol('Style','slider',...
             'Tag', 'n_slide',...
             'SliderStep',[1/15 1/15],...
             'Position',[sliderX,sliderY-40,sliderLen,25],...
             'Min',5,'Max',20,'Value',5,...
             'Callback',@n_slide_Callback);

txtn = uicontrol('Style','text',...
        'Position',[sliderX,sliderY-45,sliderLen,15],...
        'Tag','n_txt',...
        'String','5');
    
    
hradius    = uicontrol('Style','slider',...
             'Tag', 'radius_slide',...
             'SliderStep',[1/4 1/4],...
             'Position',[sliderX,sliderY-80,sliderLen,25],...
             'Min',2,'Max',6,'Value',2,...
             'Callback',@radius_slide_Callback);
         
txtradius = uicontrol('Style','text',...
        'Position',[sliderX,sliderY-85,sliderLen,15],...
        'Tag','radius_txt',...
        'String','2');
         



% Initialize the UI.
% Change units to normalized so components resize automatically.
f.Units = 'normalized';
ha.Units = 'normalized';
hpreview.Units = 'normalized';
hsim.Units = 'normalized';
hm.Units = 'normalized';
txtm.Units = 'normalized';
hn.Units = 'normalized';
txtn.Units = 'normalized';
hradius.Units = 'normalized';
txtradius.Units = 'normalized';





% Assign the a name to appear in the window title.
f.Name = 'Path Planning Simulation';

% Make the window visible.
f.Visible = 'on';



function simbutton_Callback(hObject,eventdata) 
    

    h = findobj('Tag','n_slide');
    n = h.Value

    h = findobj('Tag','m_slide');
    m = h.Value

    %simulate(16,16)
    disp('SIMULATE');

end

function previewbutton_Callback(hObject,eventdata) 
    
    hold on
    
    delete(hObject.UserData.cell)

    

    h = findobj('Tag','n_slide');
    n = h.Value

    h = findobj('Tag','m_slide');
    m = h.Value
    
    E1 = CreateEnv2D(m,n);
    G = MakeGraph(E1);
    
    
    
    hObject.UserData.cell = PlotCellDecomp(E1);
end
  
  
function m_slide_Callback(hObject, eventdata)
    h = findobj('Tag','m_txt');
	h.String = hObject.Value;
end

function n_slide_Callback(hObject, eventdata)
    h = findobj('Tag','n_txt');
	h.String = hObject.Value;
end


function radius_slide_Callback(hObject, eventdata)
    h = findobj('Tag','radius_txt');
	h.String = hObject.Value;
end

