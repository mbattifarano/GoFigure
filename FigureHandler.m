classdef FigureHandler < handle
    properties
        figs = dict;
    end
    methods
        function new(obj,name)
            fig = cfigure(name);
            obj.figs.set_value(name,fig);
        end
        function map(obj,target_keys,fn,args)
            if isempty(target_keys)
                target_keys=obj.figs.keys;
            end
            for i=1:length(target_keys)
                h = obj.figs.get_value(target_keys{i});
                %disp(obj.figs.keys{i});
                h.(fn)(args{:})
            end
        end
        function list = whos(obj)
            list = obj.figs.keys;
            disp(' Figures:')
            for i=1:obj.figs.len
                disp(['     ' list{i}]);
            end
        end
        function cfig_obj = get_cfig(obj,name)
            cfig_obj = obj.figs.get_value(name);
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
            obj.figs.set_value(cfig_obj.name,cfig_obj);
        end
        function extend(obj,fighandler)
            obj.figs.extend(fighandler.figs);
        end
        % extensions of cfig methods
        function show(obj,varargin)
            obj.map(varargin,'show',{})
        end
        function hide(obj,varargin)
            obj.map(varargin,'hide',{})
        end
        function save(obj,path,format,varargin)
            obj.map(varargin,'save',{path,format});
        end
        function save_mult(obj,path,formats,varargin)
            obj.map(varargin,'save_mult',{path,formats});
        end
        function close(obj,varargin)
            obj.map(varargin,'close',{})
            obj.figs.del(varargin);
        end
    end
end