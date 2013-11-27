classdef FigureHandler < handle
    properties
        figs = dict;
    end
    methods
        function new(obj,name)
            fig = cfigure(name);
            obj.figs.set_value(name,fig);
        end
        function map(obj,fn,args)
            for i=1:obj.figs.len
                h = obj.figs.values{i};
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
        function show(obj)
            obj.map('show',{})
        end
        function hide(obj)
            obj.map('hide',{})
        end
        function save(obj,path,format)
            obj.map('save',{path,format});
        end
        function save_mult(obj,path,formats)
            obj.map('save_mult',{path,formats});
        end
    end
    
end