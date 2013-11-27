close all;clear all
FIGS=FigureHandler;

FIGS.new('bar')
%FIGS.get_cfig('bar')
FIGS.new('foo')
%FIGS.get_cfig('foo');

x=-10:0.1:10;

FIGS.whos();

plot(FIGS.get_axes('foo'),x,x.^3,'r');
plot(FIGS.get_axes('foo'),x,x.^2,'b');
title(FIGS.get_axes('foo'),'Polynomials!')
xlabel(FIGS.get_axes('foo'),'x axis');
ylabel(FIGS.get_axes('foo'),'y axis');

plot(FIGS.get_axes('bar'),x,sin((pi/10)*x),'k');
plot(FIGS.get_axes('bar'),x,sin((3*pi/10)*x),'r');
title(FIGS.get_axes('foo'),'Sinusoids!');
xlabel(FIGS.get_axes('foo'),'x axis');
ylabel(FIGS.get_axes('foo'),'y axis');

FIGS.show()
FIGS.save('.','fig')