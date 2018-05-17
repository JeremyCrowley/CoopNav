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

ha = axes('Units','pixels','Position',[390,200,500,500]);




%% Environment Parameters
%
%
%

panelEnvX = 100;
panelEnvY = 400;
panelEnvLen = 200;
panelEnvHgt = 300;

envP = uipanel('Title','Environment','FontSize',12,...
             'Units','pixels',...
             'Position',[panelEnvX,panelEnvY,panelEnvLen,panelEnvHgt]);

sliderLen = 150;

txtenv    = uicontrol('Style','text',...
            'Parent',envP,...
            'Position',[0,200,panelEnvLen,30],...
            'Tag','env_txt',...
            'String','Create an m by n cell decomposed environment');
        
txtenvdim = uicontrol('Style','text',...
            'Parent',envP,...
            'Position',[0,160,panelEnvLen,30],...
            'Tag','envdim_txt',...
            'String','Current size: 5x5');

hm      = uicontrol('Style','slider',...
             'Parent',envP,...
             'Tag', 'm_slide',...
             'SliderStep',[1/15 1/15],...
             'Position',[25,140,sliderLen,25],...
             'Min',5,'Max',20,'Value',5,...
             'Callback',@m_slide_Callback);
         
txtm    = uicontrol('Style','text',...
            'Parent',envP,...
            'Position',[0,130,panelEnvLen,15],...
            'Tag','m_txt',...
            'String','m = 5');
         
hn      = uicontrol('Style','slider',...
             'Parent',envP,...
             'Tag', 'n_slide',...
             'SliderStep',[1/15 1/15],...
             'Position',[25,90,sliderLen,25],...
             'Min',5,'Max',20,'Value',5,...
             'Callback',@n_slide_Callback);

txtn    = uicontrol('Style','text',...
            'Parent',envP,...
            'Position',[0,80,panelEnvLen,15],...
            'Tag','n_txt',...
            'String','n = 5');
        
hupdatefield    = uicontrol('Style','pushbutton',...
                 'Parent',envP,...
                 'String','New Field','Position',[25,10,150,50],...
                 'UserData',struct('plot',scatter(0,0),'envSize',[1,1],'env',0,'graph',digraph),...
                 'Tag','updatefield_button',...
                 'Callback',@updatefieldbutton_Callback);

         
%% Add Objects
%
%
%

panelObjX = 100;
panelObjY = 100;
panelObjLen = 200;
panelObjHgt = 300;

objP = uipanel('Title','Add Objects','FontSize',12,...
             'Units','pixels',...
             'Position',[panelObjX,panelObjY,panelObjLen,panelObjHgt]);


arrowLen = 30;
arrowHgt = 30;


hAddObj    = uicontrol('Style','togglebutton',...
             'Parent',objP,...
             'String','Add Object',...
             'Value',1,...
             'Position',[panelObjLen/2-50,200,100,35],...
             'UserData',scatter(0,0),...
             'Tag','addobj_button',...
             'Callback',@addobj_button_Callback); 

hDown    = uicontrol('Style','pushbutton',...
             'Parent',objP,...
             'String','\/',...
             'Position',[panelObjLen/2-arrowLen/2,2*arrowHgt,arrowLen,arrowHgt],...
             'Tag','down_button',...
             'Callback',@down_button_Callback); 
         
hLeft    = uicontrol('Style','pushbutton',...
             'Parent',objP,...
             'String','<',...
             'Position',[panelObjLen/2-1.5*arrowLen,3*arrowHgt,arrowLen,arrowHgt],...
             'Tag','left_button',...
             'Callback',@left_button_Callback); 
         
hUp    = uicontrol('Style','pushbutton',...
             'Parent',objP,...
             'String','^',...
             'Position',[panelObjLen/2-arrowLen/2,4*arrowLen,arrowLen,arrowHgt],...
             'Tag','up_button',...
             'Callback',@up_button_Callback); 
         
hRgt    = uicontrol('Style','pushbutton',...
             'Parent',objP,...
             'String','>',...
             'Position',[panelObjLen/2+arrowLen/2,3*arrowHgt,arrowLen,arrowHgt],...
             'Tag','rgt_button',...
             'Callback',@rgt_button_Callback); 
         
