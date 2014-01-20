function [ output_args ] = dbprint(toggle, message)
%DBPRINT prints message if toggle is true
if toggle
    disp(message);
end
end

