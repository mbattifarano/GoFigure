classdef dict < handle
    properties
        keys = cell(1,0);
        values = cell(1,0);
    end
    methods
        function N = len(obj)
            N=length(obj.keys);
        end
        function index = find_key(obj,name)
            cellfind=@(string)(@(el)(strcmp(string,el)));
            try
            index=find(cellfun(cellfind(name),obj.keys));
            catch
                keyboard
            end
        end 
        function TF = is_key(obj,name)
            TF = ~isempty(obj.find_key(name));
        end
        function value = get_value(obj,key)
            index = obj.find_key(key);
            value = obj.values{index};
        end
        function set_value(obj,key,value)
            if obj.is_key(key)
                index = obj.find_key(key);
            else
                index = obj.len()+1;
            end
            obj.keys{index}=key;
            obj.values{index}=value;
        end
        function extend(obj,dict_obj)
            for i=1:dict_obj.len()
                key = dict_obj.keys{i};
                value = dict_obj.values{i};
                obj.set_value(key,value);
            end
        end
        function del(obj,varargin)
            if isempty(varargin{:})
                target_keys=obj.keys;
            else
                target_keys=varargin;
            end
            for i=1:length(target_keys)
                index=obj.find_key(target_keys{i});
                obj.keys(index)=[];
                obj.values(index)=[];
            end
        end
    end
end