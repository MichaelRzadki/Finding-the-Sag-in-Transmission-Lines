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
