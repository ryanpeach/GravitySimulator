%Simulates the Inner Solar System + Moon
%% Constants
MAX = input('How many days total? ');
SPEED = input('How many days/calculation? ');

t0=2456196.500000000; %A.D. 2012-Sep-26 00:00:00.0000 (CT)

%% Initial Planetary Conditions
Position = [-1.870576170280912E-03 -2.276808706888534E-03 -2.947659524976667E-05        %Sun
    9.991843644789098e-01  5.256748194334550e-02 -3.549380938721226e-05                 %Earth
    1.000936051715352E+00  5.072525452541421E-02  1.850338492920425E-04]                 %Moon
    
    

Velocity = [5.871440957897098E-06  -2.377998352013915E-06  -1.270032360750062E-07       %Sun
    -1.220554367621907e-03   1.710719485202113e-02  -8.176990466583196e-07              %Earth
    -7.755041107857262E-04   1.750144788676796E-02   1.375933881464000E-05]              %Earth's Moon

    

Mass = [1.9884e+30, 5.972*10^24, 7.3459*10^22]

%% Run
axis=[-2,2,-2,2,-.2,.2];
Gravity2(Position,Velocity,Mass,SPEED,MAX,axis);