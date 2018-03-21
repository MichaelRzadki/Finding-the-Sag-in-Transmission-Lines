%% How Wind Speed and Ice buildup effect the Wire Load of Eagle

%% Setting up Variables
Dc=0.0242; %the diameter of the cable(m)
p=1.247; %average denisty of air in (kg/m^3)
Cd=1; %drag constant 
g=9.81; %the acceleration due to graivty in (m/s^2)
wc=1.296; %weight of cable without ice buildup (kg/m)
%% Equations for weight of ice buildup, wind velocity, and combined
for v=0:5:30 % the wind velocity impacting the transmission line in (m/s^2)
  t=0.001:0.001:0.05; % the thickness of the ice buildup in (m)
     
    wind= p.*v.^2.*Cd.*(Dc+2.*t)./(2.*g); %in (kg/m)
    fprintf('the additional load from wind is %.2f(kg/m)\n',wind)
 
    wice=((916.8).*((Dc+2*t).^2-Dc.^2)*pi)./4; %in (kg/m)
    fprintf('the buildup of ice of the cable is %.2f(kg/m)\n',wice)
 
    Combined=sqrt(((wc+wice).^2+(wind).^2)); %in(kg.m)
    fprintf('the combined load of the wire icluding icebuildup and wind is %.2f(kg/m)\n',Combined)
    
    plot(t,Combined,'markersize',1)
    hold on 
    
 end
%% Plotting Graph
    title('Load on The Cable with Various Ice Buildup and Wind Speeds:Eagle')
    legend('Wind speed 0m/s','Wind speed 5m/s','Wind speed 10m/s','Wind speed 15m/s','Wind speed 20m/s','Wind speed 25m/s','Wind speed 30m/s')
    ylabel('Weight Load(kg/m)')
    xlabel('Ice Thickness(Kg/m)')