hSet    = uicontrol('Style','pushbutton',...
             'Parent',objP,...
             'String','SET',...
             'Position',[panelObjLen/2-arrowLen/2,3*arrowHgt,arrowLen,arrowHgt],...
             'Tag','set_button',...
             'UserData',scatter(0,0),...
             'Callback',@set_button_Callback); 
         
hVert   = uicontrol('Style','slider',...
             'Parent',objP,...
             'Tag', 'vert_slide',...
             'SliderStep',[1/5 1/5],...
             'Position',[10,45,25,100],...
             'Min',1,'Max',5,'Value',1,...
             'Callback',@vert_slide_Callback);
         
txtVert  = uicontrol('Style','text',...
             'Parent',objP,...
             'Position',[5,85,10,20],...
             'Tag','vert_txt',...
             'String','1');
         
hHor    = uicontrol('Style','slider',...
             'Parent',objP,...
             'Tag', 'hor_slide',...
             'SliderStep',[1/5 1/5],...
             'Position',[35,20,100,25],...
             'Min',1,'Max',5,'Value',1,...
             'Callback',@hor_slide_Callback);
             
txtHor  = uicontrol('Style','text',...
             'Parent',objP,...
             'Position',[80,10,10,20],...
             'Tag','hor_txt',...
             'String','1');


%% Add Agent
%
%
%

panelAgentX = 980;
panelAgentY = 500;
panelAgentLen = 200;
panelAgentHgt = 200;

agentP = uipanel('Title','Add Agent','FontSize',12,...
             'Units','pixels',...
             'Position',[panelAgentX,panelAgentY,panelAgentLen,panelAgentHgt]);

hagentpos = uicontrol('Style','edit',...
             'Parent',agentP,...
             'Position',[75,140,50,25],... 
             'UserData',struct('x',1,'y',1),...
             'CallBack',@agentpos_edit_Callback,...
             'Tag','agentpos_edit',...
             'String','(1,1)');
         
txtagent = uicontrol('Style','text',...
             'Parent',agentP,...
             'Position',[0,120,panelAgentLen,20],...
             'Tag','agent_txt',...
             'String','Agent Coordinates');
         
htargetpos = uicontrol('Style','edit',...
             'Parent',agentP,...
             'Position',[75,90,50,25],... 
             'UserData',struct('x',1,'y',1),...
             'CallBack',@targetpos_edit_Callback,...
             'Tag','targetpos_edit',...
             'String','(1,1)');
         
txttarget  = uicontrol('Style','text',...
             'Parent',agentP,...
             'Position',[0,70,panelAgentLen,20],...
             'Tag','target_txt',...
             'String','Target Coordinates');
         
         
hrad    = uicontrol('Style','slider',...
             'Parent',agentP,...
             'Tag', 'radius_slide',...
             'SliderStep',[1/4 1/4],...
             'Position',[25,30,150,25],...
             'Min',2,'Max',6,'Value',2,...
             'Callback',@radius_slide_Callback);
         
txtrad  = uicontrol('Style','text',...
             'Parent',agentP,...
             'Position',[0,10,panelAgentLen,20],...
             'Tag','radius_txt',...
             'String','2');

%% Save Sim
%
%
%

panelSaveX = 980;
panelSaveY = 270;
panelSaveLen = 200;
panelSaveHgt = 160;

saveP = uipanel('Title','Save Environment','FontSize',12,...
                'Units','pixels',...
                'Position',[panelSaveX,panelSaveY,panelSaveLen,panelSaveHgt]);
         
hsave    = uicontrol('Style','pushbutton',...
             'Parent',saveP,...
             'String','Save Environment',...
             'Position',[25,25,150,50],...
             'Tag','poi_toggle'); 
         
         
         
%% Preview and Execute Simulation
%
%
%

panelSimX = 980;
panelSimY = 100;
panelSimLen = 200;
panelSimHgt = 200;

envS = uipanel('Title','Simulation','FontSize',12,...
             'Units','pixels',...
             'Position',[panelSimX,panelSimY,panelSimLen,panelSimHgt]);

exLen = 150;
exHeight = 50;

hsim    = uicontrol('Style','pushbutton',...
             'Parent',envS,...
             'String','Simulate',...
             'Position',[25,25,exLen,exHeight],...
             'UserData',struct('discovered',plot(0,0,'Visible','off'),'POI',plot(0,0,'Visible','off'),'agent',plot(0,0,'Visible','off'),'cell',plot(0,0,'Visible','off'),'path',plot(0,0,'Visible','off')),...
             'Callback',@simbutton_Callback,...
             'Tag','sim_button'); 
         
