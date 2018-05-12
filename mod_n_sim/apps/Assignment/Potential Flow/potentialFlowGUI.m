function varargout = potentialFlowGUI(varargin)
    % Initialization code
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
        'gui_Singleton',  gui_Singleton, ...
        'gui_OpeningFcn', @potentialFlowGUI_OpeningFcn, ...
        'gui_OutputFcn',  @potentialFlowGUI_OutputFcn, ...
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
% End initialization code


% --- Executes just before potentialFlowGUI is made visible.
function potentialFlowGUI_OpeningFcn(hObject, eventdata, handles, varargin)
    % Initialize the GUI layout
    set(handles.start,'ToolTipString','Add a potential: Pick a location WITHIN the axes');
    handles.data.xlim = [-2 2];
    handles.data.ylim = [-2 2];
    set(handles.axes_flow,'Xlim',handles.data.xlim,'Ylim',handles.data.ylim,...
        'DataAspectRatio',[1 1 1]);
    xlabel(handles.axes_flow,'X');ylabel(handles.axes_flow,'Y');
    ngrid = 21;
    xrange = linspace(handles.data.xlim(1),handles.data.xlim(2),ngrid);
    yrange = linspace(handles.data.ylim(1),handles.data.ylim(2),ngrid);
    [handles.data.x, handles.data.y] = meshgrid(xrange,yrange);
    handles.data.v_x = str2double(get(handles.v_x,'String'));
    handles.data.v_y = str2double(get(handles.v_y,'String'));
    handles.data.u = handles.data.v_x.*ones(ngrid,ngrid);
    handles.data.v = handles.data.v_y.*ones(ngrid,ngrid);
    handles.data.psi = handles.data.u.*handles.data.y + handles.data.v.*handles.data.x;
    handles.data.phi = -handles.data.u.*handles.data.x - handles.data.v.*handles.data.y;
    % Create the help button on toolbar
    [X, map] = imread(fullfile(...
        matlabroot,'toolbox','matlab','icons','csh_icon.gif'));
    icon = ind2rgb(X,map);
    uipushtool(handles.uitoolbar1,'CData',icon,...
        'TooltipString','Help',...
        'ClickedCallback',@AppHelp);

    % Choose default command line output for potentialFlowGUI
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = potentialFlowGUI_OutputFcn(hObject, eventdata, handles)
    % Get default command line output from handles structure
    varargout{1} = handles.output;


function [x,y,u,v,psi,phi] = potentialFlow(handles)
    % Create potential flow based on user input

    % Read in x,y and previous u,v,psi,phi values 
    x = handles.data.x;
    y = handles.data.y;
    u = handles.data.u;
    v = handles.data.v;
    psi = handles.data.psi;
    phi = handles.data.phi;
    % Check if the Add Potential Flow button is pressed
    proceed = get(handles.start,'Value');
    % If pressed, wait for user to pick a location, 
    % then prompt user to input type of flow and its strength,
    % then linearly add the potential flows to reflect the superposition. 
    while proceed == 1
        [x_c,y_c,click] = ginput(1);
        if click == 1
            prompt = {'Enter the {\bftype} of elementary plane flow (source,sink,vortex,or doublet):';...
                'Enter the {\bfstrength} of the flow:'};
            name = 'Enter elementary plane flow parameters';
            numlines = 1;
            defaultanswer = {'source','1'}; % provide default answers
            options.Resize = 'on';
            options.WindowSylte = 'normal';
            options.Interpreter = 'tex'; 
            answer = inputdlg(prompt,name,numlines,defaultanswer,options);
            if ~isempty(answer)
                type = answer{1};
                q = str2num(answer{2});
                [addu,addv,addpsi,addphi] = addPotential(x,y,x_c,y_c,q,type);
                u = u + addu;
                v = v + addv;
                psi = psi + addpsi;
                phi = phi + addphi;
                updatePlot(handles,x,y,u,v,psi,phi);
            end
        else
            break;
        end
    end




