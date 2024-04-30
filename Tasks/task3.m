%% Basic example
t = [0:0.1:2*pi];
y = sin(t);
plot(t,y);
ax = gca;
exportgraphics(ax, "Data/sine.png")

%% Weather example
jason = webread("https://api.weather.gov/gridpoints/BOX/62,85/forecast/hourly");

% Build Timetable
T = struct2table(jason.properties.periods);
time = datetime(T.startTime,"InputFormat","uuuu-MM-dd'T'HH:mm:ssssZZZZZ","TimeZone","America/New_York");
temperature = T.temperature;
TT = timetable(time,temperature);

% Plot data over time
plot(TT.time,TT.temperature);
ax = gca;
title(ax,"Weather in Natick")
exportgraphics(ax, "Data/weather.png")
