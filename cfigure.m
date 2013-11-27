classdef cfigure
    properties
       Hfg
       Hax
       name
    end
    methods
        function fig_obj = cfigure(name)
            fig_obj.Hfg  = figure('visible','off','name',name,'NumberTitle','off');
            fig_obj.Hax  = axes;
            fig_obj.name = name;
            hold on
        end
        function string = get_title(obj)
            string = get(get(obj.Hax,'title'),'string');
            disp(string)
            string = strrep(string,' ','-');
            string = strrep(string,'\','');
            string = strrep(string,'.','-');
        end
        function save(obj,path,format)
            saveas(obj.Hfg,[ path '/' obj.name '.' format],format);
        end
        function save_mult(obj,path,formats)
            for i=1:length(formats)
                obj.save(path,formats{i});
            end
        end
        function show(obj)
            set(obj.Hfg,'visible','on');
        end
        function hide(obj)
            set(obj.Hfg,'visible','off');
        end
        function set_axis(obj,args)
            set(obj.Hax,args{:});
        end
        function set_fig_prop(obj,args)
            set(obj.Hfg,args{:});
        end
    end
end