hpoi    = uicontrol('Style','togglebutton',...
             'Parent',envS,...
             'String','Show Points of Interest',...
             'Value',1,...
             'Position',[25,125,exLen,exHeight],...
             'Tag','poi_toggle'); 

         
         
         
%% Initialize the UI.
%
%
%

% Change units to normalized so components resize automatically.
f.Units = 'normalized';
ha.Units = 'normalized';
hupdatefield.Units = 'normalized';
envP.Units = 'normalized';
hm.Units = 'normalized';
txtm.Units = 'normalized';
hn.Units = 'normalized';
txtn.Units = 'normalized';
hrad.Units = 'normalized';
txtrad.Units = 'normalized';
objP.Units = 'normalized';
hAddObj.Units = 'normalized';
hDown.Units = 'normalized';
hLeft.Units = 'normalized';
hUp.Units = 'normalized';
hRgt.Units = 'normalized';
hSet.Units = 'normalized';
hVert.Units = 'normalized';
txtVert.Units = 'normalized';
hHor.Units = 'normalized';
txtHor.Units = 'normalized';
agentP.Units = 'normalized';
hagentpos.Units = 'normalized';
txtagent.Units = 'normalized';
htargetpos.Units = 'normalized';
txttarget.Units = 'normalized';
hrad.Units = 'normalized';
txtrad.Units = 'normalized';
envS.Units = 'normalized';
hsim.Units = 'normalized';

% Assign the a name to appear in the window title.
f.Name = 'Path Planning Simulation';

% Make the window visible.
f.Visible = 'on';


% simulate preview being pressed in order to generate empty field
h = findobj('Tag','updatefield_button');
updatefieldbutton_Callback(h,0); 

% initialize obj marker
SetAddObjGlobal([1,1],[1,1]);
[coord, dim] = GetAddObjGlobal();
UpdateObj(coord,dim);




%% Callback Functions
%
%
%

%% Simulate/Preview Callbacks
%
%
%

function simbutton_Callback(hObject,eventdata) 
    
    h = findobj('Tag','updatefield_button');
    environment = h.UserData.env;
    envGraph = h.UserData.graph;
    
    hagent = findobj('Tag','agentpos_edit');
    agentPos = zeros(1,2);
    agentPos(1) = hagent.UserData.x;
    agentPos(2) = hagent.UserData.y;
    
    htarg = findobj('Tag','targetpos_edit');
    targetPos = zeros(1,2);
    targetPos(1) = htarg.UserData.x;
    targetPos(2) = htarg.UserData.y;
    
    hrad = findobj('Tag','radius_slide');
    radOfView = hrad.Value;
    
    
    delete(hObject.UserData.discovered);
    delete(hObject.UserData.POI);
    delete(hObject.UserData.agent);
    delete(hObject.UserData.cell);
    delete(hObject.UserData.path);
    
    
    hpoi = findobj('Tag','poi_toggle');
    dispPOI = hpoi.Value;
    
    
    [iterations,pDiscovered,pPOI,pAgent,pCell,pPath] = simulate(environment,envGraph,agentPos,targetPos,radOfView,dispPOI);
    
    
    hObject.UserData.discovered = pDiscovered;
    hObject.UserData.POI = pPOI;
    hObject.UserData.agent = pAgent;
    hObject.UserData.cell = pCell;
    hObject.UserData.path = pPath;
    
    fprintf('Simulation Complete - %d iterations',iterations);

end

function updatefieldbutton_Callback(hObject,eventdata) 
    
    delete(hObject.UserData.plot)

    h = findobj('Tag','n_slide');
    n = h.Value;

    h = findobj('Tag','m_slide');
    m = h.Value;
    
    h = findobj('Tag','vert_slide');
    h.Max = m;
    h.SliderStep = [1/m 1/m];
    
    h = findobj('Tag','hor_slide');
    h.Max = n;
    h.SliderStep = [1/m 1/m];
    
    h = findobj('Tag','envdim_txt');
    str = sprintf('Current Dimensions: %d x %d',m,n);
    set(h, 'String', str); 
    
    h = findobj('Tag','sim_button');
    delete(h.UserData.discovered);
    delete(h.UserData.POI);
    delete(h.UserData.agent);
    delete(h.UserData.cell);
    delete(h.UserData.path);
    
    
    E1 = CreateEnv2D(m,n);
    G = MakeGraph(E1);
    
    hObject.UserData.plot = PlotCellDecomp(E1);
    hObject.UserData.envSize = [m,n];
    hObject.UserData.env = E1;
    hObject.UserData.graph = G;
    
    
