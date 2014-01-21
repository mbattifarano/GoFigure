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
            this_file_path = mfilename('fullpath');
            end_index = find(this_file_path=='/',1,'last');
            module_root = this_file_path(1:end_index);
            
            prophandler.readonly.figure = horzcat(fixed_props',...
                                           prophandler.readonly.figure);
            props = load([ module_root 'profiles/' profile '.mat']);
            prophandler.figure = rmfield(props.figure,...
                                   prophandler.readonly.figure);
            % If FigureHandler.new hangs it might be due to problems with X
            % this line removes it from the propertyhandler
            if isfield(prophandler.figure,'XDisplay')
            prophandler.figure = rmfield(prophandler.figure,'XDisplay');
            end
            prophandler.axes   = rmfield(props.axes,...
                                   prophandler.readonly.axes);
        end
    end
end

