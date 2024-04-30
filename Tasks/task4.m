%% Basic example
t = [0:0.1:2*pi];
y = sin(t);
plot(t,y);
ax = gca;
exportgraphics(ax, "Data/sine.png")