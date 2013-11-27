SMART FIGURES
=============

Matt Battifarano 2013

Smart Figures is designed to handle MATLAB figures so that creating, saving,
and viewing is as simple as possible.

There are three class definitions:

  (1) cfigure 	    - Initializes an invisible figure and holds onto its figure 
		        and axis handles.
  (2) FigureHandler - Initializes and stores cfigure instances.
  (3) dict  	    - A simple dictionary implementation used by FigureHandler
			to store the cfigure objects. 

Each instance of the class FigureHandler keeps track of the axis and figure
handles (via the cfigure class) of every figure created by it. Multiple 
instances of the FigureHandler class can be used to group figures. 

Most importantly, figures created by a FigureHandler instance
are created silently, that is, they are initialized with the 'visible' 
property set to 'off'. This means that figures will NOT steal focus when they 
are created. Since each instance of FigureHandler keeps tabs on all its 
figures, it can easily show or hide figures attached to it at any time.

FigureHandler initializes a new instance of the cfigure class each time it 
creates a new figure using the new(figure-name) method. The cfigure class 
contains both the axis and figure handles as well as a few methods to show, 
hide, save, and close the figure.
  
cfigure instances created by a FigureHandler instance are stored in a 
dictionary structure using the figure name as the keys. Using meaningful 
figure names when initializing new figures means that axes handles can be 
retrieved from the FigureHandler instances in a clear and organized way.

Further improvements may include a class for generating a particular 
configuration of figure and/or axes properties that could be given to the 
FigureHandler class to save time formatting figures.
