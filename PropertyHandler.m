classdef PropertyHandler < handle
    %PROPERTYHANDLER Halds the figure and axes properties of a figure
    %   
    properties
        figure
        axes
    end
    properties (SetAccess = private)
        readonly=struct('figure', {{'BeingDeleted','Children',...
                                    'CurrentAxes','CurrentCharacter',...
                                    'CurrentObject','Type'}},...
                        'axes'  , {{'BeingDeleted','Children',...
                                    'CurrentPoint','Parent',...
                                    'TightInset','Title','Type',...
                                    'XLabel','YLabel','ZLabel'}});
        default_profile = 'default'
    end
    methods
        function prophandler = PropertyHandler(fixed_props,profile)
            if nargin == 1
                profile = prophandler.default_profile;
            end
            prophandler.readonly.figure = horzcat(fixed_props',...
                                           prophandler.readonly.figure);
            props = load(['profiles/' profile '.mat']);
            prophandler.figure = rmfield(props.figure,...
                                   prophandler.readonly.figure);
            prophandler.axes   = rmfield(props.axes,...
                                   prophandler.readonly.axes);
            
        end
    end
    
end

