%% Electromagnetic Field Strength 
 
%% Variables
 
I1 = 1370; %Ampacity of Eagle 
I2 = 1499; %Ampacity of Egret
u0=9e-12; %Permittivity or Free Space m^-3 kg^-1 s^4 A^2
r=20:300; %Range of distance from transmission cable in meters 
 
%% Calculation for Eagle and Egret
B1 = (u0*I1)/(2*pi*r); 
B2 = (u0*I2)/(2*pi*r);
 
%% Graph for Eagle and Egret
plot (r,B1);
hold on
plot (r,B2);
hold off
legend;
xlabel('Distance from cable (m)');
ylabel('Magnetic Field strength (T)'); 
 
 
%% Range of Current from Minimum to Max Current Graph Plot
 
hold on
for I = [750 850 950] %Current range in Toronto Low to High
    B = (u0.*I)./(2.*pi.*r); 
    plot (r,B);
end
legend('Eagle','Egret','Minimum Current Drawn','Avg Current Drawn','Max Current Drawn')

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
    
    %% Finding Temperature of Conducter
    %% Shared Variables
h = 10;             % Coefficient of convective heat transfer [W/m^2K]
o = 5.67*(10^-8);   % Stefan-Boltzmann constant [W/(m^2)(K^4)]   
e = 0.05;           % Emissivity coefficient of the conductor
a = 0.20;           % Absorptivity coefficient of the conductor
Gs = 1200;          % Solar irradiance [W/m^2]

%% Eagle Cable
for I = 0:2:734 % Possible values for current
    D = 0.02422;    % Conductor diameter of 7 strand steel core cable (Eagle) [m]
    R = 1.023*(10^-4);  % Resistivity of the conductor per unit length [Ohms/m]
    for Ti = -45:85:40  % Model at -45 and 40 degrees celcius to get the range of posiible ambient temperatures
        F = @(T) (h*pi*D*(T-Ti)) + (o*e*pi*D*((T^4)-(Ti^4))) - (a*D*Gs) - ((I^2)*R);
        Temp = fzero(F,1);  % Solves for internal temperature
        P1 = plot (I,Temp,'.r','markersize',10);  % Plots current vs internal temperature
        hold on;
    end
end

%% Egret Cable
for I = 0:2:798 % Possible values for current
    D = 0.02590;    % Conductor diameter of 7 strand steel core cable (Egret) [m]
    R = 8.955*(10^-5);  % Resistivity of the conductor per unit length [Ohms/m]
    for Ti = -45:85:40
        F = @(T) (h*pi*D*(T-Ti)) + (o*e*pi*D*((T^4)-(Ti^4))) - (a*D*Gs) - ((I^2)*R);
        Temp = fzero(F,1);
        P2 = plot (I,Temp,'.b','markersize',10);
        hold on;
    end
end

%% Plot Properties
title ('Cable Temperature Analysis')
xlabel ('Current (A)')
ylabel ('Internal Temperature (C)')
legend ([P1,P2],'Eagle','Egret')


%% Maximum sag of The Egret cable

%% Variables (Egret)
A=0.0003958; %cross sectional area of the wire in metres squared (m^2)
w= 1.469; %mass per unit length of the bare wire, in kg/m
s=290; %span in metres
Ho=(141*1000)*(0.2);%initial tension
alpha= 5e-6;%the thermal coefficient 
% where r is the ratio of aluminum to steel in the cable
E=8e10; %elastic modulus in Pa
To=15; %initial temp in C
T=104.8; %final temp in C
%% Solving for Horizontal Tension (H) (Egret)
for T=To:1:T
for w=w:1:14.29
a = (1 + (w^2)*(s^2)/(24*Ho^2))*(1 + alpha*(T-To))*(1/(E*A));
b = (1 + (w^2)*(s^2)/(24*Ho^2))*(1 + alpha*(T-To))*(1-(Ho/(E*A)))-1;
c = ((w^2)*(s^2))/24;
d = [a, b, 0, -c];
H= min(roots(d));
%% Solving for the Length of the Cable at Horizontal Tension (H) (Egret)
L= (1+(alpha*(T-To)))*(s+((w^2)*(s^3)/(24*(Ho^2))))*(1+((H-Ho)./(E*A)));
%% Solving for and Plotting Maximum Sag (Egret)
D=sqrt(((3*s)*(L-s))/8);
hold on
plot(T,D,'b')
xlabel('Temperature (C)')
ylabel('Maximum Sag (m)')
title('Temperature Vs. Maximum Sag ')
axis([16 120 0 9])
end
end 

%% Maximum Sag of The Eagle

%% Variables (Eagle)
A=0.0003478; %cross sectional area of the wire in metres squared (m^2)
w= 1.296; %small wire mass per unit length of the bare wire, in kg/m
W=13.93; %maximum mass per unit length of the bare wire, in kg/m
s=290; %span in metres
Ho=(120*1000)*(0.2);%initial tension
alpha= 5e-6;%the thermal coefficient
E=8e10; %elastic modulus in Pa
To=15; %initial temp in C
T=117; %final temp in C
%% Solving for Horizontal Tension (H) (Eagle)
for T=To:1:T
for w=w:1:13.93
a = (1 + (w^2)*(s^2)/(24*Ho^2))*(1 + alpha*(T-To))*(1/(E*A));
b = (1 + (w^2)*(s^2)/(24*Ho^2))*(1 + alpha*(T-To))*(1-(Ho/(E*A)))-1;
c = ((w^2)*(s^2))/24;
d = [a, b, 0, -c];
H= min(roots(d));
%% Solving for the Length of the Cable at Horizontal Tension (H) (Eagle)
L= (1+(alpha*(T-To)))*(s+((w^2)*(s^3)/(24*(Ho^2))))*(1+((H-Ho)./(E*A)));

%% Solving for and Plotting Maximum Sag (Eagle)
D=sqrt(((3*s)*(L-s))/8);
hold on
plot(T,D,'r')

%% Setting up the Aesthetics of the Plot
xlabel('Temperature (C)')
ylabel('Maximum Sag (m)')
title('Temperature (C) Vs. Maximum Sag (m)')
axis([16 120 0 9])
legend('Eagle','Egret') 
end
end