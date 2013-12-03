close all;clear all
FIGS=FigureHandler;

% create new figures (silently!)
FIGS.new('bar')
FIGS.new('foo')

x=-10:0.1:10;

% list figures
FIGS.whos();

% plot to figure axes (nothing special here)
plot(FIGS.get_axes('foo'),x,x.^3,'r');
plot(FIGS.get_axes('foo'),x,x.^2,'b');
title(FIGS.get_axes('foo'),'Polynomials!')
xlabel(FIGS.get_axes('foo'),'x axis');
ylabel(FIGS.get_axes('foo'),'y axis');

plot(FIGS.get_axes('bar'),x,sin((pi/10)*x),'k');
plot(FIGS.get_axes('bar'),x,sin((3*pi/10)*x),'r');
title(FIGS.get_axes('bar'),'Sinusoids!');
xlabel(FIGS.get_axes('bar'),'x axis');
ylabel(FIGS.get_axes('bar'),'y axis');

% oh wait! I wanted another figure!
FIGS.new('baz')
plot(FIGS.get_axes('baz'),x,rand(1,length(x)),'k');

% show a selection of figures
FIGS.show('bar','baz')

% show all figures
FIGS.show()
% MATLAB will save invisible figures invisibly
% this is not particularly useful, so make sure you show your figures before you
% save them.

% save baz and foo only as a .fig
FIGS.save('./sample_figures','fig','baz','foo')
% save all as eps
FIGS.save('./sample_figures','eps','baz','foo')

% uncomment to close some or all figures;
%FIGS.close()