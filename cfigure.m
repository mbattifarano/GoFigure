classdef cfigure 
    properties
       Hfg
       Hax
       name
       prop
       exists
    end
    methods
        function fig_obj = cfigure(name,profile)
            if nargin == 1
                profile  = 'default';
            end
            fig_init     = struct('Visible'     , 'off' , ...
                                  'Name'        , name  , ...
                                  'NumberTitle' , 'off' );
            init_fields    = fieldnames(fig_init);
            fig_obj.Hfg    = figure(fig_init);
            fig_obj.exists = true;
            fig_obj.Hax  = axes;
            fig_obj.name = name;
            fig_obj.prop = PropertyHandler(init_fields,profile);
            
            set(fig_obj.Hfg,fig_obj.prop.figure);
            set(fig_obj.Hax,fig_obj.prop.axes);

            hold on
        end
        function string = get_title(obj)
            string = get(get(obj.Hax,'title'),'string');
            string = strrep(string,' ','-');
            string = strrep(string,'\','');
            string = strrep(string,'.','-');
        end
        function save(obj,path,format)
            title_string = obj.get_title;
            if isempty(title_string)
                title_string = [obj.name ' - untitled'];
            end
            saveas(obj.Hfg,[ path '/' title_string '.' format],format);
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
        function close(obj)
            close(obj.Hfg)
        end
    end
end