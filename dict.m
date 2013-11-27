classdef dict < handle
    properties
        keys = {};
        values = {};
    end
    methods
        function N = len(obj)
            N=length(obj.keys);
        end
        function index = find_key(obj,name)
            cellfind=@(string)(@(el)(strcmp(string,el)));
            index=find(cellfun(cellfind(name),obj.keys));
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
    end
end