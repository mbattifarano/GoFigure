classdef FigureHandler < handle
    properties
        figs
        verbosity
    end
    properties (SetAccess = private)
        default_profile
    end
    methods
        function FH = FigureHandler(default_profile)
            if nargin == 0
                FH.default_profile = 'default';
            else
                FH.default_profile = default_profile; 
            end
            FH.figs = Dictionary;
            FH.verbosity = 0;
        end
        function new(obj,name,profile)
            dbprint(obj.verbosity==1,'Creating new figure...')
            if nargin == 2
                profile = obj.default_profile;
            end
            dbprint(obj.verbosity==1,'Creating cFigure object...');
            f = cfigure(name,profile);
            dbprint(obj.verbosity==1,'Adding cFigure to dictionary...');
            obj.figs.set(name,f);
        end
        function map(obj,target_keys,fn,args)
            if isempty(target_keys)
                target_keys=obj.figs.get_Keys;
            end
            for i=1:length(target_keys)
                h = obj.figs.get(target_keys{i});
                dbprint(obj.verbosity==1,obj.figs.get_Keys{i});
                h.(fn)(args{:})
            end
        end
        function whos(obj)
            obj.figs.display
        end
        function cfig_obj = get_cfig(obj,name)
            cfig_obj = obj.figs.get(name);
        end
        function axis_handle = get_axes(obj,name)
            cfig = obj.get_cfig(name);
            axis_handle = cfig.Hax;
        end
        function figure_handle = get_fig(obj,name)
            cfig = obj.get_cfig(name);
            figure_handle = cfig.Hfg;
        end
        function append(obj,cfig_obj)
            obj.figs.set(cfig_obj.name,cfig_obj);
        end
        function extend(obj,fighandler)
            new_keys=fighandler.figs.get_Keys;
            for i=1:length(new_keys)
                new_key=new_keys{i};
                obj.figs.set(new_key,fighandler.figs.get(new_key))
            end
        end
        % extensions of cfig methods
        function show(obj,varargin)
            obj.map(varargin,'show',{})
        end
        function hide(obj,varargin)
            obj.map(varargin,'hide',{})
        end
        function save(obj,path,format,varargin)
            obj.map(varargin,'show',{})
            obj.map(varargin,'save',{path,format});
        end
        function save_mult(obj,path,formats,varargin)
            obj.map(varargin,'save_mult',{path,formats});
        end
        function close(obj,varargin)
            obj.map(varargin,'close',{})
            obj.figs.clear(varargin);
        end
    end
end