end
  


%% Field Size Callbacks
%
%
%

function m_slide_Callback(hObject, eventdata)

    % round to whole number
    newval = hObject.Value;
    newval = round(newval);
    set(hObject, 'Value', newval); 

    % update text box
    h = findobj('Tag','m_txt');
	str = sprintf('m = %d',hObject.Value);
	h.String = str;
end

function n_slide_Callback(hObject, eventdata)

    % round to whole number
    newval = hObject.Value;
    newval = round(newval);
    set(hObject, 'Value', newval); 
    
    % update text box
    h = findobj('Tag','n_txt');
    str = sprintf('n = %d',hObject.Value);
	h.String = str;
    
end

%% Agent Callbacks
%
%
%

function agentpos_edit_Callback(hObject, eventdata)
    str = get(hObject,'string');
    
    in1 = strfind(str,'(');
    in2 = strfind(str,',');
    in3 = strfind(str,')');
    
    if(length(in1) ~= 1 || length(in2) ~= 1  || length(in3) ~= 1)
        warning('USER ERROR: Incorrect input format for agent coordinates')
    end
    
    aX = str(in1+1:in2-1);
    aY = str(in2+1:in3-1);
    
    hObject.UserData.x = str2double(aX);
    hObject.UserData.y = str2double(aY);
    
end

function targetpos_edit_Callback(hObject, eventdata)
    str = get(hObject,'string');
    
    in1 = strfind(str,'(');
    in2 = strfind(str,',');
    in3 = strfind(str,')');
    
    if(length(in1) ~= 1 || length(in2) ~= 1  || length(in3) ~= 1)
        warning('USER ERROR: Incorrect input format for target coordinates')
    end
    
    aX = str(in1+1:in2-1);
    aY = str(in2+1:in3-1);
    
    hObject.UserData.x = str2double(aX);
    hObject.UserData.y = str2double(aY);

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

%% Set Object Callbacks

function vert_slide_Callback(hObject, eventdata)

    % round to whole number
    newval = hObject.Value;
    newval = round(newval);
    
    % get env size
    h = findobj('Tag','updatefield_button');
    envSize = h.UserData.envSize;
    
    [coord, dim] = GetAddObjGlobal();
    
    % ensure dimensionality cannot be increased past env limits
    if(coord(2)+newval <= envSize(1)+1)
        dim(2) = newval;
        SetAddObjGlobal(coord, dim);
    else
        newval = envSize(1)-coord(2)+1;
    end
    
    set(hObject, 'Value', newval); 
    
    % update text box
    h = findobj('Tag','vert_txt');
	h.String = hObject.Value;
    
    % update obj visualization
    UpdateObj(coord,dim);
    
end

function hor_slide_Callback(hObject, eventdata)

    % round to whole number
    newval = hObject.Value;
    newval = round(newval);
    
    % get env size
    h = findobj('Tag','updatefield_button');
    envSize = h.UserData.envSize;
    
    [coord, dim] = GetAddObjGlobal();
    
    % ensure dimensionality cannot be increased past env limits
    if(coord(1)+newval <= envSize(2)+1)
        dim(1) = newval;
        SetAddObjGlobal(coord, dim);
    else
        newval = envSize(2)-coord(1)+1;
    end
    
    set(hObject, 'Value', newval); 
    
    % update text box
    h = findobj('Tag','hor_txt');
	h.String = hObject.Value;
    
    % update obj visualization
    UpdateObj(coord,dim);
    
end


