% FigureHandler Demo script
close all;clear all

% create two figure handler objects
% this one will contain figures with default properties/formatting
these_figs=FigureHandler;
% this one will contain figures for a presentation with slighly nicer
% formatting: a white background, out-facing tick marks.
other_figs=FigureHandler('presentation');
% presentation is now the default for ALL figures created by other_figs

% create new figures (silently!)
these_figs.new('bar')
these_figs.new('foo')
other_figs.new('fancy!')
other_figs.new('yay formatting!')

x=-10:0.1:10;

% list figures
these_figs
these_figs.whos();

other_figs
other_figs.whos();

% plot to figure axes (nothing special here)
plot(these_figs.get_axes('foo'),x,x.^3,'r');
plot(these_figs.get_axes('foo'),x,x.^2,'b');
title(these_figs.get_axes('foo'),'Polynomials!')
xlabel(these_figs.get_axes('foo'),'x axis');
ylabel(these_figs.get_axes('foo'),'y axis');

plot(these_figs.get_axes('bar'),x,sin((pi/10)*x),'k');
plot(these_figs.get_axes('bar'),x,sin((3*pi/10)*x),'r');
title(these_figs.get_axes('bar'),'Sinusoids!');
xlabel(these_figs.get_axes('bar'),'x axis');
ylabel(these_figs.get_axes('bar'),'y axis');

plot(other_figs.get_axes('fancy!'),x,x.^3,'r');
plot(other_figs.get_axes('fancy!'),x,x.^2,'b');
title(other_figs.get_axes('fancy!'),'Polynomials!')
xlabel(other_figs.get_axes('fancy!'),'x axis');
ylabel(other_figs.get_axes('fancy!'),'y axis');

plot(other_figs.get_axes('yay formatting!'),x,sin((pi/10)*x),'k');
plot(other_figs.get_axes('yay formatting!'),x,sin((3*pi/10)*x),'r');
title(other_figs.get_axes('yay formatting!'),'Sinusoids!');
xlabel(other_figs.get_axes('yay formatting!'),'x axis');
ylabel(other_figs.get_axes('yay formatting!'),'y axis');

% oh wait! I wanted another figure! 
% I want this figure to have presentation formatting
these_figs.new('fancy baz','presentation');
plot(these_figs.get_axes('fancy baz'),x,rand(1,length(x)),'k');
% and this one to have the figure handler default.
these_figs.new('baz')
plot(these_figs.get_axes('baz'),x,rand(1,length(x)),'k');

% show a selection of figures
these_figs.show('bar','baz')

% show all figures
these_figs.show()
other_figs.show('fancy!','yay formatting!')
% MATLAB will save invisible figures invisibly
% this is not particularly useful, so make sure you show your figures 
% before you save them!

% save baz and foo only as a .fig
these_figs.save('./sample_figures','fig','baz','foo')
% save all as eps
these_figs.save('./sample_figures','eps')

% uncomment to close some or all figures;
%these_figs.close()
%other_figs.close()