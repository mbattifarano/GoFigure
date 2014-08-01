classdef cfigure 
    properties
       Hfg
       Hax
       name
       prop
       exists
       verbosity
    end
    methods
        function fig_obj = cfigure(name,profile)
            global VERBOSE;
            if nargin == 1
                profile  = 'default';
            end
            fig_obj.verbosity = VERBOSE;
            dbprint(fig_obj.verbosity==1,...
                    'Generating initial figure settings...')
            fig_init     = struct('Visible'     , 'off' , ...
                                  'Name'        , name  , ...
                                  'NumberTitle' , 'off' );
            init_fields    = fieldnames(fig_init);
            dbprint(fig_obj.verbosity==1,'Creating MATLAB figure...')
            fig_obj.Hfg    = figure(fig_init);
            dbprint(fig_obj.verbosity==1,'Updating cFigure attibutes...')
            fig_obj.exists = true;
            fig_obj.Hax  = axes;
            fig_obj.name = name;
            dbprint(fig_obj.verbosity==1,'Initializing PropertyHandler...')
            fig_obj.prop = PropertyHandler(init_fields,profile);
            
            dbprint(fig_obj.verbosity==1,...
                'Setting figure and axes handles...');
            set(fig_obj.Hfg,fig_obj.prop.figure);
            set(fig_obj.Hax,fig_obj.prop.axes);
            
            dbprint(fig_obj.verbosity==1,'Setting hold on...');
            hold on
        end
        function string = as_filename(obj,string)
            string = strrep(string,' ','-');
            string = strrep(string,'\','');
            string = strrep(string,'.','-');
        end
        function string = get_title(obj)
            try
                string = get(get(obj.Hax,'title'),'string');
                string = obj.as_filename(string);
            catch
                string = '';
            end
        end
        function save_(obj,path,format)
            title_string = obj.get_title;
            if iscell(title_string)
                title_string = title_string{1};
            end
            if ~isempty(title_string)
                title_string = ['-' title_string];
            end
            filename = [ path '/' obj.as_filename(obj.name) title_string ];
            dbprint(obj.verbosity==1,...
                ['Saving ' filename '.' format]);
            switch format
                case 'fig'
                    saveas(obj.Hfg,filename,format);
                case 'pdf'
                    % fix so that pdf contains whole figure;
                    set(obj.Hfg,'Units','Inches');
                    pos = get(obj.Hfg,'Position');
                    set(obj.Hfg,'PaperPositionMode','Auto',...
                                'PaperUnits','Inches',...
                                'PaperSize',[pos(3), pos(4)]);
                    
                    print(obj.Hfg,filename,'-dpdf','-r0');
                otherwise
                print(obj.Hfg,['-d' format],filename);
            end
        end
        function save_mult(obj,path,formats)
            for i=1:length(formats)
                obj.save_(path,formats{i});
            end
        end
        function save(obj,path,formats)
            if iscell(formats)
                obj.save_mult(path,formats);
            else
                obj.save_(path,formats)
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