function addobj_button_Callback(hObject, eventdata)
    
    % find all objs
    h1 = findobj('Tag','down_button');
    h2 = findobj('Tag','left_button');
    h3 = findobj('Tag','up_button');
    h4 = findobj('Tag','rgt_button');
    h5 = findobj('Tag','set_button');
    h6 = findobj('Tag','vert_slide');
    h7 = findobj('Tag','hor_slide');
    
    

    % enable/disable based on toggle button value
	if(hObject.Value)
        set(h1,'Enable','on');
        set(h2,'Enable','on');
        set(h3,'Enable','on');
        set(h4,'Enable','on');
        set(h5,'Enable','on');
        set(h6,'Enable','on');
        set(h7,'Enable','on');
        
        % reset sliders for size
        h = findobj('Tag','vert_slide');
        set(h, 'Value', 1); 
        h = findobj('Tag','vert_txt');
        h.String = '1';
        h = findobj('Tag','hor_slide');
        set(h, 'Value', 1);
        h = findobj('Tag','hor_txt');
        h.String = '1';
        
        % reset location and dim of object being added
        SetAddObjGlobal([1,1],[1,1]);
        [coord, dim] = GetAddObjGlobal();
        UpdateObj(coord,dim);
    else
        set(h1,'Enable','off');
        set(h2,'Enable','off');
        set(h3,'Enable','off');
        set(h4,'Enable','off');
        set(h5,'Enable','off');
        set(h6,'Enable','off');
        set(h7,'Enable','off');
        DeleteObj()
    end
    
    
end

function down_button_Callback(hObject, eventdata)
    [coord, dim] = GetAddObjGlobal();
    
    % check that moving downwards is within env limits
    if(coord(2)-1 >= 1)
        SetAddObjGlobal([coord(1),coord(2)-1],dim);
        [coord, dim] = GetAddObjGlobal();
        UpdateObj(coord,dim);
    end
end

function left_button_Callback(hObject, eventdata)
    [coord, dim] = GetAddObjGlobal();
    
    % check that moving left is within env limits
    if(coord(1)-1 >= 1)
        SetAddObjGlobal([coord(1)-1,coord(2)],dim);
        [coord, dim] = GetAddObjGlobal();
        UpdateObj(coord,dim);
    end
end

function up_button_Callback(hObject, eventdata)
    [coord, dim] = GetAddObjGlobal();
    
    h = findobj('Tag','updatefield_button');
    envSize = h.UserData.envSize;
    
    % check that moving up is within env limits
    % diff indices because env size is height by length
    if(coord(2)+1 <= envSize(1) && coord(2)+dim(2) <= envSize(1))
        SetAddObjGlobal([coord(1),coord(2)+1],dim);
        [coord, dim] = GetAddObjGlobal();
        UpdateObj(coord,dim);
    end
    
end

function rgt_button_Callback(hObject, eventdata)
    [coord, dim] = GetAddObjGlobal();
    
    h = findobj('Tag','updatefield_button');
    envSize = h.UserData.envSize;
    
    % check that moving right is within env limits
    % diff indices because env size is height by length
    if(coord(1)+1 <= envSize(2) && coord(1)+dim(1) <= envSize(2))
        SetAddObjGlobal([coord(1)+1,coord(2)],dim);
        [coord, dim] = GetAddObjGlobal();
        UpdateObj(coord,dim);

    end
end

function set_button_Callback(hObject, eventdata)

    % remove old env
    h = findobj('Tag','updatefield_button');
    delete(h.UserData.plot)
    
    % get current obj data
    [coord, dim] = GetAddObjGlobal();
    
    % update env
    h.UserData.env = AddSquare2D(h.UserData.env,coord,dim(1),dim(2));
    h.UserData.graph = MakeGraph(h.UserData.env);
    h.UserData.plot = PlotCellDecomp(h.UserData.env);

end

%% Helper functions
%
%
%

function UpdateObj(coord, dim)
    h = findobj('Tag','addobj_button');
    DeleteObj(h);
    % replot objs on field
    
    squareCount = 0;
    for i = 1:dim(1)
        for j = 1:dim(2)
            squareCount = squareCount + 1;
            h.UserData(squareCount) = PlotSquare([i+coord(1)-1,j+coord(2)-1],'red',0.80);
        end
    end

end

function DeleteObj(hObject)
    hObject = findobj('Tag','addobj_button');
    
    [mUser, nUser] = size(hObject.UserData);
    
    % delete all objs on field
    for i = 1:nUser
        delete(hObject.UserData(i));
    end
end


%% global variables
%
%
%

% object cursor

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



