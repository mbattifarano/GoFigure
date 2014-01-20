GoFigure!
=============

Matt Battifarano 
2013

GoFigure! is designed to handle MATLAB figures so that creating, 
saving, and viewing is as simple and organized as possible.

GoFigure! was developed with MATLAB R2013a on Ubuntu 12.04. I have NOT tested it
on any other version of MATLAB under any other operating system.

There are three class definitions:

  (1) cfigure 	      - Initializes an invisible figure and holds onto its  
                        figure and axis handles.

  (2) FigureHandler   - Initializes and stores cfigure instances.

  (3) PropertyHandler - Stores Axis and Figure properties.

  (3) Dictionary  	  - A simple dictionary implementation written by
                        Daniel Wirtz (http://www.mathworks.com/matlabcentral/fileexchange/33901-dictionary-data-structure/content/Dictionary.m)
                        used by FigureHandler to store the cfigure objects.
                        I have added public functions to list the keys and 
                        values.

Each instance of the class FigureHandler keeps track of the axis and figure
handles (via the cfigure class) of every figure created by it. Multiple 
instances of the FigureHandler class can be used to group figures. 

Most importantly, figures created as a cfigure instance
are created silently, that is, they are initialized with the 'visible' 
property set to 'off'. This means that figures will NOT steal focus when 
they are created. Since each instance of FigureHandler keeps tabs on all 
its figures, it can easily show or hide figures attached to it at any time.

FigureHandler initializes a new instance of the cfigure class each time it 
creates a new figure using the new(figure_name) method. The cfigure class 
contains both the axis and figure handles as well as a few methods to show, 
hide, save, and close the figure.
  
cfigure instances created by a FigureHandler instance are stored in a 
dictionary structure using the figure name as the keys. Using meaningful 
figure names when initializing new figures means that axes handles can be 
retrieved from the FigureHandler instances in a clear and organized way.

The PropertyHandler class is a thin wrapper over the structs returned by 
get(figure_handle) and get(axis_handle). There are a few fields in the 
raw struct that cause errors if they are subsequently passed to set. 
MATLAB refers to these as read only properties. PropertyHandler removes 
these fields from its representation of figure and axis properties so that 
the set function will work. 

Importantly, the PropertyHandler class allows one to create `profiles' of 
frequently used settings. These are stored as mat files in the profiles 
directory. Each mat file contains figure and axis property structs. 
'default.mat' is the MATLAB default. 'presentation.mat' is an example of my
own design.

Further improvements may include more robust handling of properties. There 
are a number of properties beyond figure and axis properties (axis label 
properties for example) that are not currently accessible via the 
PropertyHandler.

Additionally, FigureHandler is not aware when or how the user interacts 
with the figure via the GUI. This is problematic when the user closes the 
figure becuase the FigureHandler currently has no way of knowing that the
figure has been closed and is still storing the now-invalid handles.
This problem in particular can probably be solved by specifying an appropriate
DeleteFcn property. However, it would also be nice to more robustly treat user
interactions.
