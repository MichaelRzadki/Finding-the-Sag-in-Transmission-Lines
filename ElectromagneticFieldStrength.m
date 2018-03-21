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