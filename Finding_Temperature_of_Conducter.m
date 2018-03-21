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