function updatePlot(handles,x,y,u,v,psi,phi)
    % Update the plot based on new superpositioned potential flows
    cla(handles.axes_flow);
    set(handles.axes_flow,'Xlim',1.1*handles.data.xlim,...
        'Ylim',1.1*handles.data.ylim,...
        'DataAspectRatio',[1 1 1],...
        'NextPlot','replacechildren');
    u_s = u./sqrt(u.^2+v.^2);
    v_s = v./sqrt(u.^2+v.^2);
    % Check whether to show vector plots
    if get(handles.showvector,'Value')
        h.v = quiver(handles.axes_flow,x,y,u_s,v_s);
        set(h.v,'AutoScaleFactor',0.5,'Color','k');
    end
    hold on
    % Check whether to show velocity potential
    if get(handles.showpotential,'Value')
        [~,h.c] = contour(handles.axes_flow,x,y,phi,20);
        colormap(handles.axes_flow,'Autumn');
        colorbar('peer',handles.axes_flow);
    else
        colorbar('off');
    end
    hold off
    % Check whether to show streamlines
    [strx, stry] = meshgrid(-2:0.4:2,-2:0.4:2); % where to draw the streamlines
    if get(handles.showstreamline,'Value')
        h.str = streamline(handles.axes_flow,x,y,u,v,strx,stry);
        set(h.str,'Color','b');
    end

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
    [x,y,u,v,psi,phi]= potentialFlow(handles);
    handles.data.x = x;
    handles.data.y = y;
    handles.data.u = u;
    handles.data.v = v;
    handles.data.psi = psi;
    handles.data.phi = phi;

    guidata(hObject, handles);


function v_x_Callback(hObject, eventdata, handles)
    v_x = str2double(get(handles.v_x,'String'));
    v_y = str2double(get(handles.v_y,'String'));
    v_x0 = handles.data.v_x;
    v_y0 = handles.data.v_y;
    x = handles.data.x;
    y = handles.data.y;
    u = handles.data.u + (v_x-v_x0)*ones(size(handles.data.u,1),size(handles.data.u,2));
    v = handles.data.v + (v_y-v_y0)*ones(size(handles.data.u,1),size(handles.data.u,2));
    psi = u.*y + v.*x;
    phi = -u.*x - v.*y;
    updatePlot(handles,x,y,u,v,psi,phi);
    handles.data.x = x;
    handles.data.y = y;
    handles.data.u = u;
    handles.data.v = v;
    handles.data.psi = psi;
    handles.data.phi = phi;
    handles.data.v_x = v_x;
    handles.data.v_y = v_y;
    guidata(hObject, handles);


function v_y_Callback(hObject, eventdata, handles)
    v_x = str2double(get(handles.v_x,'String'));
    v_y = str2double(get(handles.v_y,'String'));
    v_x0 = handles.data.v_x;
    v_y0 = handles.data.v_y;
    x = handles.data.x;
    y = handles.data.y;
    u = handles.data.u + (v_x-v_x0)*ones(size(handles.data.u,1),size(handles.data.u,2));
    v = handles.data.v + (v_y-v_y0)*ones(size(handles.data.u,1),size(handles.data.u,2));
    psi = u.*y + v.*x;
    phi = -u.*x - v.*y;
    updatePlot(handles,x,y,u,v,psi,phi);
    handles.data.x = x;
    handles.data.y = y;
    handles.data.u = u;
    handles.data.v = v;
    handles.data.psi = psi;
    handles.data.phi = phi;
    handles.data.v_x = v_x;
    handles.data.v_y = v_y;
    guidata(hObject, handles);


% --- Executes on button press in showstreamline.
function showstreamline_Callback(hObject, eventdata, handles)
    updatePlot(handles,handles.data.x,handles.data.y,handles.data.u,handles.data.v,...
        handles.data.psi,handles.data.phi);


% --- Executes on button press in showvector.
function showvector_Callback(hObject, eventdata, handles)
    updatePlot(handles,handles.data.x,handles.data.y,handles.data.u,handles.data.v,...
        handles.data.psi,handles.data.phi);


% --- Executes on button press in showpotential.
function showpotential_Callback(hObject, eventdata, handles)
    updatePlot(handles,handles.data.x,handles.data.y,handles.data.u,handles.data.v,...
        handles.data.psi,handles.data.phi);


% --- Executes on button press in clearplot.
function clearplot_Callback(hObject, eventdata, handles)
    % Clear the plot AND the previous u,v,psi,phi data
    handles.data.v_x = str2double(get(handles.v_x,'String'));
    handles.data.v_y = str2double(get(handles.v_y,'String'));
    handles.data.u = handles.data.v_x.*ones(size(handles.data.x,1),size(handles.data.y,2));
    handles.data.v = handles.data.v_y.*ones(size(handles.data.x,1),size(handles.data.y,2));
    handles.data.psi = handles.data.u.*handles.data.y + handles.data.v.*handles.data.x;
    handles.data.phi = -handles.data.u.*handles.data.x - handles.data.v.*handles.data.y;
    cla(handles.axes_flow);
    colorbar('off');
    guidata(hObject, handles);

